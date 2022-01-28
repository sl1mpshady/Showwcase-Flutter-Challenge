import 'package:get/get.dart';
import 'package:pokedex/app/data/models/pokemon.dart';
import 'package:pokedex/app/data/models/pokemon_list.dart';
import 'package:pokedex/app/data/provider/pokemon/provider.dart';

class HomeController extends GetxController with StateMixin<List<Pokemon>> {
  PokemonProvider pokemonProvider;
  HomeController({required this.pokemonProvider});
  final hello = '123';
  final pokemons = <Pokemon>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPokemons();
  }

  void fetchPokemons() {
    pokemonProvider.getPokemons().then((result) {
      PokemonList? pokemons = result.body;
      for (var pokemon in pokemons!.results) {
        pokemonProvider.getPokemonDetails(pokemon.name).then((value) {
          pokemon.pokemonDetails = value.body;
          if (pokemon == pokemons.results.last &&
              pokemon.pokemonDetails != null) {
            Future.delayed(const Duration(seconds: 1),
                () => change(pokemons.results, status: RxStatus.success()));
          }
        }, onError: (err) {
          change([], status: RxStatus.error(err.toString()));
        });
      }
    }, onError: (err) {
      change([], status: RxStatus.error(err.toString()));
    });
  }
}
