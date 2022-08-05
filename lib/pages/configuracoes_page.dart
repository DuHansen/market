import 'package:market/config/app_settings.dart';
import 'package:market/repositorio/conta_repositorio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:market/database/db.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  @override
  Widget build(BuildContext context) {
    final conta = context.watch<ContaRepository>();
    final loc = context.read<AppSettings>().locale;

    NumberFormat real =
        NumberFormat.currency(name: loc['name'], locale: loc['locale']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: const Text('Saldo'),
              subtitle: Text(
                real.format(conta.saldo),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.indigo,
                ),
              ),
              trailing: IconButton(
                  onPressed: updateSaldo, icon: const Icon(Icons.edit)),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  updateSaldo() async {
    final _formKey = GlobalKey<FormState>();
    final valor = TextEditingController();
    final conta = context.read<ContaRepository>();

    valor.text = conta.saldo.toString();

    AlertDialog dialog = AlertDialog(
      title: const Text('Atualizar o Saldo'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: valor,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCELAR')),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              conta.setSaldo(double.parse(valor.text));
              Navigator.pop(context);
            }
          },
          child: const Text('SALVAR'),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}
