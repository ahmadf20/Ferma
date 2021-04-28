import 'package:ferma/utils/my_text_style.dart';
import 'package:ferma/widgets/app_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ferma/controllers/home_controller.dart';
import 'package:ferma/controllers/weather_controller.dart';
import 'package:ferma/models/weather_model.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/loading_indicator.dart';
import 'package:ferma/widgets/my_app_bar.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({Key? key}) : super(key: key);

  final WeatherController controller = Get.find<WeatherController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MyAppBar(),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? loadingIndicator()
            : ListView(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                children: [
                  AppTitleBar(
                    title: 'Weather',
                    desc: 'Weather might affect your plant growing',
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 25, 30, 25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 35,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${controller.weather.value.current!.condition!.text}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    homeController.address.value,
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${DateFormat('EE, dd MMM').format(DateTime.now())}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.end,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${controller.weather.value.current?.tempC?.toInt() ?? '-'}ºC',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: MyColors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  loadImage(
                                      'https:${controller.weather.value.current!.condition!.icon}'),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          height: 35,
                          color: MyColors.grey,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  buildWeatherInfo(
                                    'Wind',
                                    '${controller.weather.value.current!.windMph} m/h',
                                  ),
                                  SizedBox(height: 10),
                                  buildWeatherInfo(
                                    'Visibility',
                                    '${controller.weather.value.current!.visKm} km',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 50),
                            Expanded(
                              child: Column(
                                children: [
                                  buildWeatherInfo(
                                    'Humidity',
                                    '${controller.weather.value.current!.humidity}%',
                                  ),
                                  SizedBox(height: 10),
                                  buildWeatherInfo(
                                    'UV',
                                    '${controller.weather.value.current!.uv}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 35),
                        Text(
                          'Next 3 Days',
                          style: MyTextStyle.sectionText,
                        ),
                        SizedBox(height: 25),
                        ...controller.weather.value.forecast!.forecastday!
                            .map(buildCard)
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Container buildCard(Forecastday item) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 25,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            '${DateFormat('EEE').format(item.date!).toUpperCase()}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: MyColors.darkGrey,
            ),
          ),
          Spacer(),
          Text(
            '${item.day!.mintempC?.toInt() ?? '-'}ºC',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: MyColors.darkGrey,
            ),
          ),
          SizedBox(width: 5),
          Text(
            '${item.day!.maxtempC?.toInt() ?? '-'}ºC',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: MyColors.grey,
            ),
          ),
          Spacer(),
          Row(
            children: [
              loadImage(
                'https:${item.day!.condition!.icon}',
                height: 35,
              ),
              SizedBox(width: 15),
              Text(
                '${item.day?.condition?.text ?? '-'}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: MyColors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildWeatherInfo(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: MyColors.white,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: MyColors.white,
          ),
        ),
      ],
    );
  }
}
