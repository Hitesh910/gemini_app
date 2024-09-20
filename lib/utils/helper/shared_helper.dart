import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper
{
  static SharedHelper helper = SharedHelper._();
  SharedHelper._();

  Future<void> setData(bool theme)
  async {
      SharedPreferences shr =await SharedPreferences.getInstance();
      shr.setBool("theme", theme);
  }

  Future<bool?> getData()
  async {
    SharedPreferences shr = await SharedPreferences.getInstance();
  bool? data =  shr.getBool("theme");
  return data;
  }
}