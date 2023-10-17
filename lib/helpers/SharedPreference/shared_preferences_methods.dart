import 'package:shared_preferences/shared_preferences.dart';

void setStringIntoCache(String key, String? value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(key, value ?? "");
}

void setListIntoCache(String key, List<String>? value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setStringList(key, value!);
}

void removeStringFromCache(String? key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.remove(key!);
}

void setBooleanIntoCache(String? key, bool? value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool(key!, value!);
}

void setIntIntoCache(String? key, int? value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setInt(key!, value ?? 0);
}

void setSocietyUrlIntoCache(String? societyUrl) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString('baseUrl', societyUrl!);
}

Future<String> getStringFromCache(String? key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(key!) ?? '';
}

Future<List<String>?> getListFromCache(String? key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getStringList(key!);
}

Future<int> getIntFromCache(String? key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getInt(key!) ?? 0;
}

Future<bool?> getBooleanFromCache(String? key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool(key!) ;
}
