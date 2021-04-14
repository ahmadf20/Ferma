import 'package:carousel_slider/carousel_slider.dart';
import 'package:ferma/controllers/home_controller.dart';
import 'package:ferma/controllers/profile_controller.dart';
import 'package:ferma/controllers/weather_controller.dart';
import 'package:ferma/screens/profile/profile_screen.dart';
import 'package:ferma/screens/weather_screen.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/utils/my_text_style.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  final WeatherController weatherController = Get.put(WeatherController());
  final ProfileController profileController = Get.put(ProfileController());

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
        padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
        children: [
          Obx(
            () => Row(
              children: [
                IconButton(
                  onPressed: () => Get.to(() => ProfileScreen()),
                  padding: EdgeInsets.all(0),
                  icon: Image.asset(
                    'assets/images/default_profile_picture.png',
                    width: 45,
                    height: 45,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello!',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12,
                        color: MyColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.5),
                    Text(
                      profileController.user.value.username ?? 'User',
                      style: TextStyle(
                        fontSize: 16,
                        color: MyColors.darkGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.settings_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Text(
                'Latest Article',
                style: MyTextStyle.sectionText,
              ),
              Spacer(),
              TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(MyColors.primary.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: MyColors.grey,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: MyColors.primary,
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 17),
          CarouselSlider(
            options: CarouselOptions(
              height: 170,
              autoPlay: true,
              viewportFraction: 1,
              autoPlayInterval: Duration(seconds: 5),
              onPageChanged: (index, reason) {
                homeController.updateCarouselIndex(index);
              },
            ),
            items: [0, 1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(21, 17, 21, 17),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://www.planradar.com/wp-content/uploads/2019/06/the-high-line.jpg',
                        ),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black26, BlendMode.darken),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What is Urban Farming and is it Profitable?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Obx(
            () => Padding(
              padding: EdgeInsets.only(left: 25),
              child: AnimatedSmoothIndicator(
                activeIndex: homeController.carouselIndex.value,
                count: 6,
                effect: ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  strokeWidth: 6,
                  activeDotColor: MyColors.darkGrey,
                  dotColor: Colors.grey[300]!,
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.yellowFaded,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.headset_mic_outlined,
                        color: MyColors.yellow,
                        size: 35,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: MyColors.darkGrey,
                        ),
                      ),
                      SizedBox(height: 2.5),
                      Text(
                        'Talk to out AI bot to get the best experience!',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'OpenSans',
                          color: MyColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.to(() => WeatherScreen()),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Obx(
                      () => weatherController.isLoading.value
                          ? loadingIndicator()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!(weatherController.weather.isBlank ??
                                    true))
                                  loadImage(
                                      'https:${weatherController.weather.value.current!.condition!.icon}',
                                      width: 35,
                                      height: 35),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherController.weather.value.current?.condition?.text ?? '-'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.darkGrey,
                                  ),
                                ),
                                SizedBox(height: 2.5),
                                Text(
                                  '${weatherController.weather.value.current?.tempC ?? '-'}ºC',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: MyColors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),

          Row(
            children: [
              Text(
                'My Plants',
                style: MyTextStyle.sectionText,
              ),
              Spacer(),
              TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(MyColors.primary.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: MyColors.grey,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: MyColors.primary,
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ],
          ),

          SizedBox(height: 20),

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
