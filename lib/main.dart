import 'package:hive_flutter/adapters.dart';
import 'package:market/config/app_settings.dart';
import 'package:market/repositorio/conta_repositorio.dart';
import 'package:market/repositorio/favoritas.dart';
import 'package:market/repositorio/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'config/hive_config.dart';
import 'meu_aplicativo.dart';
import 'package:hive/hive.dart';
import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import 'database/db.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Evitar erro de inicialização, colocar antes do run app

  await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContaRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => favoritas(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppSettings(),
        ),
      ],
      child: const MeuAplicativo(),
    ),
  );
}
