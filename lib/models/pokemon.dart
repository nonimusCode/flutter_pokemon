class PokemonSkeleton {
  final String name;
  final String url;

  PokemonSkeleton({
    required this.url,
    required this.name,
  });

  factory PokemonSkeleton.fromJson(Map<String, dynamic> json) {
    return PokemonSkeleton(
      url: json['url'],
      name: json['name'],
    );
  }
}

class Pokemon {
  final String image;
  final List<dynamic> types;
  final String name;

  Pokemon({
    required this.image,
    required this.types,
    required this.name,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        image: json['image'], types: json['types'], name: json['name']);
  }
}
