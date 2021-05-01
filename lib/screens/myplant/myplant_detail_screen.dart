import 'package:ferma/controllers/myplant/myplant_detail_controller.dart';
import 'package:ferma/models/myplant_model.dart';
import 'package:ferma/widgets/checklist_item.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:ferma/widgets/plant_info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/screens/article/article_detail_screen.dart';
import 'package:ferma/screens/plant/plant_information_screen.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/loading_indicator.dart';
import 'package:ferma/widgets/my_app_bar.dart';
import 'package:ferma/widgets/my_flat_button.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyPlantDetailScreen extends StatelessWidget {
  final MyPlant data;

  MyPlantDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
        return Future.value(true);
      },
      child: GetX<MyPlantDetailController>(
        init: MyPlantDetailController(data),
        builder: (s) {
          bool isDone = (s.plant.value.isDone ?? false);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: MyAppBar(),
            ),
            body: ListView(
              padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
              children: [
                Stack(
                  children: [
                    Positioned(
                      right: 0,
                      child: loadImage(
                        s.plant.value.plant?.picture,
                        alignment: Alignment.centerRight,
                        height: 175,
                      ),
                    ),
                    Container(
                      width: Get.width / 2,
                      height: 180,
                      margin: EdgeInsets.only(bottom: 25),
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.plant.value.name ?? '',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            s.plant.value.plant?.plantName ?? '-',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 16,
                              color: MyColors.grey,
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Progress',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 10,
                                    color: MyColors.grey,
                                  ),
                                ),
                                // Text(
                                //   '${data!.progress}%',
                                //   style: TextStyle(
                                //     fontFamily: 'Montserrat',
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w700,
                                //     color: MyColors.darkGrey,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          // LinearPercentIndicator(
                          //   padding: EdgeInsets.symmetric(horizontal: 5),
                          //   width: 150,
                          //   lineHeight: 5,
                          //   percent: double.parse(data!.progress!) / 100,
                          //   progressColor: MyColors.gold,
                          //   backgroundColor: MyColors.lightGrey,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (!isDone) SizedBox(height: 50),
                if (!isDone)
                  Container(
                    width: Get.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyFlatButton(
                            text: 'Stop',
                            color: MyColors.lightGrey,
                            textColor: MyColors.darkGrey,
                            onPressed: () {
                              // s.delMyPlant();
                            },
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: MyFlatButton(
                            text: 'Finish',
                            onPressed: () {
                              // s.finishGrowingHandler();
                              // Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 25),
                Divider(
                  color: Colors.grey[400],
                ),
                SizedBox(height: 22.5),
                PlantInfoCard(
                  title: 'How to Set Up',
                  body: 'Learn how to set up the environtment',
                  onTap: () => Get.to(() => ArticleDetailScreen(
                        articleId: s.plant.value.plant?.category?.articleId,
                      )),
                ),
                PlantInfoCard(
                  title: 'How to Grow It',
                  body: 'Learn how to grow the plant like an expert',
                  onTap: () => Get.to(
                      () => PlantInformationScreen(data: s.plant.value.plant!)),
                ),
                if (!isDone)
                  PlantInfoCard(
                    title: 'Checklist',
                    showDivider: true,
                    showIcon: false,
                    child: s.isLoadingChecklist.value
                        ? loadingIndicator()
                        : s.checkList.isEmpty
                            ? Text(
                                'You dont have any checklist',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 14,
                                  color: MyColors.grey,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: s.checkList.length,
                                itemBuilder: (context, index) {
                                  Checklist item = s.checkList[index];
                                  return ChecklistListItem(
                                    item: item,
                                    onPressed: () {
                                      if (item.id != null) {
                                        s.doChecklist(item.id!);
                                      }
                                    },
                                  );
                                },
                              ),
                  ),
                PlantInfoCard(
                  title: 'Activity',
                  showDivider: true,
                  showIcon: false,
                  child: Column(
                    children: [
                      if (!isDone)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: MyTextField(
                            hintText: 'Add your activity',
                            controller: s.controller,
                            inputTextStyle:
                                TextStyle(fontWeight: FontWeight.normal),
                            suffix: GestureDetector(
                              child: Icon(
                                Icons.send_outlined,
                                color: MyColors.grey,
                                size: 17.5,
                              ),
                              onTap: () {
                                if (s.controller.text.isNotEmpty &&
                                    data.id != null) {
                                  s.postActivity(data.id!, s.controller.text);
                                }
                              },
                            ),
                          ),
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 25, left: 2.5),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: s.activities.length,
                        itemBuilder: (context, index) {
                          final Activity item = s.activities[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: MyColors.darkGrey,
                                        ),
                                      ),
                                      SizedBox(height: 2.5),
                                      Text(
                                        timeago.format(
                                            item.createdAt ?? DateTime.now()),
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 11,
                                          color: MyColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  splashColor: MyColors.grey,
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    color: MyColors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    if (item.id != null) {
                                      s.delActivity(item.id!);
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
