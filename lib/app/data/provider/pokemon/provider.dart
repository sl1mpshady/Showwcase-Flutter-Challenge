import 'package:get/get_connect.dart';
import 'package:pokedex/app/data/models/pokemon_details.dart';
import 'package:pokedex/app/data/models/pokemon_list.dart';

class PokemonProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://pokeapi.co/api/v2/';
  }

  Future<Response<PokemonList>> getPokemons({int? offset, int? limit}) => get(
        'pokemon',
        query: {'offset': offset ?? '0', 'limit': limit ?? '20'},
        decoder: (data) => PokemonList.fromJson(data,
            url:
                '${httpClient.baseUrl}pokemon/offset=${offset ?? 0}&limit=${limit ?? 0}'),
      );

  Future<Response<PokemonDetails>> getPokemonDetails(String name) =>
      get('pokemon/$name', decoder: (data) => PokemonDetails.fromJson(data));
}
