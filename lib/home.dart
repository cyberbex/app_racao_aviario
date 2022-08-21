import 'package:flutter/material.dart';

import 'package:racao_av/page/formulario.dart';
import 'package:racao_av/page/lista_notas.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                MaterialPageRoute(
                    builder: (_) => ListaAv722(
                          valor: 722,
                        )),
              );
            },
            child: const Text('Listar notas aviário 722'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ListaAv722(
                          valor: 723,
                        )),
              );
            },
            child: const Text('Listar notas aviário 723'),
          ),
        ]),
      ),
    );
  }
}
