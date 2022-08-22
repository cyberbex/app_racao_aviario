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
    return Scaffold(
      appBar: AppBar(
        title: (const Text('Consumo de ração')),
        backgroundColor: Colors.green,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 40, top: 40),
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith((states) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20));
                }), backgroundColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                  return Colors.green;
                })),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FormularioPage()),
                  );
                },
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Cadastrar nota ração',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 25)),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith((states) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20));
                }), backgroundColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                  return Colors.green;
                })),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ListaAv722(
                              valor: 722,
                            )),
                  );
                },
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Lista notas aviário 722',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 25)),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith((states) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20));
                }), backgroundColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                  return Colors.green;
                })),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ListaAv722(
                              valor: 723,
                            )),
                  );
                },
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Lista notas aviário 723',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
