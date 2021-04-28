import 'package:ferma/controllers/catalog_controller.dart';
import 'package:ferma/models/plant_model.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/screens/article/article_detail_screen.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/my_app_bar.dart';
import 'package:ferma/widgets/plant_info_card.dart';
import 'package:ferma/widgets/my_flat_button.dart';

import 'plant_information_screen.dart';

class CatalogDetailScreen extends StatelessWidget {
  final Plant plant;

  CatalogDetailScreen({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlantController plantController = Get.find<PlantController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MyAppBar(),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(25),
        child: MyFlatButton(
          text: 'Grow This',
          onPressed: () => Get.bottomSheet(
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.fromLTRB(25, 45, 25, 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Pick a Name!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: MyColors.darkGrey,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Hey, your plant deserves a name! The only limit is your imagination.',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14,
                        color: MyColors.grey,
                      ),
                    ),
                    SizedBox(height: 15),
                    MyTextField(
                      hintText: 'Type a name here ...',
                      controller: plantController.plantNameTC,
                      inputTextStyle: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 30),
                    MyFlatButton(
                      text: 'Start the Journey',
                      onPressed: () => plantController
                          .addMyPlantHandler(plant.id.toString()),
                    ),
                  ],
                ),
              ),
            ),
            enableDrag: true,
            isScrollControlled: true,
            enterBottomSheetDuration: Duration(microseconds: 200),
            exitBottomSheetDuration: Duration(microseconds: 200),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 125),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(20),
              child: loadImage(plant.picture ?? ''),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: Get.width / 2,
            alignment: Alignment.bottomLeft,
            child: Text(
              plant.plantName ?? '',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 25),
          Wrap(
            spacing: 15,
            children: [
              buildLabel(
                plant.category?.name ?? '',
                Icons.category_outlined,
              ),
              buildLabel(
                plant.categoryId ?? '', //TODOl change to type name
                Icons.layers_outlined,
              ),
            ],
          ),
          SizedBox(height: 25),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 22.5),
          PlantInfoCard(
            title: 'How to Set Up',
            body: 'Learn how to set up the environtment',
            onTap: () => Get.to(
                ArticleDetailScreen(articleId: plant.category?.articleId)),
          ),
          PlantInfoCard(
            title: 'How to Grow It',
            body: 'Learn how to grow the plant like an expert',
            onTap: () => Get.to(PlantInformationScreen(data: plant)),
          ),
          PlantInfoCard(
            title: 'Summary',
            body: plant.summary ?? '',
            showDivider: true,
            showIcon: false,
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
