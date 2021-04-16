import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:ferma/models/article_model.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/my_app_bar.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article? data;

  ArticleDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MyAppBar(),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25, 15, 25, 25),
        children: <Widget>[
          Text(
            data!.title!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '${data!.author?.username ?? '-'} • ${DateFormat('d MMMM yyyy').format(data!.updatedAt!)}',
            style: TextStyle(
              color: MyColors.grey,
              fontFamily: 'OpenSans',
              fontSize: 12,
            ),
          ),
          SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: loadImage(
              data!.picture,
              isShowLoading: false,
              height: 250,
            ),
          ),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                data!.category!,
                style: TextStyle(
                  fontSize: 12,
                  color: MyColors.darkGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Divider(
            indent: 5,
            endIndent: 5,
          ),
          Html(
            data: '''${data!.description}''',
            style: {
              "*": Style(
                fontFamily: 'OpenSans',
                fontSize: FontSize.medium,
                color: MyColors.darkGrey,
                lineHeight: LineHeight.number(1.5),
              ),
              "p": Style(
                fontFamily: 'OpenSans',
                fontSize: FontSize.medium,
                color: MyColors.darkGrey,
                //TODO: find a way to justify text
              ),
            },
          ),
        ],
      ),
    );
  }
}
