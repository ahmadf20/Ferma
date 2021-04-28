import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:ferma/models/article_model.dart';
import 'package:ferma/services/article_service.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';

class ArticleDetailController extends GetxController {
  RxBool isLoading = true.obs;

  final String? articleId;
  final Rx<Article>? article = Article().obs;

  final Article? articleItem;

  ArticleDetailController({this.articleId, this.articleItem});

  @override
  void onInit() {
    super.onInit();
    if (articleItem == null) {
      fetchDetailArticle(articleId!);
    } else {
      updateArticle(articleItem!);
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
    article!.update((val) {
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
}
