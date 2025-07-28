class PokemonModel {
  final String name;
  final String url;
  final int id;
  final String imageUrl;

  // Datos extendidos para el detalle
  final int? height;
  final int? weight;
  final List<String>? types;
  final List<String>? abilities;

  PokemonModel({
    required this.name,
    required this.url,
    required this.id,
    required this.imageUrl,
    this.height,
    this.weight,
    this.types,
    this.abilities,
  });

  /// Construye desde la lista básica (name + url)
  factory PokemonModel.fromBasicJson(Map<String, dynamic> json) {
    final url = json['url'] ?? '';
    final id = int.tryParse(url.split('/')[url.split('/').length - 2]) ?? 0;

    return PokemonModel(
      name: json['name'],
      url: url,
      id: id,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

  /// Construye desde el JSON de detalle
  factory PokemonModel.fromDetailJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      url: 'https://pokeapi.co/api/v2/pokemon/${json['id']}/',
      id: json['id'],
      imageUrl:
          json['sprites']['front_default'] ??
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${json['id']}.png',
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List)
          .map((e) => e['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((e) => e['ability']['name'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url,
    'id': id,
    'imageUrl': imageUrl,
    'height': height,
    'weight': weight,
    'types': types,
    'abilities': abilities,
  };
}
