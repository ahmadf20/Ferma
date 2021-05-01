import 'package:ferma/widgets/filter_tag.dart';
import 'package:ferma/widgets/my_app_bar.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/controllers/article/article_controller.dart';
import 'package:ferma/models/article_model.dart';
import 'package:ferma/screens/article/article_detail_screen.dart';
import 'package:ferma/widgets/load_image.dart';

class ArticlesSearchScreen extends StatelessWidget {
  const ArticlesSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ArticleController>(
      init: ArticleController(),
      builder: (s) {
        return WillPopScope(
          onWillPop: () {
            s.updateActiveCategory('All');
            s.searchQuery.value = '';
            return Future.value(true);
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: MyAppBar(),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: Column(
                    children: [
                      MyTextField(
                        hintText: 'What are you looking for?',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 25,
                        ),
                        autoFocus: true,
                        inputTextStyle:
                            TextStyle(fontWeight: FontWeight.normal),
                        onChanged: (val) {
                          s.searchQuery.value = val;
                        },
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
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                      children: [
                        ...s.articles.where((val) {
                          final bool matchesTitle = val.title
                              .toString()
                              .toLowerCase()
                              .contains(s.searchQuery.value);
                          final bool matchesCategory =
                              s.selectedCategory.value == 'All' ||
                                  (s.selectedCategory.value != 'All' &&
                                      val.category
                                          .toString()
                                          .contains(s.selectedCategory.value));
                          return matchesTitle && matchesCategory;
                        }).map((item) {
                          return _PostCard(data: item);
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          children: <Widget>[
            Container(
              width: 78,
              height: 78,
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
