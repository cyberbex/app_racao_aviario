import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:racao_av/validators.dart';
import 'package:validatorless/validatorless.dart';

import '../helper.dart/anotacao_helper.dart';
import '../model/anotacao.dart';

class FormularioPage extends StatefulWidget {
  const FormularioPage({Key? key}) : super(key: key);

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _db = AnotacaoHelper();

  final _numeroLoteControler = TextEditingController();
  final _dataEntregaControler = TextEditingController();
  final _quatidadeControler = TextEditingController();
  final _nomeMotoristaControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> items = ['RFCPI', 'RFCI', 'RFCC1', 'RFCC2', 'RFCA'];
  String selectedItem = 'RFCPI';
  List<String> items2 = ['722', '723'];
  String selectedItem2 = '722';

  _formataData(String data) {
    String dia = data.split('/')[0];
    String mes = data.split('/')[1];
    String ano = data.split('/')[2];
    String resultado = "$ano-$mes-$dia";
    return resultado;
  }

  _salvarAnotacao() async {
    var formatador = DateFormat("yyyy-MM-dd");

    int numeroLote = int.parse(_numeroLoteControler.text);

    DateTime dataConvertida =
        DateTime.parse(_formataData(_dataEntregaControler.text));
    String dataFormatada = formatador.format(dataConvertida);
    int quantidade = int.parse(_quatidadeControler.text);
    String nomeMotorista = _nomeMotoristaControler.text;
    int numeroAv = int.parse(selectedItem2);
    String tipoRacao = selectedItem;

    Anotacao anotacao;
    anotacao = Anotacao(numeroLote, numeroAv, tipoRacao, dataFormatada,
        quantidade, nomeMotorista);
    int resultado = await _db.salvarAnotacao(anotacao);

    print("salvar anotacao: $resultado");

    _numeroLoteControler.clear();
    _dataEntregaControler.clear();
    _quatidadeControler.clear();
    _nomeMotoristaControler.clear();
  }

  //@override
  /* void dispose() {
    _numeroLoteControler.dispose();
    _dataEntregaControler.dispose();
    _quatidadeControler.dispose();
    _nomeMotoristaControler.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário nota Ração'),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(8.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //const Padding(padding: EdgeInsets.all(10.0)),
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
                      setState(() => selectedItem = item as String),
                ),
                DropdownButton(
                  value: selectedItem2,
                  items: items2
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child:
                              Text(item, style: const TextStyle(fontSize: 24)),
                        ),
                      )
                      .toList(),
                  onChanged: (item) =>
                      setState(() => selectedItem2 = item as String),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    controller: _numeroLoteControler,
                    decoration: const InputDecoration(
                      labelText: 'numero do Lote',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: Validatorless.required('Campo obrigatório'),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  TextFormField(
                    controller: _dataEntregaControler,
                    decoration: const InputDecoration(
                        labelText: 'data de entrega',
                        border: OutlineInputBorder(),
                        hintText: "Data no formato xx/xx/xxxx"),
                    keyboardType: TextInputType.datetime,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha Obrigatória'),
                      Validators.validaData('Data Invalida')
                    ]),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  TextFormField(
                    controller: _quatidadeControler,
                    decoration: const InputDecoration(
                      labelText: 'quantidade ração',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: Validatorless.required('Campo obrigatório'),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  TextFormField(
                    controller: _nomeMotoristaControler,
                    decoration: const InputDecoration(
                      labelText: 'nome do motorista',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validator: Validatorless.required('Campo obrigatório'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          var formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            _salvarAnotacao();
            Navigator.pop(context);
            print('form validado!!');
          }
        },
      ),
    );
  }
}
