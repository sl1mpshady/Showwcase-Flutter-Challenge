import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:pokedex/app/data/models/pokemon_details.dart';
import 'package:pokedex/app/data/models/pokemon_list.dart';
import 'package:pokedex/app/data/services/storage/services.dart';

class PokemonProvider extends GetConnect {
  StorageService storage = Get.find<StorageService>();
  @override
  void onInit() {
    httpClient.baseUrl = 'https://pokeapi.co/api/v2/';
  }

  Future<PokemonList> getPokemons({int? offset, int? limit}) async {
    final url =
        '${httpClient.baseUrl}pokemon/offset=${offset ?? 0}&limit=${limit ?? 0}';

    final cache = storage.read(url);
    if (cache != null) {
      return PokemonList.fromJson(jsonDecode(cache));
    }
    debugPrint(url);
    final request = get(
      'pokemon',
      query: {'offset': '${offset ?? 0}', 'limit': '${limit ?? 20}'},
      decoder: (data) => PokemonList.fromJson(data, url: url),
    );

    return await request.then((value) {
      storage.write(url, jsonEncode(value.body));
      return value.body!;
    });
  }

  Future<PokemonDetails> getPokemonDetails(String name) async {
    final cache = storage.read(name);
    if (cache != null) {
      return PokemonDetails.fromJson(jsonDecode(cache));
    }
    debugPrint('GET ${httpClient.baseUrl}pokemon/$name');
    final request =
        get('pokemon/$name', decoder: (data) => PokemonDetails.fromJson(data));

    return await request.then((value) {
      storage.write(name, jsonEncode(value.body));
      return value.body!;
    });
    // get('pokemon/$name', decoder: (data) => PokemonDetails.fromJson(data));
  }
}
