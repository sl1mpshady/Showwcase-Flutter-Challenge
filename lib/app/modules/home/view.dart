import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/data/services/type/services.dart';
import 'package:pokedex/app/modules/form/view.dart';
import 'package:pokedex/app/modules/home/controller.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text('Pokedex',
                style: GoogleFonts.ubuntu(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 40,
            ),
            controller.obx(
                (state) => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: state!.length + 1,
                    itemBuilder: (BuildContext ctx, index) {
                      if (index == state.length + 1 - 1) {
                        return VisibilityDetector(
                          key: const Key('spinner'),
                          onVisibilityChanged: (visibilityInfo) {
                            var visiblePercentage =
                                visibilityInfo.visibleFraction * 100;
                            debugPrint(
                                'Spinner is $visiblePercentage% visible');
                            if (visiblePercentage == 100.0) {
                              debugPrint('Fetching next page');
                              controller.onNextPage();
                            }
                          },
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        if (state[index].pokemonDetails == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GestureDetector(
                          onTap: () => controller.openDetails(state[index]),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: TypeColor.get(
                                    state[index].pokemonDetails!.pokemonType!),
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: SvgPicture.asset(
                                      'assets/images/logo.svg',
                                      width: 80,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 10,
                                  child: SvgPicture.network(
                                    state[index].pokemonDetails!.sprite,
                                    //'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/25.svg',
                                    width: 60,
                                  ),
                                ),
                                Positioned.fill(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state[index].name,
                                        style: GoogleFonts.ubuntu(
                                            shadows: <Shadow>[
                                              const Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: state[index]
                                            .pokemonDetails!
                                            .pokemonTypes
                                            .map((pokemonType) => Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(pokemonType,
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ))
                                            .toList(),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        );
                      }
                    }),
                onLoading: const Center(
                  child: CircularProgressIndicator(),
                ),
                onError: (error) => Text('Error: $error')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(CustomForm(), persistent: false).whenComplete(() {
            controller.clearForm();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
