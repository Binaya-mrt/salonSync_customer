// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';

// // class Salon {
// //   String address;
// //   List<Catalouge> catalouge;
// //   String name;
// //   List services;
// //   List<TimeSlot?>? slots;
// //   String uid;
// //   int start_time;
// //   int end_time;

// //   Salon(
// //       {required this.address,
// //       required this.catalouge,
// //       required this.end_time,
// //       required this.name,
// //       required this.services,
// //        this.slots,
// //        required this.uid,
// //       required this.start_time}) ;
// //       // List<Appointment>.from(appointments!.map((x) => x.toMap()))

// //  factory Salon.fromMap(Map<String, dynamic> data) {
// //     return Salon(address: data['Address'],
// //     catalouge: data['Catalouge'].map((p) => Catalouge.fromJson(p)).toList().cast<Catalouge>(),
// //     end_time: data['End_time'], name: data['Name'], services: data['Services'], uid: data['uid'], start_time: data['Start_time'], slots: data['slots']?.map((p) => TimeSlot.fromJson(p)).toList().cast<TimeSlot>(),);

// //   }
// // //
// //        factory Salon.fromJson(Map<String, dynamic> json) => Salon(address: json['Address'], catalouge: json['Catalouge'], end_time: json['End_time'], name: json['Name'], services: json['Services'].map((p) => (p)).toList().cast<String>(),  start_time: json['Start_time'],slots: json['slots'],uid:json['uid']);

// //   static Salon fromSnap(DocumentSnapshot snap) {
// //     var snapshot = snap.data() as Map<String, dynamic>;
// // log(snapshot.toString());
// // return Salon(address: snapshot['Address'],uid: snapshot['uid'], catalouge: snapshot['Catalouge'].map((p) => Catalouge.fromJson(p)).toList().cast<Catalouge>(),end_time: snapshot['End_time'], name: snapshot['Name'], services: snapshot['Services'].map((p) => (p)).toList().cast<String>(),  start_time: snapshot['Start_time'],slots: snapshot['slots'].map((p) => TimeSlot.fromJson(p)).toList().cast<TimeSlot>(),
// //     );

// //   }

// //       }

// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class Salon {
//   final String salon_name;
//   final String salon_address;
//   final String salon_email;
//   final int salon_start_time;
//   final String salon_phone;
//   final int saon_end_time;
//   final List<Service> services;
//   final List<Catalogue> catalouges;
//   final String salon_image;
//   final String salon_uid;
//   final List<TimeSlot> all_available_slots;

//   Salon(
//       {required this.salon_start_time,
//       required this.saon_end_time,
//       required this.salon_address,
//       required this.catalouges,
//       required this.salon_email,
//       required this.salon_name,
//       required this.services,
//       required this.all_available_slots,
//       required this.salon_image,
//       required this.salon_phone,
//       required this.salon_uid});

//   static Salon fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//     log(snapshot.toString());
//     return Salon(
//       salon_address: snapshot['salon_address'],
//       catalouges: snapshot['catalouges']
//           ,
//       salon_email: snapshot['salon_email'],
//       salon_name: snapshot['salon_name'],
//       salon_start_time: snapshot['salon_start_time'],
//       saon_end_time: snapshot['salon_ratingsalon_end_time'],
//       services: snapshot['Services']
//           .map((p) => Service.fromJson(p))
//           .toList()
//           .cast<Service>(),
//       all_available_slots: snapshot['all_available_slots']
//           .map((p) => TimeSlot.fromJson(p))
//           .toList()
//           .cast<TimeSlot>(),
//       salon_image: snapshot['salon_image'],
//       salon_phone: snapshot['salon_phone'],
//       salon_uid: snapshot['uid'],
//     );
//   }
// //

//   factory Salon.fromMap(Map<String, dynamic> data) {
//     return Salon(
//         salon_address: data['salon_address'],catalouges: data['catalogues']as List<Catalogue> ,
        
//         saon_end_time: data['salon_ratingsalon_end_time'],
//         salon_name: data['salon_name'],
//         services: data['Services'] as List<Service>,
//         salon_uid: data['uid'],
//         salon_start_time: data['salon_start_time'],
//         all_available_slots: data['slots']
//             as List<TimeSlot>,
//         salon_email: data['salon_email'],
//         salon_image: data['salon_image'],
//         salon_phone: data['salon_phone']);
//   }

// // servicename
// // duration price servicename

// // TODO: from map
// // TODO: to map
// // TODO: to json
// }

// class Catalogue {
//   String serviceName;
//   double price;
//   String duration;

//   Catalogue(
//       {required this.serviceName, required this.price, required this.duration});
//   Map<String, dynamic> toMap() =>
//       {"servicename": serviceName, "price": price, "duration": duration};

//  factory Catalogue.fromJson(Map<String, dynamic> json) {
//     return Catalogue(
//       serviceName: json['serviceName'],
//       price: json['price'].toDouble(),
//       duration: json['duration'],
//     );
//   }


 
// }

// class Service {
//   String serviceName;

//   Service({required this.serviceName});
//   Map<String, dynamic> toMap() => {
//         "servicename": serviceName,
//       };

//   factory Service.fromJson(Map<String, dynamic> json) =>
//       Service(serviceName: json['servicename']);
// }

// class TimeSlot {
//   final int startTime;
//   final bool isOccupied;

//   TimeSlot({required this.startTime, this.isOccupied = false});

//   Map<String, dynamic> toMap() =>
//       {"slot_start_time": startTime, "is_occupied": isOccupied};

//   factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
//       startTime: json['slot_start_time'], isOccupied: json['is_occupied']);
// }

// class Catalouge {
//   String name;
//   int price;
//   String duration;

//   Catalouge({required this.duration, required this.name, required this.price});
//   factory Catalouge.fromJson(Map<String, dynamic> json) => Catalouge(
//       duration: json['duration'],
//       name: json['servicename'],
//       price: json['price']);
// }




import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Salon {
  final String salon_name;
  final String salon_address;
  final String salon_email;
  final int salon_start_time;
  final String salon_phone;
  final int saon_end_time;
  final List<Service> services;
  final List<Catalogue> catalouges;
  final String salon_image;
  final String salon_uid;
  final List<TimeSlot> all_available_slots;

  Salon({
    required this.salon_start_time,
    required this.saon_end_time,
    required this.salon_address,
    required this.catalouges,
    required this.salon_email,
    required this.salon_name,
    required this.services,
    required this.all_available_slots,
    required this.salon_image,
    required this.salon_phone,
    required this.salon_uid,
  });

  static Salon fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    log(snapshot.toString());
    return Salon(
      salon_address: snapshot['salon_address'],
      catalouges: (snapshot['catalogues'] as List<dynamic>?)?.map((p) => Catalogue.fromJson(p))
          .toList()
          .cast<Catalogue>() ??
          const [],
      salon_email: snapshot['salon_email'],
      salon_name: snapshot['salon_name'],
      salon_start_time: snapshot['salon_start_time'],
      saon_end_time: snapshot['salon_ratingsalon_end_time'],
      services: snapshot['Services']
          .map((p) => Service.fromJson(p))
          .toList()
          .cast<Service>(),
      all_available_slots: snapshot['all_available_slots']
          .map((p) => TimeSlot.fromJson(p))
          .toList()
          .cast<TimeSlot>(),
      salon_image: snapshot['salon_image'],
      salon_phone: snapshot['salon_phone'],
      salon_uid: snapshot['uid'],
    );
  }

  factory Salon.fromMap(Map<String, dynamic> data) => Salon(
        salon_address: data['salon_address'],
        catalouges: data['catalouges'] as List<Catalogue>,
        salon_email: data['salon_email'],
        salon_name: data['salon_name'],
        services: data['Services'] as List<Service>,
        salon_uid: data['uid'],
        salon_start_time: data['salon_start_time'],
        all_available_slots: data['slots'] as List<TimeSlot>,
        salon_image: data['salon_image'],
        salon_phone: data['salon_phone'], saon_end_time: data['salon_ratingsalon_end_time'],
      );
}

class Catalogue {
  String serviceName;
  double price;
  String duration;

  Catalogue({required this.serviceName, required this.price, required this.duration});

  Map<String, dynamic> toMap() =>
      {"servicename": serviceName, "price": price, "duration": duration};

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
        serviceName: json['serviceName'],
        price: json['price'].toDouble(),
        duration: json['duration'],
      );
}

class Service {
  String serviceName;

  Service({required this.serviceName});

  Map<String, dynamic> toMap() => {
        "servicename": serviceName,
      };

  factory Service.fromJson(Map<String, dynamic> json) =>
      Service(serviceName: json['servicename']);
}

class TimeSlot {
  final int startTime;
  final bool isOccupied;

  TimeSlot({required this.startTime, this.isOccupied = false});

  Map<String, dynamic> toMap() =>
      {"slot_start_time": startTime, "is_occupied": isOccupied};

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        startTime: json['slot_start_time'],
        isOccupied: json['is_occupied'],
      );
}
