import 'package:ferma/controllers/plant/catalog_controller.dart';
import 'package:ferma/controllers/plant/plant_sugesttion.dart';
import 'package:ferma/models/plant_model.dart';
import 'package:ferma/utils/my_text_style.dart';
import 'package:ferma/widgets/app_title_bar.dart';
import 'package:ferma/widgets/filter_tag.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/my_flat_button.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/my_app_bar.dart';
import 'package:get/get.dart';

import 'catalog_plant_detail_screen.dart';

class PlantSuggestionScreen extends StatelessWidget {
  PlantSuggestionScreen({Key? key}) : super(key: key);

  final TextEditingController phTC = TextEditingController();
  final TextEditingController spaceTC = TextEditingController();
  final TextEditingController tempTC = TextEditingController();

  final PlantController plantController = Get.find<PlantController>();

  @override
  Widget build(BuildContext context) {
    return GetX<SuggestionController>(
      init: SuggestionController(),
      builder: (s) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: MyAppBar(),
          ),
          bottomSheet: Container(
            padding: EdgeInsets.all(25),
            child: MyFlatButton(
              text: 'Get a Suggestion',
              onPressed: () {
                s.getSuggestion(
                  phTC.text,
                  spaceTC.text,
                  tempTC.text,
                );
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 125),
            children: [
              AppTitleBar(
                title: 'Suggestion',
                desc: 'Helps you to decide what plant fits your condition',
              ),
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...plantController.category.map((val) {
                        return FilterTag(
                          value: val,
                          groupValue: plantController.selectedCategory.value,
                          text: val.name!,
                          onPressed: (value) {
                            plantController.updateActiveCategory(value);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              MyTextField(
                label: 'Average pH',
                controller: phTC,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 12),
              MyTextField(
                label: 'Available Space (optional)',
                controller: spaceTC,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 12),
              MyTextField(
                label: 'Average Temperature (ºC)',
                controller: tempTC,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 30),
              if (s.plants.isNotEmpty) ...[
                Text(
                  'Result',
                  style: MyTextStyle.sectionText,
                ),
                SizedBox(height: 5),
                Text(
                  'You might want to plant on of these',
                  style: MyTextStyle.sectionSubText,
                ),
                !s.hasResult.value
                    ? Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              size: 75,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Sorry, we don\'t have enough data to match your spesification',
                              style: MyTextStyle.sectionSubText,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, _) => SizedBox(height: 15),
                        padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: s.plants.length,
                        itemBuilder: (context, index) {
                          return buildListItem(s.plants[index]);
                        },
                      ),
              ],
            ],
          ),
        );
      },
    );
  }

  GestureDetector buildListItem(Plant data) {
    return GestureDetector(
      onTap: () => Get.to(() => CatalogDetailScreen(plant: data)),
      child: Row(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(5),
            ),
            child: loadImage(
              data.picture,
              boxFit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.plantName ?? '-',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.5),
                Text(
                  data.type?.name ?? '-',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    color: MyColors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: MyColors.grey,
          ),
        ],
      ),
    );
  }

  Container buildLabel(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 9, 12, 9),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          SizedBox(width: 7),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: MyColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
