import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ferma/models/article_model.dart';
import 'package:ferma/services/article_service.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';

class ArticleController extends GetxController {
  final RxList<Article> articles = <Article>[].obs;
  final RxList<String> category = <String>['All'].obs;

  final RxString selectedCategory = 'All'.obs;
  final RxString searchQuery = ''.obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchData();
    fetchCategory();
    super.onInit();
  }

  void updateActiveCategory(String category) {
    selectedCategory.value = category.toString();
  }

  void fetchData() async {
    try {
      await ArticleService.getAllArticles().then((res) {
        if (res is List<Article>) {
          articles.addAll(res);
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

  void fetchCategory() async {
    try {
      await ArticleService.getAllCategory().then((res) {
        if (res is List<String>) {
          category.addAll(res);
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    }
  }
}
