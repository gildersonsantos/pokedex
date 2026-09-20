import 'package:flutter/material.dart';
import 'package:pokedex/BancoDados.dart';
import 'package:pokedex/Pokemon.dart';

class TelaRegistro extends StatefulWidget {
  const TelaRegistro({super.key});

  @override
  State<TelaRegistro> createState() => TelaRegistroState();
}

class TelaRegistroState extends State<TelaRegistro> {
  final nomeController = TextEditingController();
  final tipoController = TextEditingController();
  final hpController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    tipoController.dispose();
    hpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Pokemon')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Tela de cadastro do Pokemon'),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Pokemon'),
            ),
            TextField(
              controller: tipoController,
              decoration: const InputDecoration(labelText: 'Tipo do Pokemon'),
            ),
            TextField(
              controller: hpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'HP do Pokemon'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    int hp = int.parse(hpController.text);
                    Pokemon pokemon = Pokemon(
                      nomeController.text,
                      tipoController.text,
                      hp,
                    );

                    await BancoDados().inserirPokemon(pokemon);
                    Navigator.pop(context);
                  },
                  child: const Text('Salvar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
