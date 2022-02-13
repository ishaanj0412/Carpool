import 'package:carpool/LoginForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'user.dart';

class DataBaseService {
  //reference to collection

  static final dbUsers = FirebaseFirestore.instance.collection('users');
  static final dbDates = FirebaseFirestore.instance.collection('dates');
  static Future<bool> exists(String uid) async {
    return await (dbUsers.where("emailid", isEqualTo: uid).get()).then((value) => value.size > 0 ? true : false);
  }

  static Future<void> updatedata(User u) async {
    return dbUsers.doc(u.emailId).set(u.toJson());
  }

  static Future<Stream<User>> getdatastream(String uid) async {
    return dbUsers.doc(uid).snapshots().map(_datafromsnap);
  }

  static Future<User> getData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> temp = await dbUsers.doc(uid).get();
    return User.fromJson(temp.data());
  }

  static User _datafromsnap(DocumentSnapshot snap) {
    return User(
      rollNumber: snap.get('rollnum'),
      emailId: snap.get('emailid'),
      dateRecords: snap.get('dates'),
    );
  }

  // Stream<QuerySnapshot> getuser() {
  //   return dbUsers.snapshots();
  // }

  // ignore: non_constant_identifier_names
  static Future AddRecord(DateTime date) async {
    var newFormat = DateFormat("yyyy-MM-dd");
    String dt = newFormat.format(date);

    return await dbDates.doc(dt).set(await LoginForm.u!.dateJson(date));
  }

  static Future<List<BookingRecord>> getBookingRecordsbyDate(String date) async {
    //dbUsers -> database as a list

    DocumentSnapshot<Map<String, dynamic>> temp = await dbDates.doc(date).get();
    return BookingRecord.fromJson(temp.data());
  }
}
