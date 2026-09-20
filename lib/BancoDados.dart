import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex/Pokemon.dart';

class BancoDados {
  String tabelaPokemon = 'pokemons';
  String colunaId = 'id';
  String colunaNome = 'name';
  String colunaTipo = 'type';
  String colunaHp = 'hp';

  BancoDados._interno();

  static final BancoDados _bancoDados = BancoDados._interno();

  factory BancoDados() {
    return _bancoDados;
  }

  static Database? _banco;

  Future<Database> inicializarBanco() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String caminho = '${diretorio.path}/pokedex.db';

    var banco = await openDatabase(caminho, version: 1, onCreate: _criarBanco);

    return banco;
  }

  void _criarBanco(Database banco, int novaVersao) async {
    await banco.execute(
      'CREATE TABLE $tabelaPokemon('
      '$colunaId INTEGER PRIMARY KEY, '
      '$colunaNome TEXT, '
      '$colunaTipo TEXT, '
      '$colunaHp INTEGER)',
    );
  }

  Future<Database> get banco async {
    if (_banco == null) {
      _banco = await inicializarBanco();
    }

    return _banco!;
  }

  Future<int> inserirPokemon(Pokemon pokemon) async {
    Database banco = await this.banco;
    var resultado = await banco.insert(tabelaPokemon, pokemon.toMap());

    return resultado;
  }

  Future<List> buscarPokemons() async {
    Database banco = await this.banco;
    var resultado = await banco.rawQuery(
      'SELECT * FROM $tabelaPokemon ORDER BY $colunaNome ASC',
    );

    return resultado;
  }

  Future<int> atualizarPokemon(Pokemon pokemon) async {
    var banco = await this.banco;
    var resultado = await banco.update(
      tabelaPokemon,
      pokemon.toMap(),
      where: '$colunaId = ?',
      whereArgs: [pokemon.id],
    );

    return resultado;
  }

  Future<int> apagarPokemon(int id) async {
    var banco = await this.banco;
    var resultado = await banco.rawDelete(
      'DELETE FROM $tabelaPokemon WHERE $colunaId = $id',
    );

    return resultado;
  }
}
