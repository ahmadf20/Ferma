import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ferma/models/article_model.dart';
import 'package:ferma/services/article_service.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';

class ArticleController extends GetxController {
  final RxList<Article> articles = <Article>[].obs;
  final RxList<String> category = <String>['All'].obs;

  final Rx<Article> article = Article().obs;

  final RxString selectedCategory = 'All'.obs;
  final RxString searchQuery = ''.obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchAllArticle();
    fetchCategory();
    super.onInit();
  }

  List<Article> get getLatestArticle =>
      articles.sublist(0, articles.length > 4 ? 4 : articles.length);

  void updateActiveCategory(String category) {
    selectedCategory.value = category.toString();
  }

  void fetchAllArticle() async {
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
      if (isLoading.value) isLoading.toggle();
    }
  }

  void fetchDetailArticle(String articleId) async {
    try {
      await ArticleService.getDetailArticles(articleId).then((res) {
        if (res is Article) {
          updateArticle(res);
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

  void updateArticle(Article newArticle) {
    article.update((val) {
      if (val != null) {
        val.id = newArticle.id;
        val.title = newArticle.title;
        val.category = newArticle.category;
        val.description = newArticle.description;
        val.picture = newArticle.picture;
        val.source = newArticle.source;
        val.updatedAt = newArticle.updatedAt;
        val.createdAt = newArticle.createdAt;
        val.author = newArticle.author;
      }
    });
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
