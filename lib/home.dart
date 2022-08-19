import 'package:flutter/material.dart';
import 'package:racao_av/helper.dart/anotacao_helper.dart';

import 'package:racao_av/model/anotacao.dart';
import 'package:racao_av/page/formulario.dart';
import 'package:intl/intl.dart';
import 'package:racao_av/page/lista_av722.dart';
import 'package:validatorless/validatorless.dart';

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
  final _formKey = GlobalKey<FormState>();

  final _db = AnotacaoHelper();
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String? selectedItem = 'Item 1';

  _exibirTelaCadastro() {
    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: const Text('Adicionar Ração'),
              content: Column(mainAxisSize: MainAxisSize.max, children: [
                DropdownButton(
                  value: selectedItem,
                  items: items
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child:
                              Text(item, style: const TextStyle(fontSize: 24)),
                        ),
                      )
                      .toList(),
                  onChanged: (item) =>
                      setState(() => selectedItem = item as String?),
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _numeroLoteControler,
                    decoration:
                        const InputDecoration(labelText: 'numero do Lote'),
                    keyboardType: TextInputType.number,
                    validator: Validatorless.required('Campo obrigatório'),
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
                    var formValid = _formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      //_salvarAnotacao();
                      Navigator.pop(context);
                      print('form validado!!');
                    }
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
                MaterialPageRoute(builder: (context) => const FormularioPage()),
              );
            },
            child: const Text('Cadastrar nota ração'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListaAv722()),
              );
            },
            child: const Text('Listar notas aviário 722'),
          ),
        ]),
      ),
    );
  }
}
