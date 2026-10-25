import 'package:flutter/material.dart';
import 'package:pokedex/BancoDados.dart';
import 'package:pokedex/TelaRegistro.dart';
import 'package:pokedex/Pokemon.dart';
import 'package:pokedex/TelaDetalhe.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  State<TelaPrincipal> createState() => TelaPrincipalState();
}

class TelaPrincipalState extends State<TelaPrincipal> {
  final listaKey = GlobalKey<ListaDePokemonsState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem-vindo à Pokedex!'),
            const Divider(color: Colors.grey, height: 20),
            const Text('Conjunto de pokemons capturados.'),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaRegistro()),
                    );
                    listaKey.currentState?.buscarPokemons();
                  },
                  child: const Text('Adicionar Pokemon'),
                ),
              ),
            ),
            ListaDePokemons(key: listaKey),
          ],
        ),
      ),
    );
  }
}

class ListaDePokemons extends StatefulWidget {
  const ListaDePokemons({super.key});

  @override
  State createState() => ListaDePokemonsState();
}

class ListaDePokemonsState extends State<ListaDePokemons> {
  List<Pokemon> pokemons = [];

  @override
  void initState() {
    super.initState();
    buscarPokemons();
  }

  Future<void> buscarPokemons() async {
    final lista = await BancoDados().buscarPokemons();

    if (!mounted) return;

    setState(() {
      pokemons = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text('Pokemons capturados:'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: pokemons.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(pokemons[index].name),
              subtitle: Text(
                'Tipo: ${pokemons[index].type}, HP: ${pokemons[index].hp}',
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaDetalhe(pokemons[index]),
                  ),
                );
                buscarPokemons();
              },
            );
          },
        ),
      ],
    );
  }
}
