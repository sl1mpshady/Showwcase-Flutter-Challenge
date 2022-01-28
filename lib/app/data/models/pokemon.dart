import 'package:pokedex/app/data/models/pokemon_details.dart';

class Pokemon {
  final String name;
  final String url;
  PokemonDetails? pokemonDetails;

  Pokemon({required this.name, required this.url, this.pokemonDetails});

  // Pokemon copyWith({String? name, String? url}) => Pokemon(
  //     id: id,
  //     name: name ?? this.name,
  //     spriteImage: spriteImage ?? this.spriteImage);

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      Pokemon(name: json['name'], url: json['url']);

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}
