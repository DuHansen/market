import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:market/models/moeda.dart';

class MoedaHiveAdapter extends TypeAdapter<Moeda> {
  @override
  final typeId = 0;

  @override
  Moeda read(BinaryReader reader) {
    return Moeda(
      icone: reader.readString(),
      nome: reader.readString(),
      sigla: reader.readString(),
      preco: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Moeda obj) {
    writer.writeString(obj.icone);
    writer.writeString(obj.nome);
    writer.writeString(obj.sigla);
    writer.writeDouble(obj.preco);
  }
}
