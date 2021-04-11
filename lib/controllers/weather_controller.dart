import 'package:ferma/models/weather_model.dart';
import 'package:ferma/services/weather_service.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';
import 'package:get/get.dart';

class WeatherController extends GetxController {
  final Rx<Weather> weather = Weather().obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      await WeatherService.getWeatherData('-6.8446067', '107.543945')
          .then((res) {
        if (res is Weather) {
          updateLocalData(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      isLoading.toggle();
    }
  }

  updateLocalData(Weather newData) {
    weather.update((val) {
      if (val != null) {
        val.current = newData.current;
        val.forecast = newData.forecast;
        val.location = newData.location;
      }
    });
  }
}
