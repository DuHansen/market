import 'package:market/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:market/pages/moedas_page.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cripto Moedas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(Palette.primary),
      ),
      home: const HomePage(),
    );
  }

  generateMaterialColor(primary) {}
}

class Palette {
  static const Color primary = Color.fromARGB(255, 143, 234, 7);
}
