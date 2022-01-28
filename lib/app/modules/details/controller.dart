import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/data/models/pokemon.dart';

class DetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late Pokemon pokemon;
  RxInt currentTab = 0.obs;
  final tabs = ['About', 'Base Stats', 'Evolution', 'Moves'];

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      currentTab.value = tabController.index;
    });
    pokemon = Get.arguments['pokemon'];
    super.onInit();
  }

  void onBack() {
    Get.back();
  }
}
