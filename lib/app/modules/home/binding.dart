import 'package:get/instance_manager.dart';
import 'package:pokedex/app/data/provider/pokemon/provider.dart';
import 'package:pokedex/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokemonProvider>(() => PokemonProvider());
    Get.lazyPut<HomeController>(
        () => HomeController(pokemonProvider: Get.find()));
  }
}
