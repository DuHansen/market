import 'package:market/models/moeda.dart';
import 'package:market/repositorio/favoritas.dart';
import 'package:market/widgets/moeda_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FavoritasPage extends StatefulWidget {
  const FavoritasPage({Key? key}) : super(key: key);

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moedas Favoritas'),
      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Consumer<favoritas>(
          builder: (context, favo, child) {
            return favo.lista.isEmpty
                ? ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Ainda não há moedas favoritas'),
                  )
                : ListView.builder(
                    itemCount: favo.lista.length,
                    itemBuilder: (_, index) {
                      return MoedaCard(moeda: favo.lista[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
