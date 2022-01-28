import 'package:get/instance_manager.dart';
import 'package:pokedex/app/modules/details/controller.dart';

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(() => DetailsController());
  }
}
