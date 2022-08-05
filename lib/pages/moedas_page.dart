import 'package:flutter/material.dart';
import 'package:market/config/app_settings.dart';
import 'package:market/pages/moedas_detalhes.dart';
import 'package:market/repositorio/repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/moeda.dart';
import '../repositorio/favoritas.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  late NumberFormat real;
  late Map<String, String> loc;
  List<Moeda> selecionadas = [];
  late favoritas favo;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
          leading: Icon(Icons.swap_vert),
          title: Text('Usar $locale'),
          onTap: () {
            context.read<AppSettings>().setLocale(locale, name);
            Navigator.pop(context);
          },
        )),
      ],
    );
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: const Text('Cripto Moedas'),
        actions: [
          changeLanguageButton(),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} Selecionadas'),
        backgroundColor: Colors.black,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        toolbarTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            MoedasDetalhesPage(moeda: moeda), //Navegação para outra pagina.
      ),
    );
  }

  limpaSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    //favo = Provider.of<favoritas>(context){

    favo = context.watch<favoritas>();
    readNumberFormat();

    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          var listTile = ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[moeda]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    width: 40,
                    child: Image.asset(MoedaRepository.tabela[moeda].icone),
                  ),
            title: Row(
              children: [
                Text(
                  tabela[moeda].nome,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                if (favo.lista.any((fav) => fav.sigla == tabela[moeda].sigla))
                  Icon(Icons.circle,
                      color: Color.fromARGB(255, 233, 174, 12), size: 8),
              ],
            ),
            trailing: Text(
              real.format(tabela[moeda].preco),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Color.fromARGB(255, 38, 64, 212),
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);
              });
            },
            onTap: () => mostrarDetalhes(tabela[moeda]),
          );
          return listTile;
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: MoedaRepository.tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favo.saveAll(selecionadas);
              },
              icon: Icon(Icons.start),
              label: Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
