import 'package:flutter/material.dart';
import 'package:salonsync/Screens/home.dart';
import 'package:salonsync/Screens/user_account.dart';
import 'package:salonsync/Screens/user_appointments.dart';
import 'package:salonsync/constants.dart';



/// This is a page that contains a buttom app bar.
/// It have four icons that navigates to four different screens.
///

class DefaultPage extends StatefulWidget {
  const DefaultPage({required this.pageno});
  final int pageno;

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  late int currnetIndex;

  @override
  void initState() {
    currnetIndex = widget.pageno;
    super.initState();
  }

  /// This is a list of screens navigated by icon in button nav bar
  /// [HomePage] is screen which show four categories.(clinic,shop,previous checkup and reminder).
  /// [Chat] is screen which will have chat features.
  /// [Cart] is used to show the list of item of cart of that particular user.
  /// [Account] screen have different user related options like report,orders etc.

  /// The UI related to these four screens are in homescreens folder.

  final screens = [
    const HomePage(),
     Appointment(),
    
     UserAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        currentIndex: currnetIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff364155),
        // showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 20,
        selectedItemColor: themeColor,
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          setState(() => currnetIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            label: "home",
            icon: Icon(Icons.home),
          ),
          
          BottomNavigationBarItem(
            label: 'Appointment',
            icon: Icon(Icons.calendar_month_outlined),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: IndexedStack(children: screens, index: currnetIndex),
    );
  }
}