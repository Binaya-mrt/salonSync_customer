import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color bgColor=const Color(0xff0e1116);
Color themeColor=const Color(0xfff66d0f);
TextStyle pstyle=TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w300);

class Utils {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  SharedPreferences? getSharedPrefs() {
    SharedPreferences.getInstance().then((prefs) {
      return prefs;
    });
    return null;
  }
}
