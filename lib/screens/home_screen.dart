import 'package:ferma/controllers/home_controller.dart';
import 'package:ferma/controllers/weather_controller.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: MyColors.primary,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () {},
        // onPressed: () => Get.to(CatalogPlantScreen()),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(25, 60, 25, 0),
        children: [
          Text(
            'Home',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          // SizedBox(height: 5),
          // Text(
          //   "The love of gardening is a seed once sown that never dies. — Gertrude Jekyll",
          //   style: TextStyle(
          //     fontFamily: 'OpenSans',
          //     fontSize: 14,
          //     fontWeight: FontWeight.w600,
          //     color: MyColors.grey,
          //   ),
          // ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {},
            // onTap: () => Get.to(WeatherScreen()),
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 15, 10, 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 35,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Obx(
                                    () => Text(
                                      homeController.address.value,
                                      style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            if (weatherController.weather != null)
                              Expanded(
                                child: Obx(() {
                                  return weatherController.isLoading.value
                                      ? loadingIndicator()
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    weatherController
                                                        .weather
                                                        .value
                                                        .current!
                                                        .condition!
                                                        .text!,
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    '${weatherController.weather.value.current!.tempC.toString()}ºC',
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      color: MyColors.darkGrey,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            loadImage(
                                                'https:${weatherController.weather.value.current!.condition!.icon}'),
                                          ],
                                        );
                                }),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    child: VerticalDivider(),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'My Plants',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Check how your crops are doing',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: MyColors.grey,
            ),
          ),
          SizedBox(height: 20),
          // Obx(
          //   () => homeController.isLoading.value
          //       ? Padding(
          //           padding: const EdgeInsets.only(top: 75),
          //           child: loadingIndicator(),
          //         )
          //       : ListView.builder(
          //           padding: EdgeInsets.only(bottom: 75),
          //           physics: NeverScrollableScrollPhysics(),
          //           shrinkWrap: true,
          //           itemCount: homeController.myPlants.length,
          //           itemBuilder: (context, index) {
          //             return _MyPlantCard(
          //               data: homeController.myPlants[index],
          //             );
          //           },
          //         ),
          // ),
        ],
      ),
    );
  }
}

// class _MyPlantCard extends StatelessWidget {
//   final MyPlant? data;

//   const _MyPlantCard({Key? key, this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Get.to(MyPlantDetailScreen(
//         data: data,
//       )),
//       child: Container(
//         margin: EdgeInsets.only(bottom: 15),
//         padding: EdgeInsets.fromLTRB(22.5, 15, 10, 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withAlpha(25),
//               blurRadius: 35,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   data!.name!,
//                                   style: TextStyle(
//                                     fontFamily: 'Montserrat',
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w700,
//                                     color: MyColors.darkGrey,
//                                   ),
//                                 ),
//                                 SizedBox(height: 3),
//                                 Text(
//                                   '${data!.plantName} - ' +
//                                       (data!.isDone!
//                                           ? 'Finish'
//                                           : '${data!.finishTask}/${data!.totalTask} Tasks'),
//                                   style: TextStyle(
//                                     fontFamily: 'OpenSans',
//                                     fontSize: 12,
//                                     color: MyColors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 35,
//                             width: 35,
//                             child: VerticalDivider(
//                               color: MyColors.grey,
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Progress',
//                                 style: TextStyle(
//                                   fontFamily: 'OpenSans',
//                                   fontSize: 10,
//                                   color: MyColors.grey,
//                                 ),
//                               ),
//                               SizedBox(height: 3),
//                               Text(
//                                 '${data!.progress}%',
//                                 style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700,
//                                   color: MyColors.darkGrey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 15),
//                       LinearPercentIndicator(
//                         padding: EdgeInsets.symmetric(horizontal: 5),
//                         lineHeight: 5,
//                         percent: double.parse(data!.progress!) / 100,
//                         progressColor: MyColors.gold,
//                         backgroundColor: MyColors.lightGrey,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 15),
//                 loadImage(data!.picture, height: 85),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
