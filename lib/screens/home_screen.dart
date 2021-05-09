import 'package:carousel_slider/carousel_slider.dart';
import 'package:ferma/controllers/article/article_controller.dart';
import 'package:ferma/controllers/home_controller.dart';
import 'package:ferma/controllers/myplant/myplant_controller.dart';
import 'package:ferma/controllers/profile/profile_controller.dart';
import 'package:ferma/controllers/weather_controller.dart';
import 'package:ferma/models/article_model.dart';
import 'package:ferma/screens/article/articles_screen.dart';
import 'package:ferma/screens/chatbot/chatbot_screen.dart';
import 'package:ferma/screens/myplant/myplant_screen.dart';
import 'package:ferma/screens/profile/profile_screen.dart';
import 'package:ferma/screens/weather_screen.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/utils/my_text_style.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/loading_indicator.dart';
import 'package:ferma/widgets/myplant_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'article/article_detail_screen.dart';
import 'plant/catalog_plant_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

//TODO: BUG: data doesnt update when change account
  final WeatherController weatherController = Get.put(WeatherController());
  final ProfileController profileController = Get.put(ProfileController());
  final ArticleController articleController = Get.put(ArticleController());
  final HomeController homeController = Get.put(HomeController());
  final MyPlantController myPlantController = Get.put(MyPlantController());

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
        elevation: 1,
        onPressed: () async {
          await Get.to(() => CatalogPlantScreen())?.then((val) {
            //TODO: play around with transition
            if (val) Get.find<MyPlantController>().fetchData();
          });
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(25, 45, 25, 0),
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((8 / 100 * 255).toInt()),
                      blurRadius: 25,
                      offset: Offset(0, 3),
                    )
                  ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: (profileController
                                    .user.value.profilePicture?.isNotEmpty ??
                                false) &&
                            profileController.user.value.profilePicture != null
                        ? loadImage(
                            profileController.user.value.profilePicture,
                          )
                        : Image.asset(
                            'assets/images/default_profile_picture.png',
                          ),
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
                  onPressed: () => Get.to(() => ProfileScreen()),
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
                onPressed: () => Get.to(() => ArticlesScreen()),
              ),
            ],
          ),
          SizedBox(height: 17),
          Obx(
            () => CarouselSlider(
              options: CarouselOptions(
                height: 170,
                autoPlay: true,
                viewportFraction: 1,
                autoPlayInterval: Duration(seconds: 5),
                onPageChanged: (index, reason) {
                  homeController.updateCarouselIndex(index);
                },
              ),
              items: articleController.getLatestArticle.map((Article item) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () => Get.to(
                        () => ArticleDetailScreen(data: item),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(21, 17, 21, 17),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              item.picture ?? '',
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black26, BlendMode.darken),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title ?? '-',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => articleController.articles.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: AnimatedSmoothIndicator(
                      activeIndex: homeController.carouselIndex.value,
                      count: articleController.getLatestArticle.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 6,
                        dotWidth: 6,
                        strokeWidth: 6,
                        activeDotColor: MyColors.darkGrey,
                        dotColor: Colors.grey[300]!,
                      ),
                    ),
                  )
                : Container(),
          ),
          SizedBox(height: 35),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ChatebotScreen());
                  },
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
                                      'https:${weatherController.weather.value.current?.condition?.icon ?? ''}',
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
                    overlayColor: MaterialStateProperty.all(
                        MyColors.primary.withAlpha(50)),
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
                  onPressed: () async {
                    await Get.to(() => MyPlantScreen())?.then((val) {
                      if (val) Get.find<MyPlantController>().fetchData();
                    });
                  }),
            ],
          ),
          SizedBox(height: 20),
          Obx(
            () => myPlantController.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.only(top: 75),
                    child: loadingIndicator(),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: 75),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: myPlantController.myPlants.length,
                    itemBuilder: (context, index) {
                      return MyPlantCard(
                        myPlantController.myPlants[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
