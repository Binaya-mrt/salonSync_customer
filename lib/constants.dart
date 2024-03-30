// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// ali ali ta gardeu sathi 
// k garam ?
// code ramro dekhiyena, bich bich ma function xa
// malai flutter aaudaina yrr
// function ta dekhini chij nai haina ra ? ka k vayo vana ta
// ho ho

// k gardai xau ta?????
Color bgColor = const Color(0xff0e1116);
Color themeColor = const Color(0xfff66d0f);
TextStyle pstyle = const TextStyle(
    color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300);

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
