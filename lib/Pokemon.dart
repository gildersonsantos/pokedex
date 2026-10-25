class Pokemon {
  final String? id;
  final String name;
  final String type;
  final int hp;

  Pokemon(this.name, this.type, this.hp, [this.id]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'type': type, 'hp': hp};
  }

  Pokemon.fromMap(this.id, Map<String, dynamic> mapa)
    : name = mapa['name'] as String,
      type = mapa['type'] as String,
      hp = mapa['hp'] as int;
}
