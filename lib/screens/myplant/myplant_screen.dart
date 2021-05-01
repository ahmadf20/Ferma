import 'package:ferma/controllers/myplant/myplant_controller.dart';
import 'package:ferma/screens/plant/catalog_plant_screen.dart';
import 'package:ferma/widgets/app_title_bar.dart';
import 'package:ferma/widgets/filter_tag.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:ferma/widgets/myplant_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/loading_indicator.dart';
import 'package:ferma/widgets/my_app_bar.dart';

class MyPlantScreen extends StatelessWidget {
  MyPlantScreen({Key? key}) : super(key: key);

  final MyPlantController s = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
        return Future.value(true);
      },
      child: Obx(
        () {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: MyAppBar(),
            ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: MyColors.primary,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
              elevation: 1,
              onPressed: () async {
                await Get.to(() => CatalogPlantScreen())?.then((val) {
                  if (val) s.fetchData();
                });
              },
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 50),
              children: [
                AppTitleBar(
                  title: 'My Plant',
                  desc: 'Check what\'s your plant is doing',
                ),
                MyTextField(
                  hintText: 'Search',
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
                SizedBox(height: 25),
                s.isLoading.value
                    ? loadingIndicator()
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 75),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: s.filteredPlantList.length,
                        itemBuilder: (context, index) {
                          return MyPlantCard(
                            s.filteredPlantList[index],
                          );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
