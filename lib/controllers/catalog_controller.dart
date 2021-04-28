import 'package:bot_toast/bot_toast.dart';
import 'package:ferma/services/plant_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/models/plant_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';

import 'home_controller.dart';

class PlantController extends GetxController {
  final RxList<Plant> plants = <Plant>[].obs;
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

  List get filteredPlantList => plants.where((val) {
        final bool matchesTitle =
            val.plantName.toString().toLowerCase().contains(searchQuery.value);
        final bool matchesCategory =
            selectedCategory.value.id == defaultValue.id ||
                (selectedCategory.value.id != defaultValue.id &&
                    val.categoryId == selectedCategory.value.id);
        return matchesTitle && matchesCategory;
      }).toList();

  void updateQuery(String text) {
    searchQuery.value = text;
  }

  void fetchData() async {
    try {
      await PlantService.getCatalogPlant().then((res) {
        if (res is List<Plant>) {
          plants.addAll(res);
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

  void addMyPlantHandler(String id) async {
    try {
      BotToast.showLoading();
      await PlantService.addMyPlant(id, plantNameTC.text).then((res) async {
        if (res == true) {
          // await PlantService.postDefaultChecklist(res.id).then((v) {
          //   if (v is List<Activity>) {
          //     Get.find<HomeController>().fetchData();
          //     Get.back();
          //     Get.back();
          //   }
          // });

          customBotToastText('Plant has been added!');
          Get.find<HomeController>().fetchData();
          Get.back();
          Get.back();
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
