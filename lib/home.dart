import 'package:flutter/material.dart';
import 'package:racao_av/helper.dart/anotacao_helper.dart';

import 'package:racao_av/model/anotacao.dart';
import 'package:racao_av/page/lista_av722.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _numeroAvControler = TextEditingController();
  final _numeroLoteControler = TextEditingController();
  final _tipoRacaoControler = TextEditingController();
  final _dataEntregaControler = TextEditingController();
  final _quatidadeControler = TextEditingController();
  final _nomeMotoristaControler = TextEditingController();

  final _db = AnotacaoHelper();

  _exibirTelaCadastro() {
    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: const Text('Adicionar Ração'),
              content: Column(mainAxisSize: MainAxisSize.max, children: [
                TextField(
                  controller: _numeroAvControler,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Numero Aviário",
                    hintText: "Digite numero aviário",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextField(
                  controller: _numeroLoteControler,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Numero Lote",
                    hintText: "Digite numero do lote",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextField(
                  controller: _tipoRacaoControler,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Tipo de Ração",
                    hintText: "Digite o Tipo da Ração",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextField(
                  controller: _quatidadeControler,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffix: Text('Kg'),
                    labelText: "Quantidade ração",
                    hintText: "Digite a quantidade em kilograma",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextField(
                  controller: _dataEntregaControler,
                  autofocus: true,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Data Entrega",
                    hintText: "Digite a data de entrega",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextField(
                  controller: _nomeMotoristaControler,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome Motorista",
                    hintText: "Digite o nome do Motorista",
                  ),
                ),
              ]),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _salvarAnotacao();
                    Navigator.pop(context);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          );
        });
  }

  _formataData(String data) {
    String dia = data.split('/')[0];
    String mes = data.split('/')[1];
    String ano = data.split('/')[2];
    String resultado = "$ano-$mes-$dia";
    return resultado;
  }

  _salvarAnotacao() async {
    var formatador = DateFormat("yyyy-MM-dd");
    int numeroAv = int.parse(_numeroAvControler.text);
    int numeroLote = int.parse(_numeroLoteControler.text);
    String tipoRacao = _tipoRacaoControler.text;
    DateTime dataConvertida =
        DateTime.parse(_formataData(_dataEntregaControler.text));
    String dataFormatada = formatador.format(dataConvertida);
    int quantidade = int.parse(_quatidadeControler.text);
    String nomeMotorista = _nomeMotoristaControler.text;

    Anotacao anotacao = Anotacao(numeroAv, numeroLote, tipoRacao, dataFormatada,
        quantidade, nomeMotorista);
    int resultado = await _db.salvarAnotacao(anotacao);

    print("salvar anotacao: $resultado");

    _numeroAvControler.clear();
    _numeroLoteControler.clear();
    _tipoRacaoControler.clear();
    _dataEntregaControler.clear();
    _quatidadeControler.clear();
    _nomeMotoristaControler.clear();
  }

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();
    print("recuperar anotacoes: $anotacoesRecuperadas");
  }

  @override
  Widget build(BuildContext context) {
    //_recuperarAnotacoes();
    return Scaffold(
      appBar: AppBar(
        title: (const Text('Consumo de ração')),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListaAv722()),
              );
            },
            child: const Text('listaAv722'),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          _exibirTelaCadastro();
        },
      ),
    );
  }
}
