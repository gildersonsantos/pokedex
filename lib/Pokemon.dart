class Pokemon {
  int? id;
  final String name;
  final String type;
  final int hp;

  Pokemon(this.name, this.type, this.hp, [this.id]);

  Map<String, dynamic> toMap() {
    var mapa = <String, dynamic>{'name': name, 'type': type, 'hp': hp};

    if (id != null) {
      mapa['id'] = id;
    }

    return mapa;
  }

  Pokemon.fromMap(Map<String, dynamic> mapa)
    : id = mapa['id'],
      name = mapa['name'],
      type = mapa['type'],
      hp = mapa['hp'];
}
