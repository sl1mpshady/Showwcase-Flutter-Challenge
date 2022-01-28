import 'dart:convert';

import 'package:pokedex/app/data/models/pokemon.dart';

class PokemonList {
  final String key;
  final String? next;
  final String? previous;
  final List<Pokemon> results;

  PokemonList(
      {required this.key, this.next, this.previous, required this.results});

  factory PokemonList.fromJson(Map<String, dynamic> json, {String? url}) =>
      PokemonList(
          key: url ?? json['key'],
          next: json['next'],
          previous: json['previous'],
          results: ((json['results'] is String
                  ? jsonDecode(json['results'])
                  : json['results']) as List<dynamic>)
              .map((e) => Pokemon.fromJson(e))
              .toList());

  Map<String, dynamic> toJson() => {
        'key': key,
        'next': next,
        'previous': previous,
        'results': jsonEncode(results)
      };
}
