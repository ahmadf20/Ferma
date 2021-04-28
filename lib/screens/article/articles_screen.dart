import 'package:ferma/screens/article/articles_search_screen.dart';
import 'package:ferma/utils/my_text_style.dart';
import 'package:ferma/widgets/app_title_bar.dart';
import 'package:ferma/widgets/filter_tag.dart';
import 'package:ferma/widgets/my_app_bar.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/controllers/article_controller.dart';
import 'package:ferma/models/article_model.dart';
import 'package:ferma/screens/article/article_detail_screen.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/loading_indicator.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ArticleController>(
      init: ArticleController(),
      builder: (s) {
        int totalArticle = s.articles.length;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: MyAppBar(),
          ),
          body: s.isLoading.value
              ? loadingIndicator() //TODO: add shimer instead
              : ListView(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  children: [
                    AppTitleBar(
                      title: 'Article',
                      desc: "The more you read, the more you know~",
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => ArticlesSearchScreen()),
                      child: Container(
                        color: Colors.transparent,
                        child: IgnorePointer(
                          ignoring: true,
                          child: MyTextField(
                            hintText: 'What are you looking for?',
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 25,
                            ),
                            inputTextStyle:
                                TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...s.category.map((val) {
                            return FilterTag(
                              value: val,
                              groupValue: s.selectedCategory.value,
                              text: val,
                              onPressed: (value) {
                                s.updateActiveCategory(value);
                                Get.to(() => ArticlesSearchScreen());
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Latest Article',
                      style: MyTextStyle.sectionText,
                    ),
                    SizedBox(height: 25),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (totalArticle > 0)
                              ...s.articles
                                  .sublist(
                                      0, totalArticle > 3 ? 3 : totalArticle)
                                  .map((item) {
                                return _LatestPostCard(
                                  data: item,
                                );
                              }).toList(),
                          ]),
                    ),
                    if (totalArticle > 3) ...[
                      SizedBox(height: 20),
                      Text(
                        'All Article',
                        style: MyTextStyle.sectionText,
                      ),
                      SizedBox(height: 25),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ...s.articles.sublist(3).map((item) {
                            return _PostCard(data: item);
                          }).toList(),
                        ],
                      ),
                    ],
                  ],
                ),
        );
      },
    );
  }
}

class _LatestPostCard extends StatelessWidget {
  final Article? data;

  const _LatestPostCard({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ArticleDetailScreen(
        data: data,
      )),
      child: Container(
        width: 225,
        margin: EdgeInsets.only(right: 25, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: loadImage(
                    data!.picture,
                    isShowLoading: false,
                    height: 250,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    data!.category!,
                    style: TextStyle(
                      fontSize: 10,
                      color: MyColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.maxFinite,
              child: Text(
                data!.title!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Article? data;

  const _PostCard({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ArticleDetailScreen(
        data: data,
      )),
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: loadImage(
                    data!.picture,
                    isShowLoading: false,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      data!.category!,
                      style: TextStyle(
                        fontSize: 10,
                        color: MyColors.darkGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      data!.title!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    data!.author?.username ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 25),
          ],
        ),
      ),
    );
  }
}
