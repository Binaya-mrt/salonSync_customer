import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:salonsync/constants.dart';
import 'package:intl/intl.dart';
import 'package:salonsync/controller/Auth/Fetch_Appointments.dart';
import 'package:salonsync/models/User_model.dart';

class SalonSetail extends StatelessWidget {
  final int current_salon_index;
  final int startTime;int endTime;
  final String name;
   SalonSetail({super.key, required this.current_salon_index,required this.endTime,required this.startTime,required this.name});
   
 



  @override
  Widget build(BuildContext context) {
      final provider = Provider.of<ListProvider>(context);
    
    return  Scaffold(
appBar:AppBar(title: Text(name),centerTitle: true,), 
body: SingleChildScrollView(
        child:Consumer<ListProvider>(builder: (context, salonDetails, child){
          return Column(
            children: [
              // Hero section with image and salon name
              _buildHeroSection(salonDetails.salonLists[current_salon_index].salon_address),
              // Information section with address, contact, timings
              _buildInformationSection(salonDetails.salonLists[current_salon_index]),
               Padding(
            padding:const  EdgeInsets.only(left: 8),
            child: Text(
              'Services',
              style: TextStyle(
                  color: themeColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
              Container(
                // color: Colors.red,
                height: 100,
              margin: EdgeInsets.only(left: 5),
              
                child: ListView.separated( 
                   separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: salonDetails.salonLists[current_salon_index].services.length,
                  itemBuilder: (context, index) {
                  return
                   Chip(
                    elevation: 10,
                    surfaceTintColor: Colors.red,
                    backgroundColor: themeColor.withOpacity(0.4),
                    label: Text(salonDetails.salonLists[current_salon_index].services[index].serviceName,style: const TextStyle(fontSize: 20)));
    
 

                }),
              ),
              // Services section with tabs and cards
              //
               Padding(
            padding: const EdgeInsets.only(left: 8,top:10,bottom: 10),
            child: Text(
              'Catalouge',
              style: TextStyle(
                  color: themeColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
//              Container(
//           height: 80,
//           child: ListView.separated(
//             itemCount: salonDetails.salonLists[current_salon_index].catalouges.length,
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             separatorBuilder: (context, index) => const SizedBox(
//               width: 25,
//             ),
//             itemBuilder: (context, index) {
              
// String formatServiceDuration(int durationInMinutes) {
//   int hours = durationInMinutes ~/ 60; // Integer division for full hours
//   int remainingMinutes = durationInMinutes % 60; // Remainder for remaining minutes

//   if (hours > 0) {
//     return '$hours hr ${remainingMinutes} min';
//   } else {
//     return '$durationInMinutes min';
//   }
// }
// String formatedDuration=formatServiceDuration(int.parse(salonDetails.salonLists[current_salon_index].catalouges[index].duration));
//               return GestureDetector(
                
//                 onTap: (){},
//                 child: Container(
//                   color: salonDetails.isSerivceSelected?themeColor:null,
//                   child: Column(
                    
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                       salonDetails.salonLists[current_salon_index].catalouges[index].serviceName,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 20),
//                       ),
//                        Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: [
                          
//                           Icon(Icons.price_check_rounded,color: themeColor,),
                  
                  
//                            Text(
//                                              "NPR ${salonDetails.salonLists[current_salon_index].catalouges[index].price}",
//                             style:  const TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 17),
//                                              ),
//                          ],
//                        ), Row(
//                          children: [
//                             Icon(Icons.timelapse_rounded,color: themeColor),
//                            Text(formatedDuration,
//                             style: const  TextStyle(
//                                 fontWeight: FontWeight.w400,
                                
//                                 fontSize: 17),
//                                              ),
//                          ],
//                        ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
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
                // color: Colors.red,
                height: 100,
              margin: EdgeInsets.only(left: 5),
              
                child: ListView.separated( 
                   separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: salonDetails.salonLists[current_salon_index].all_available_slots.length,
                  
                  itemBuilder: (context, index) {
                  
            // final formattedTime = DateFormat('h:mm a').format(slot.startTime);
                  return
                   GestureDetector(
                    onTap:()=>{} ,
                     child: Chip(
                      elevation: 10,
                      surfaceTintColor: Colors.red,
                      backgroundColor: salonDetails.isSlotSelected?Colors.green.shade400:themeColor.withOpacity(0.4),
                      label: Text("Helllo")),
                   );
    
 

                }),
              ),

              // Image gallery section
              // // Call to action button
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: themeColor),
                onPressed: () {
                 salonDetails.addAppointment('haircut', 11, 'Pinky Salon',true, 'done',salonDetails.salonLists[current_salon_index].salon_uid ,context);
                 
                },
                child: Text('Book Now',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            ],
          );
        }
        ),
      ),
    );
  }

  Widget _buildHeroSection(String imageUrl) {
    return Container(
      height: 200,
     decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/salon.jpg'))),
    
    );
  }

  Widget _buildInformationSection( salonData) {
        String formatTime(int hours) {
  final period = hours >= 12 ? 'PM' : 'AM';
  final adjustedHour = hours > 12 ? hours - 12 : hours;
  return '$adjustedHour${adjustedHour == 0 ? 12 : ''}${period}';
}

String formattedEndTime = formatTime(salonData.end_time);
String formattedStartTime = formatTime(salonData.start_time);



    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(salonData.address),
          Row(
            children: [
              Icon(Icons.phone),
              Text('986677263'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone),
              Text(salonData.name),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time),
              Text("$formattedStartTime- $formattedEndTime"),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildServicesSection(services) {
  //   return 
  // }
  // }

  Widget _buildImageGallery(List<String> imageUrls) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(color: Colors.blue,);
        },
      ),
    );
  }
}