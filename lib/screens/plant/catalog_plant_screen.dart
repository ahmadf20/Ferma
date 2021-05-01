import 'package:ferma/screens/plant/plant_suggestion_screen.dart';
import 'package:ferma/widgets/app_title_bar.dart';
import 'package:ferma/widgets/filter_tag.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/controllers/plant/catalog_controller.dart';
import 'package:ferma/models/plant_model.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/loading_indicator.dart';
import 'package:ferma/widgets/my_app_bar.dart';

import 'catalog_plant_detail_screen.dart';

class CatalogPlantScreen extends StatelessWidget {
  const CatalogPlantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
        return Future.value(true);
      },
      child: GetX<PlantController>(
        init: PlantController(),
        builder: (s) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: MyAppBar(),
            ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: MyColors.yellowFaded,
              child: Icon(
                Icons.info_outline_rounded,
                color: MyColors.yellow,
                size: 25,
              ),
              elevation: 1,
              onPressed: () => Get.to(PlantSuggestionScreen()),
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 50),
              children: [
                AppTitleBar(
                  title: 'Discover',
                  desc: 'Find your favorite plant to grow',
                ),
                MyTextField(
                  hintText: 'What are you looking for?',
                  controller: s.searchTC,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 25,
                  ),
                  inputTextStyle: TextStyle(fontWeight: FontWeight.normal),
                  onChanged: (v) {
                    s.updateQuery(v);
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
                          text: val.name!,
                          onPressed: (value) {
                            s.updateActiveCategory(value);
                          },
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                s.isLoading.value
                    ? loadingIndicator()
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 35,
                          mainAxisSpacing: 25,
                        ),
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 35),
                        itemCount: s.filteredPlantList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _CardItem(plant: s.filteredPlantList[index]);
                        },
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  final Plant? plant;

  const _CardItem({Key? key, this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(CatalogDetailScreen(plant: plant!)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: loadImage(
                      plant!.picture,
                      height: 110,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              plant!.plantName!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  plant!.category?.name ?? '',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12,
                    color: MyColors.grey,
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
