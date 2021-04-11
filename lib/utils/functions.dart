import 'shared_preferences.dart';

Future getHeader([bool hasToken = true]) async {
  // alternative
  // final response = await get('$url/users/me?_token=$token');

  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  if (hasToken) {
    header['Authorization'] = 'Bearer ${await SharedPrefs.getToken()}';
  }
  return header;
}
