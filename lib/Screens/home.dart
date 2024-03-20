import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salonsync/Screens/Notification.dart';
import 'package:salonsync/Screens/shop_details.dart';
import 'package:salonsync/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:salonsync/controller/Auth/Fetch_Appointments.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     var _salons = Provider.of<ListProvider>(context, listen: false);
    _salons.getSalons(context);

      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   
   List<String> list = ['assets/images/pp1.jpg','assets/images/pp2.jpg','assets/images/pp3.jpg'];
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: appBar(context,_scaffoldKey),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Container(
          child: CarouselSlider(
        options: CarouselOptions(
           autoPlay: true,
        ),
        items: list
            .map((item) => Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Image(image: AssetImage(item),fit: BoxFit.fitWidth,),
                 
                ))
            .toList(),)),
    

        
            
            // Container(
              
            // ),
            _searchField(),
            _categoriesSection(),
            _featuredBarbers(),
          ],
        ),
      ),
      backgroundColor: bgColor,
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const DrawerHeader(
                child: Text('Notifications'),
              ),
              ListTile(
                title: const Text('Your appointment is confirmed!'),
                subtitle: Text(
                  'Your hair appointment for tomorrow at 10:00 AM is confirmed.',
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Appointment reminder'),
                subtitle: Text(
                  'Don\'t forget your upcoming massage appointment on Friday at 5:00 PM.',
                ),
              ),
            ],
          ),
        ),
      ),
      // Slider to control drawer opening
      drawerEnableOpenDragGesture: false,);// Disable default swipe gesture
    //   endDrawer: Slider(
    //     value: _drawerOpenAmount,
    //     onChanged: (double value) => setState(() => _drawerOpenAmount = value),
    //     min: 0.0,
    //     max: 1.0,
    //   ),
    // );
  
  }

  AppBar appBar(BuildContext context,key) {
    return AppBar(
      title: const Text(
        "SalonSync",
        style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Lato'),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: bgColor,
      leading: Container(
          margin: const EdgeInsets.all(14),
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user-image.png'),
            radius: 30,
          )),
      actions: [
        IconButton(
            onPressed: () {
               key.currentState!.openEndDrawer();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const NotificationPage()),
              // );
              Drawer();
            },
            icon: const Icon(
              Icons.notification_add_rounded,
              color: Colors.white,
              size: 30,
            ))
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xff364155),
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search Services',
            hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
            suffixIcon: Container(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Colors.white,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.filter_alt,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10, top: 20),
            child: Text(
              'Category',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10, top: 20, right: 10),
            child: Text(
              'View All',
              style: TextStyle(
                  color: themeColor, fontSize: 18, fontWeight: FontWeight.w200),
            ),
          ),
        ]),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 130,
          child: ListView.separated(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemBuilder: (context, index) {
List<String>_services=['Barbar','Shaving','Haricut','Straight','Barbar','Shaving','Haricut',];              
              return Column(
                children: [
                
                   CircleAvatar(
            backgroundImage: AssetImage('assets/images/s${index+1}.png'),
            radius: 40,
          ),
                  Text(
                    _services[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 17),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  Column _featuredBarbers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10, top: 20),
            child: Text(
              'Featured Salons',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10, top: 20, right: 10),
            child: Text(
              'View All',
              style: TextStyle(
                  color: themeColor, fontSize: 18, fontWeight: FontWeight.w200),
            ),
          ),
        ]),
        const SizedBox(
          height: 10,
        ),
        Consumer<ListProvider>(builder: (context, salons, child) {
          log("calling salon provider from home");
         
          return Container(
            height: 280,
            child: ListView.separated(
              itemCount: salons.salonLists.length >5?5:salons.salonLists.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              separatorBuilder: (context, index) => const SizedBox(
                width: 25,
              ),
              itemBuilder: (context, index) {
                log(salons.salonLists.length.toString());
                return GestureDetector(
                  onTap: (){
                  log(salons.salonLists.length.toString());
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SalonSetail(current_salon_index: index,endTime:salons.salonLists[index].saon_end_time ,startTime: salons.salonLists[index].salon_start_time,name: salons.salonLists[index].salon_name,)));
                  },
                  child: Container(
                      height: 280,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/salon.jpg'),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text(salons.salonLists[index].salon_name,style: pstyle,), Text('4.5',style: pstyle,)],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text(salons.salonLists[index].salon_address,style: pstyle,), Text('4.5 KM',style: pstyle,)],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Your button action here
                            },
                            child: Text('See Details',style:TextStyle(fontSize: 12,color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeColor,
                              shape: RoundedRectangleBorder(
                                
                                borderRadius: BorderRadius.circular(10.0), // Adjust as desired
                              ),
                            ),
                          ),
                        ),
                      ])),
                );
              },
            ),
          );
        }
        )
     ],
    );
  }
}
// salon['salon_name']