import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/data/models/pokemon.dart';
import 'package:pokedex/app/data/models/pokemon_list.dart';
import 'package:pokedex/app/data/provider/pokemon/provider.dart';

class HomeController extends GetxController with StateMixin<List<Pokemon>> {
  PokemonProvider pokemonProvider;
  HomeController({required this.pokemonProvider});

  final int pageSize = 20;
  int page = 1;
  var pokemons = <Pokemon>[].obs;
  RxBool fetching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPokemons(
      limit: pageSize,
    );
  }

  void fetchPokemons({int? limit, int? offset}) {
    fetching.value = true;
    pokemonProvider.getPokemons(limit: limit ?? 20, offset: offset ?? 0).then(
        (result) {
      PokemonList? pokemonResult = result;
      for (var pokemon in pokemonResult.results) {
        pokemonProvider.getPokemonDetails(pokemon.name).then((value) {
          pokemon.pokemonDetails = value;

          if (pokemon == pokemonResult.results.last &&
              pokemon.pokemonDetails != null) {
            Future.delayed(const Duration(milliseconds: 500), () {
              // ignore: invalid_use_of_protected_member
              pokemons.value.addAll(pokemonResult.results);
              fetching.value = false;
              debugPrint('Done fetching pokemons');
              change(pokemons, status: RxStatus.success());
            });
          }
        }, onError: (err) {
          fetching.value = false;
          change([], status: RxStatus.error(err.toString()));
        });
      }
    }, onError: (err) {
      fetching.value = false;
      change([], status: RxStatus.error(err.toString()));
    });
  }

  void onNextPage() {
    page++;
    fetchPokemons(offset: (page - 1) * pageSize, limit: pageSize);
  }

  void openDetails(Pokemon pokemon) {
    Get.toNamed('/details', arguments: {'pokemon': pokemon});
  }
}
