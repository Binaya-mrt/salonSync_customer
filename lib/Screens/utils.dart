// void bookSlot(TimeSlot slot) async {
//   final formattedDate = DateFormat('yyyy-MM-dd').format(slot.startTime);
//   final docRef = FirebaseFirestore.instance
//       .collection('salons')
//       .doc(ownerId)
//       .collection('slots')
//       .doc(formattedDate)
//       .collection('slotTimes')
//       .doc(DateFormat('HH:mm').format(slot.startTime));
//   await docRef.set({'booked': true});
//   slot.isOccupied = true; // Update local state
// }