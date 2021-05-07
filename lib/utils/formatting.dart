import 'package:geocoding/geocoding.dart';

class GeneralFormat {
  static Future<String> printLocation(double lat, double long) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat, long, localeIdentifier: 'id_ID');
    return '${placemarks[0].subLocality}, ${placemarks[0].administrativeArea}';
  }

  static double getComplatePercentage(String percentage) {
    double val = (double.parse(percentage) / 100);

    if (val >= 1) return 1;
    return val;
  }
}
