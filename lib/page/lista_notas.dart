import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:racao_av/helper.dart/anotacao_helper.dart';
import 'package:racao_av/model/anotacao.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: must_be_immutable
class ListaAv722 extends StatefulWidget {
  int valor;
  ListaAv722({Key? key, required this.valor}) : super(key: key);

  @override
  State<ListaAv722> createState() => _ListaAv722State();
}

class _ListaAv722State extends State<ListaAv722> {
  final _db = AnotacaoHelper();
  List<Anotacao> _listaNotas = [];
  int total = 0;

  _removerNota(int id) async {
    await _db.removeNota(id);
    //_recuperarAnotacoes();
  }

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperaNotasAviarios(widget.valor);
    List<Anotacao> listaTemporaria = [];
    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }
    setState(() {
      _listaNotas = listaTemporaria;
    });

    //print("recuperar anotacoes: $anotacoesRecuperadas");
  }

  _somaTotalRacao() async {
    List anotacoesRecuperadas = await _db.recuperaNotasAviarios(widget.valor);
    List<Anotacao> listaTemporaria = [];
    total = 0;
    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }
    for (var lista in listaTemporaria) {
      total += lista.quantidade;
    }
    return total;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarAnotacoes();
    _somaTotalRacao();
  }

  _formatarData(String data) {
    initializeDateFormatting("pt_BR");
    var formatador = DateFormat("dd/MM/yyyy");
    //converte data(string) em um tipo datetime
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);
    return dataFormatada;
  }

  _mostraTotalRacao() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Total Ração Consumida'),
            content: Card(
              child: Text(
                '$total Kg',
                style: const TextStyle(fontSize: 25),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //final numeroAviario = _listaNotas[0].numeroAv;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista ração aviário ${widget.valor}'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _listaNotas.length,
                itemBuilder: (context, index) {
                  final lista = _listaNotas[index];
                  return Card(
                      child: Dismissible(
                    background: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    //direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        _removerNota(lista.id!);
                      } else if (direction == DismissDirection.startToEnd) {}
                    },
                    key: Key(index.toString()),
                    child: ListTile(
                      title: Text(
                        "${_formatarData(lista.data)} -     ${lista.tipoRacao}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${lista.quantidade} Kg",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        "Numero Av: ${lista.numeroAv}",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ));
                }),
          ),
          //ElevatedButton(onPressed: () {}, child: const Text('Total Ração'))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          _somaTotalRacao();
          _mostraTotalRacao();
        },
        label: const Text(
          'Total',
          style: TextStyle(letterSpacing: 0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
