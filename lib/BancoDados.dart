import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedex/Pokemon.dart';

class BancoDados {
  final CollectionReference<Map<String, dynamic>> _pokemons =
      FirebaseFirestore.instance.collection('pokemons');
      
  Future<String> inserirPokemon(Pokemon pokemon) async {
    final documento = await _pokemons.add(pokemon.toMap());
    return documento.id;
  }
  
  Future<List<Pokemon>> buscarPokemons() async {
    final resultado = await _pokemons.orderBy('name').get();

    return resultado.docs
        .map((doc) => Pokemon.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> atualizarPokemon(Pokemon pokemon) async {
    final id = pokemon.id;
    if (id == null) {
      throw StateError('O Pokémon ainda não foi salvo no Firestore.');
    }

    await _pokemons.doc(id).update(pokemon.toMap());
  }

  Future<void> apagarPokemon(String id) async {
    await _pokemons.doc(id).delete();
  }
}
