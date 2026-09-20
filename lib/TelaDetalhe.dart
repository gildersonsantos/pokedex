import 'package:flutter/material.dart';
import 'package:pokedex/BancoDados.dart';
import 'package:pokedex/Pokemon.dart';

class TelaDetalhe extends StatelessWidget {
  final Pokemon pokemon;

  TelaDetalhe(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Pokemon')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Nome: ${pokemon.name}\n'
              'Tipo: ${pokemon.type}\n'
              'HP: ${pokemon.hp}',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (pokemon.id != null) {
                      await BancoDados().apagarPokemon(pokemon.id!);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Apagar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
