import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:salonsync/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';

class SalonSetail extends StatefulWidget {
  final String uid;
  final String name;
  SalonSetail({super.key, required this.uid, required this.name});

  @override
  State<SalonSetail> createState() => _SalonSetailState();
}
int selectedIndex=-1;
int bookedIndex=-1;
String selected_service_name='';
int selected_service_price=-1;
Timestamp  bookedSlot=Timestamp.now();


 DatePickerController _datePickerController = DatePickerController();

  var now = DateTime.now();
    DateTime startDate = now.subtract(Duration(days: 0));
    DateTime endDate = now.add(Duration(days: 5));
    

class _SalonSetailState extends State<SalonSetail> {
// required this.current_salon_index,required this.endTime,required this.startTime,required this.name
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Salon')
                    .where('uid', isEqualTo: widget.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<QueryDocumentSnapshot> documents =
                        snapshot.data!.docs;
                    for (var doc in documents) {
                      String convertToReadableTime(int time) {
                        if (time < 0 || time > 24) {
                          throw ArgumentError('Invalid time: $time');
                        }

                        String period = time >= 12 ? 'PM' : 'AM';
                        int hour = time > 12 ? time - 12 : time;
                        if (hour == 0) hour = 12;

                        return '$hour ${period.toUpperCase()}';
                      }

                      String getSalonTiming(int startTime, int endTime) {
                        if (startTime < 0 ||
                            startTime > 24 ||
                            endTime < 0 ||
                            endTime > 24) {
                          throw ArgumentError('Invalid start or end time');
                        }

                        String start = convertToReadableTime(startTime);
                        String end = convertToReadableTime(endTime);

                        return '$start to $end';
                      }

                      String timing = getSalonTiming(doc['salon_start_time'],
                          doc['salon_ratingsalon_end_time']);
                      return Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            kIsWeb
                                ? ImageNetwork(
                                    image: doc['salon_image'],
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    fitWeb: BoxFitWeb.cover,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                doc['salon_image'])))),
                            Text(
                              doc['salon_name'],
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              doc['salon_address'],
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              doc['salon_phone'],
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              timing,
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              // color: Colors.red,
                              height: 100,
                              margin: EdgeInsets.only(left: 5),

                              child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 10,
                                      ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: doc['Services'].length,
                                  itemBuilder: (context, index) {
                                    return Chip(
                                        elevation: 10,
                                        surfaceTintColor: Colors.red,
                                        backgroundColor:
                                            themeColor.withOpacity(0.4),
                                        label: Text(
                                            doc['Services'][index]
                                                ['servicename'],
                                            style:
                                                const TextStyle(fontSize: 20)));
                                  }),
                            ),
                             Container(
          height: 100,
          child: ListView.separated(
            itemCount: doc['catalogues'].length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemBuilder: (context, index) {
              
String formatServiceDuration(int durationInMinutes) {
  int hours = durationInMinutes ~/ 60; // Integer division for full hours
  int remainingMinutes = durationInMinutes % 60; // Remainder for remaining minutes

  if (hours > 0) {
    return '$hours hr ${remainingMinutes} min';
  } else {
    return '$durationInMinutes min';
  }
}
String formatedDuration=formatServiceDuration(int.parse(doc['catalogues'][index]['duration']));



            // int isSelected = doc['catalogues'][index];
          
           
              return GestureDetector(
              
                onTap: (){
                  
                  setState(() {
                    selected_service_name =  doc['catalogues'][index]['servicename'];
                  selected_service_price=doc['catalogues'][index]['price'];
                  selectedIndex=index;
                  log(selectedIndex.toString());
                  });
                 
                
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration( color:  index==selectedIndex
                  ? Colors.green.withOpacity(0.4):
                                              themeColor.withOpacity(0.4),borderRadius: BorderRadius.circular(10)),
                
                  child: Column(
                    
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                     doc['catalogues'][index]['servicename'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                       Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                          
                          Icon(Icons.price_check_rounded,color: themeColor,),
                  
                  
                           Text(
                                             "NPR ${doc['catalogues'][index]['price']}",
                            style:  const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17),
                                             ),
                         ],
                       ), Row(
                         children: [
                            Icon(Icons.timelapse_rounded,color: themeColor),
                           Text(formatedDuration,
                            style: const  TextStyle(
                                fontWeight: FontWeight.w400,
                                
                                fontSize: 17),
                                             ),
                         ],
                       ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: HorizontalDatePickerWidget(
       selectedColor :themeColor.withOpacity(0.4),
        startDate: startDate,
        endDate: endDate,
        selectedDate: now,
        widgetWidth: MediaQuery.of(context).size.width,
        datePickerController: _datePickerController,
        onValueSelected: (date) {
          print('selected = ${date.toIso8601String()}');
        },
      ),
    ),
        Padding(
            padding: const EdgeInsets.only(left: 8,),
            child: Text(
              'Available Slots',
              style: TextStyle(
                  color: themeColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
        Container(
                            
                              height: 100,
                              margin: EdgeInsets.only(left: 5),

                              child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 10,
                                      ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: doc['all_available_slots'].length,
                                  itemBuilder: (context, index) {

                                   String convertToReadableTime(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}

String getSalonTiming(Timestamp startTime) {
  String start = convertToReadableTime(startTime);
  

  return '$start ';
}

String start_time=getSalonTiming(doc['all_available_slots'][index]['slot_start_time']);
                                    return GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          bookedSlot=doc['all_available_slots'][index]['slot_start_time'];
                                          bookedIndex=index;
                                        });
                                      },
                                      child: Chip(
                                          elevation: 10,
                                          surfaceTintColor: Colors.red,
                                          backgroundColor:
                                          index==bookedIndex?Colors.green.withOpacity(0.4):
                                              themeColor.withOpacity(0.4),
                                          label: Text(
                                              start_time,
                                              style:
                                                  const TextStyle(fontSize: 20))),
                                    );
                                  }),
                            ),
                            Center(child: ElevatedButton(onPressed: (){
                              //appointId,salonId,UserId,serviceName,ServicePrice,status,slot,Date,payment
                            }, child: Text('Book Now',style: TextStyle(fontSize: 20,color: Colors.white),)),)
                          ],
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text("Hello");
                  }

                  return Divider();
                })));
  }

  // Widget _buildInformationSection( salonData) {
  Widget _buildImageGallery(List<String> imageUrls) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
          );
        },
      ),
    );
  }
}
