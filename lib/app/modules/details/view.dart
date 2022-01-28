import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/data/services/type/services.dart';
import 'package:pokedex/app/modules/details/controller.dart';

class Details extends GetView<DetailsController> {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =
        TypeColor.get(controller.pokemon.pokemonDetails!.pokemonType!);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            color: color,
          ),
          Positioned(
            right: -200,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Opacity(
              opacity: 0.7,
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                width: 500,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
            ),
          ),
          Positioned.fill(
              child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: controller.onBack,
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.pokemon.name,
                    style: GoogleFonts.ubuntu(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.pokemon.pokemonDetails!.pokemonTypes
                        .map((type) => Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(type,
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    height: 170,
                    child: Center(
                      child: SvgPicture.network(
                        controller.pokemon.pokemonDetails!.sprite,
                        width: 200,
                      ),
                    ),
                  ),
                  TabBar(
                      controller: controller.tabController,
                      labelPadding: const EdgeInsets.symmetric(vertical: 15),
                      enableFeedback: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: color,
                      tabs: controller.tabs
                          .map(
                            (tab) => Obx(() => Text(tab,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: controller.tabs[
                                                controller.currentTab.value] ==
                                            tab
                                        ? Colors.black
                                        : Colors.black.withOpacity(0.4)))),
                          )
                          .toList()),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          Column(
                            children: [
                              Text(
                                "The weather changes to rain when this Pokémon enters battle and does not end unless replaced by another weather condition.\n\nIf multiple Pokémon with this ability, drought, sand stream, or snow warning are sent out at the same time, the abilities will activate in order of Speed, respecting trick room.  Each ability's weather will cancel the previous weather, and only the weather summoned by the slowest of the Pokémon will stay.",
                                style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Height',
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 13,
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text('0.70cm',
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Weight',
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 13,
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text('0.70kg',
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text('123'),
                          Text('123'),
                          Text('123'),
                        ]),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
