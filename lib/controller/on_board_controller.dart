// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:salonsync/buttom_appbar.dart';
import 'package:salonsync/screens/login_page.dart';

class OnboardModel {
  final image;
  final title;
  final description;

  OnboardModel(this.image, this.title, this.description);
}

class OnboardController extends GetxController {
  var pageContoller = PageController();
  var selectedPageIndex = 0.obs;

  bool get isLastPage => selectedPageIndex.value == onboard.length - 1;

  forwardAction(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString('uuid');

    if (isLastPage) {
      prefs.setBool('first_user', false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              uuid == null ? const LoginPage() : const DefaultPage(pageno: 0),
        ),
        // Get.off(DefaultPage(pageno: 0))
      );
    } else {
      pageContoller.nextPage(duration: 3000.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardModel> onboard = <OnboardModel>[
    OnboardModel(
      ('assets/images/1.jpg'),
      ('Beard gives personality'),
      ('Get your beard fixed, get your personality'),
    ),
    OnboardModel(
      ('assets/images/2.jpg'),
      ('Gloomy hair makes day gloomy'),
      ('Get your hair a perfect treatement today'),
    ),
    OnboardModel(
      ('assets/images/3.jpg'),
      ('What a busy day?'),
      ('Throw away your tiredness with warm spa'),
    ),
  ];
}
