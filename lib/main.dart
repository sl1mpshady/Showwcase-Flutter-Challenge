import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/app/data/services/storage/services.dart';
import 'package:pokedex/app/modules/details/binding.dart';
import 'package:pokedex/app/modules/details/view.dart';
import 'package:pokedex/app/modules/home/binding.dart';
import 'package:pokedex/app/modules/home/view.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      initialBinding: HomeBinding(),
      getPages: [
        GetPage(name: '/', page: () => Home(), binding: HomeBinding()),
        GetPage(
            name: '/details', page: () => Details(), binding: DetailsBinding())
      ],
    );
  }
}
