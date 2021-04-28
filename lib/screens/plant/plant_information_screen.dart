import 'package:ferma/models/plant_model.dart';
import 'package:flutter/material.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/my_app_bar.dart';
import 'package:ferma/widgets/plant_info_card.dart';

class PlantInformationScreen extends StatelessWidget {
  final Plant data;

  const PlantInformationScreen({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MyAppBar(),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
        children: [
          SizedBox(height: 25),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
              ),
              child: loadImage(
                data.picture,
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            data.plantName!,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            data.category?.name ?? '',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              color: MyColors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          PlantInfoCard(
            title: 'Summary',
            body: data.summary,
            showDivider: true,
            showIcon: false,
          ),
          PlantInfoCard(
            title: 'Growing',
            body: data.growing,
            showDivider: true,
            showIcon: false,
          ),
          PlantInfoCard(
            title: 'Harvesting',
            body: data.harvesting,
            showDivider: true,
            showIcon: false,
          ),
          if (data.cropStatistics != null && data.cropStatistics!.isNotEmpty)
            PlantInfoCard(
              title: 'Crop Statistics',
              showDivider: true,
              showIcon: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Table(
                  children: [
                    //TODO: handle when array is empty or theres no data on the field
                    buildTableRow(
                      'Germination Days',
                      '${data.cropStatistics?.first.germDaysLow} - ${data.cropStatistics?.first.germDaysUp}',
                    ),
                    buildTableRow(
                      'Germination Temperature',
                      '${data.cropStatistics?.first.germTemperatureLow}ºC - ${data.cropStatistics?.first.germTemperatureUp}ºC',
                    ),
                    buildTableRow(
                      'Growth Days',
                      '${data.cropStatistics?.first.growthDaysLow} - ${data.cropStatistics?.first.growthDaysUp}',
                    ),
                    buildTableRow(
                      'Height',
                      '${data.cropStatistics?.first.heightLow} - ${data.cropStatistics?.first.heightUp} cm',
                    ),
                    buildTableRow(
                      'pH',
                      '${data.cropStatistics?.first.phLow} - ${data.cropStatistics?.first.phUp}',
                    ),
                    buildTableRow(
                      'Spacing',
                      '${data.cropStatistics?.first.spacingLow} - ${data.cropStatistics?.first.spacingUp} cm',
                    ),
                    buildTableRow(
                      'Temperature',
                      '${data.cropStatistics?.first.temperatureLow}ºC - ${data.cropStatistics?.first.temperatureUp}ºC',
                    ),
                    buildTableRow(
                      'Width',
                      '${data.cropStatistics?.first.widthLow} - ${data.cropStatistics?.first.widthUp} cm',
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  TableRow buildTableRow(String text, String text2) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: MyColors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            text2,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              color: MyColors.darkGrey,
            ),
          ),
        )
      ],
    );
  }
}
