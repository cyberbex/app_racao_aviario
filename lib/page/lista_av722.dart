import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:racao_av/helper.dart/anotacao_helper.dart';
import 'package:racao_av/model/anotacao.dart';
import 'package:intl/date_symbol_data_local.dart';

class ListaAv722 extends StatefulWidget {
  const ListaAv722({Key? key}) : super(key: key);

  @override
  State<ListaAv722> createState() => _ListaAv722State();
}

class _ListaAv722State extends State<ListaAv722> {
  final _db = AnotacaoHelper();
  List<Anotacao> _listaAv722 = [];

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();
    List<Anotacao> listaTemporaria = [];
    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }
    setState(() {
      _listaAv722 = listaTemporaria;
    });

    print("recuperar anotacoes: $anotacoesRecuperadas");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarAnotacoes();
  }

  _formatarData(String data) {
    initializeDateFormatting("pt_BR");
    var formatador = DateFormat("dd/MM/yyyy");
    //converte data(string) em um tipo datetime
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);
    return dataFormatada;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista ração aviário 722')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _listaAv722.length,
                itemBuilder: (context, index) {
                  final lista = _listaAv722[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        "${_formatarData(lista.data)} -     ${lista.tipoRacao}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: Text(
                        "${lista.quantidade} Kg",
                        style: const TextStyle(fontSize: 25),
                      ),
                      subtitle: Text(
                        "Numero Av: ${lista.numeroAv}",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
