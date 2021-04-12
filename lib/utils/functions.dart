import 'shared_preferences.dart';

Future<Map<String, dynamic>> getHeader([bool hasToken = true]) async {
  // alternative
  // final response = await get('$url/users/me?_token=$token');

  Map<String, dynamic> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  if (hasToken) {
    header['x-access-token'] = '${await SharedPrefs.getToken()}';
  }
  return header;
}
