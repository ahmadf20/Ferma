import 'package:ferma/controllers/myplant/myplant_controller.dart';
import 'package:ferma/models/myplant_model.dart';
import 'package:ferma/screens/myplant/myplant_detail_screen.dart';
import 'package:ferma/utils/formatting.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'checklist_item.dart';
import 'load_image.dart';

class MyPlantCard extends StatelessWidget {
  final MyPlant data;

  const MyPlantCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Get.to(() => MyPlantDetailScreen(data: data))?.then((val) {
          if (val) Get.find<MyPlantController>().fetchData();
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.fromLTRB(22.5, 15, 10, 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 35,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name ?? '-',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: MyColors.darkGrey,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  '${data.plant?.plantName ?? ''} - ' +
                                      (data.finishTask == data.totalTask
                                          ? 'Finish'
                                          : '${data.finishTask}/${data.totalTask} Tasks'),
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 12,
                                    color: MyColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            child: VerticalDivider(
                              color: MyColors.grey,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Progress',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 10,
                                  color: MyColors.grey,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                '${data.progress}%',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: MyColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      LinearPercentIndicator(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        lineHeight: 5,
                        percent: GeneralFormat.getComplatePercentage(
                            data.progress ?? '0'),
                        progressColor: MyColors.gold,
                        backgroundColor: MyColors.lightGrey,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                loadImage(data.plant?.picture, height: 85),
              ],
            ),
            if (!(data.isDone ?? false) &&
                data.checklists != null &&
                data.checklists!.isNotEmpty) ...[
              Divider(
                color: Colors.grey,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.checklists?.length ?? 0,
                padding: EdgeInsets.only(top: 5),
                itemBuilder: (context, index) {
                  if (data.checklists == null) return Container();

                  Checklist item = data.checklists![index];
                  return ChecklistListItem(
                    item: item,
                    showDesc: false,
                    onPressed: () {
                      if (item.myplantId != null && item.id != null) {
                        Get.find<MyPlantController>()
                            .doChecklist(item.myplantId!, item.id!);
                      }
                    },
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
