import 'package:bot_toast/bot_toast.dart';
import 'package:ferma/models/myplant_model.dart';
import 'package:ferma/services/myplant_service.dart';
import 'package:ferma/services/plant_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/models/plant_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';

class MyPlantController extends GetxController {
  final RxList<MyPlant> myPlants = <MyPlant>[].obs;
  RxBool isLoading = true.obs;

  static final PlantCategory defaultValue =
      PlantCategory(name: "All", id: "0", articleId: "0");

  final RxList<PlantCategory> category = <PlantCategory>[defaultValue].obs;

  final Rx<PlantCategory> selectedCategory = defaultValue.obs;
  final RxString searchQuery = ''.obs;

  TextEditingController? searchTC = TextEditingController(text: '');
  TextEditingController plantNameTC = TextEditingController(text: '');

  @override
  void onInit() {
    fetchData();
    fetchCategory();
    super.onInit();
  }

  void updateActiveCategory(PlantCategory category) {
    selectedCategory.value = category;
  }

  List get filteredPlantList => myPlants.where((val) {
        final bool matchesTitle =
            val.name.toString().toLowerCase().contains(searchQuery.value);
        final bool matchesPlantName = val.plant != null &&
            val.plant!.plantName
                .toString()
                .toLowerCase()
                .contains(searchQuery.value);
        final bool matchesCategory =
            selectedCategory.value.id == defaultValue.id ||
                (selectedCategory.value.id != defaultValue.id &&
                    val.plant?.categoryId == selectedCategory.value.id);
        return (matchesTitle || matchesPlantName) && matchesCategory;
      }).toList();

  void updateQuery(String text) {
    searchQuery.value = text;
  }

  void doChecklist(String plantId, String checkListId) async {
    BotToast.showLoading();
    try {
      await MyPlantService.doChecklist(checkListId).then((res) {
        if (res is Checklist) {
          MyPlant plant = myPlants.firstWhere((val) => val.plantId == plantId);
          if (plant.checklists != null && plant.checklists!.isNotEmpty) {
            plant.checklists![
                plant.checklists!.indexWhere((v) => v.id == res.id)] = res;
          }
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      BotToast.closeAllLoading();
    }
  }

  void fetchData() async {
    try {
      await PlantService.getMyPlants().then((res) {
        if (res is List<MyPlant>) {
          List<MyPlant> sortedRes = res;
          sortedRes
              .sort((a, b) => (a.isDone! ? 1 : 0).compareTo(b.isDone! ? 1 : 0));
          myPlants.clear();
          myPlants.addAll(sortedRes);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      if (isLoading.value) isLoading.toggle();
    }
  }

  void fetchCategory() async {
    try {
      await PlantService.getCategory().then((res) {
        if (res is List<PlantCategory>) {
          category.addAll(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      if (isLoading.value) isLoading.toggle();
    }
  }
}
