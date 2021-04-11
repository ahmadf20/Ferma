import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:ferma/utils/formatting.dart';
import 'package:ferma/utils/logger.dart';
import 'package:ferma/utils/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // final RxList<MyPlant> myPlants = <MyPlant>[].obs;

  RxString address = ''.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

  RxBool isLoading = true.obs;

  void updateLocation() async {
    BotToast.showLoading();
    Position position = await Geolocator.getCurrentPosition();
    SharedPrefs.setPosition(position.latitude, position.longitude);
    updateLatLong(position.latitude, position.longitude);
    address.value = await GeneralFormat.printLocation(
        position.latitude, position.longitude);

    logger.v(position);
    BotToast.closeAllLoading();
  }

  void initLocation() async {
    Map positions =
        await (SharedPrefs.getPosition() as FutureOr<Map<dynamic, dynamic>>);
    logger.i(positions);
    if (positions['latitude'] != null && positions['longitude'] != null) {
      address.value = await GeneralFormat.printLocation(
          positions['latitude'], positions['longitude']);
      updateLatLong(positions['latitude'], positions['longitude']);
      address.refresh();
    } else {
      updateLocation();
    }
  }

  void updateLatLong(double latitude, double longitude) {
    lat.value = latitude;
    long.value = longitude;
  }

  // void fetchData() async {
  //   try {
  //     await getMyPlants().then((res) {
  //       if (res is List<MyPlant>) {
  //         List<MyPlant> sortedRes = res;
  //         sortedRes
  //             .sort((a, b) => (a.isDone! ? 1 : 0).compareTo(b.isDone! ? 1 : 0));
  //         myPlants.clear();
  //         myPlants.addAll(sortedRes);
  //       } else {
  //         customBotToastText(res);
  //       }
  //     });
  //   } catch (e) {
  //     customBotToastText(ErrorMessage.general);
  //   } finally {
  //     if (isLoading.value) isLoading.toggle();
  //   }
  // }

  // void updateFinishTask(String? id, int count) {
  //   MyPlant temp = myPlants[myPlants.indexWhere((v) => v.id == id)]
  //     ..finishTask = count;
  //   myPlants[myPlants.indexWhere((v) => v.id == id)] = temp;
  // }

  // void updatePlantData(String? id, MyPlant data) {
  //   myPlants[myPlants.indexWhere((v) => v.id == id)] = data;
  // }

  @override
  void onInit() {
    initLocation();
    // fetchData();
    super.onInit();
  }
}
