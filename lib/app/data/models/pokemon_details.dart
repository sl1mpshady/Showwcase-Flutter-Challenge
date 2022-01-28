import 'package:pokedex/app/core/values/type_colors.dart';
import 'package:pokedex/app/data/services/type/services.dart';

class PokemonDetails {
  final int id;
  final String name;
  final String sprite;
  final List<String> pokemonTypes;
  PokemonType? pokemonType;

  PokemonDetails(
      {required this.id,
      required this.name,
      required this.sprite,
      required this.pokemonTypes,
      this.pokemonType});

  factory PokemonDetails.fromJson(Map<String, dynamic> json) => PokemonDetails(
      id: json['id'],
      name: json['name'],
      sprite: json['sprites']['other']['dream_world']['front_default'],
      pokemonType: Type.get(json['types'].first['type']['name']),
      pokemonTypes: (json['types'] as List<dynamic>)
          .map((jsonType) => jsonType['type']['name'] as String)
          .toList());
}
