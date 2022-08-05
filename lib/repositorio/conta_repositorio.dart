import 'package:flutter/cupertino.dart';
import 'package:market/database/db.dart' show DB;
import 'package:market/models/posicao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:market/models/moeda.dart';
import 'package:market/repositorio/repository.dart';

class ContaRepository extends ChangeNotifier {
  late Database db;
  List<Posicao> _carteira = [];
  double _saldo = 0;

  get saldo => _saldo;
  List<Posicao> get carteira => _carteira;

  ContaRepository() {
    _initRepository();
  }
  _initRepository() async {
    await _getSaldo();
  }

  _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;
    notifyListeners();
  }
}

comprar(Moeda moeda, double valor) async {
  var db = await DB.instance.database;
  await db.transaction((txn) async {
    // Verificar se a moeda já foi comprada
    final posicaoMoeda = await txn.query(
      'carteira',
      where: 'sigla = ?',
      whereArgs: [moeda.sigla],
    );
    // Se não tem a moeda em carteira
    if (posicaoMoeda.isEmpty) {
      await txn.insert('carteira', {
        'sigla': moeda.sigla,
        'moeda': moeda.nome,
        'quantidade': (valor / moeda.preco).toString()
      });
    }
    // Já tem a moeda em carteira
    else {
      final atual = double.parse(posicaoMoeda.first['quantidade'].toString());
      await txn.update(
        'carteira',
        {'quantidade': (atual + (valor / moeda.preco)).toString()},
        where: 'sigla = ?',
        whereArgs: [moeda.sigla],
      );
    }
  });
}
