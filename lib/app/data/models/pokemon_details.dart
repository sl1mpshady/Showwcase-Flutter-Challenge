import 'dart:convert';

import 'package:pokedex/app/core/values/type_colors.dart';
import 'package:pokedex/app/data/models/pokemon_base_stat.dart';
import 'package:pokedex/app/data/services/type/services.dart';

class PokemonDetails {
  final int id;
  final String name;
  final String sprite;
  final List<String> pokemonTypes;
  final int height;
  final int weight;
  final List<PokemonBaseStat> baseStats;
  PokemonType? pokemonType;

  PokemonDetails(
      {required this.id,
      required this.name,
      required this.sprite,
      required this.pokemonTypes,
      required this.height,
      required this.weight,
      required this.baseStats,
      this.pokemonType});

  factory PokemonDetails.fromJson(Map<String, dynamic> json) => PokemonDetails(
      id: json['id'],
      name: json['name'],
      sprite: json['sprite'] ??
          json['sprites']['other']['dream_world']['front_default'],
      pokemonType:
          Type.get(json['pokemon_type'] ?? json['types'].first['type']['name']),
      pokemonTypes: json['pokemon_types'] != null
          ? (jsonDecode(json['pokemon_types']) as List<dynamic>)
              .map((type) => type as String)
              .toList()
          : (json['types'] as List<dynamic>)
              .map((jsonType) => jsonType['type']['name'] as String)
              .toList(),
      height: json['height'],
      weight: json['weight'],
      baseStats: ((json['stats'] is String
              ? jsonDecode(json['stats'])
              : json['stats']) as List<dynamic>)
          .map((jsonStat) => PokemonBaseStat.fromJson(jsonStat))
          .toList());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sprite': sprite,
        'pokemon_types': jsonEncode(pokemonTypes),
        'pokemon_type': pokemonTypes.first,
        'height': height,
        'weight': weight,
        'stats': jsonEncode(baseStats)
      };
}
