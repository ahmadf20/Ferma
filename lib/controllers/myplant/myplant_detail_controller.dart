import 'package:bot_toast/bot_toast.dart';
import 'package:ferma/models/myplant_model.dart';
import 'package:ferma/services/myplant_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';

class MyPlantDetailController extends GetxController {
  final Rx<MyPlant> plant = MyPlant().obs;
  final RxList<Checklist> checkList = <Checklist>[].obs;
  final RxList<Activity> activities = <Activity>[].obs;

  final MyPlant _plantData;
  RxBool isLoadingChecklist = true.obs;
  RxBool isLoadingActivity = true.obs;

  TextEditingController controller = TextEditingController();

  MyPlantDetailController(this._plantData);

  @override
  void onInit() {
    updateData(_plantData);
    fetchCheckList(_plantData.id ?? '');
    fetchActivities(_plantData.id ?? '');
    super.onInit();
  }

  void fetchCheckList(String id) async {
    try {
      await MyPlantService.getChecklist(id).then((res) {
        if (res is List<Checklist>) {
          checkList.addAll(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      isLoadingChecklist.toggle();
    }
  }

  void doChecklist(String id) async {
    BotToast.showLoading();
    try {
      await MyPlantService.doChecklist(id).then((res) {
        if (res is Checklist) {
          checkList[checkList.indexWhere((v) => v.id == res.id)] = res;
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

  void fetchActivities(String id) async {
    try {
      await MyPlantService.getActivities(id).then((res) {
        if (res is List<Activity>) {
          activities.addAll(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      isLoadingActivity.toggle();
    }
  }

  void postActivity(String id, String title) async {
    BotToast.showLoading();
    try {
      await MyPlantService.addActivity(id, title).then((res) {
        if (res is Activity) {
          activities.add(res);
          controller.clear();
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

  void delActivity(String id) async {
    BotToast.showLoading();
    try {
      await MyPlantService.delActivity(id).then((res) {
        if (res == true) {
          activities.removeWhere((v) => v.id == id);
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

  // void delMyPlant() async {
  //   BotToast.showLoading();
  //   try {
  //     await deleteMyPlant(id).then((res) {
  //       if (res is bool) {
  //         Get.find<HomeController>().myPlants.removeWhere((v) => v.id == id);
  //         Get.back();
  //       } else {
  //         customBotToastText(res);
  //       }
  //     });
  //   } catch (e) {
  //     customBotToastText(ErrorMessage.general);
  //   } finally {
  //     BotToast.closeAllLoading();
  //   }
  // }

  // void finishGrowingHandler() async {
  //   try {
  //     BotToast.showLoading();
  //     await finishGrowing(id).then((res) {
  //       if (res is MyPlant) {
  //         var myPlants = Get.find<HomeController>().myPlants;
  //         MyPlant temp = myPlants[myPlants.indexWhere((v) => v.id == id)]
  //           ..isDone = res.isDone
  //           ..progress = res.progress;
  //         Get.find<HomeController>().updatePlantData(this.id, temp);
  //       }
  //     });
  //   } catch (e) {
  //     customBotToastText(ErrorMessage.general);
  //   } finally {
  //     BotToast.closeAllLoading();
  //   }
  // }

  void updateData(MyPlant newPlant) {
    plant.update((val) {
      if (val != null) {
        val.id = newPlant.id;
        val.isDone = newPlant.isDone;
        val.name = newPlant.name;
        val.plant = newPlant.plant;
        val.plantId = newPlant.plantId;
        val.updatedAt = newPlant.updatedAt;
        val.userId = newPlant.userId;
      }
    });
  }
}
