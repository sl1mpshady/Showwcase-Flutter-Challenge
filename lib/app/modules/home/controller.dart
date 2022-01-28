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
  var pokemons = <Pokemon>[];
  RxBool fetching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPokemons();
  }

  void fetchPokemons({int? limit, int? offset}) {
    fetching.value = true;
    pokemonProvider.getPokemons(limit: limit, offset: offset).then((result) {
      PokemonList? pokemonResult = result.body;
      for (var pokemon in pokemonResult!.results) {
        pokemonProvider.getPokemonDetails(pokemon.name).then((value) {
          pokemon.pokemonDetails = value.body;
          if (pokemon == pokemonResult.results.last) {
            Future.delayed(const Duration(seconds: 1), () {
              pokemons.addAll(pokemonResult.results);
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
}
