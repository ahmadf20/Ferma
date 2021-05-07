import 'package:bot_toast/bot_toast.dart';
import 'package:ferma/models/plant_model.dart';
import 'package:ferma/services/plant_service.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SuggestionController extends GetxController {
  RxList<Plant> plants = <Plant>[].obs;

  RxBool hasResult = true.obs;

  void getSuggestion(String ph, String space, String temp) async {
    try {
      BotToast.showLoading();
      await PlantService.getPlantSuggestion(ph, space, temp).then((res) async {
        if (res is List<Plant>) {
          if (res.isEmpty) {
            hasResult.value = false;
            return;
          }
          plants.clear();
          plants.addAll(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
