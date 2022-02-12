import 'package:flutter/material.dart';
import 'package:carpool/LoginForm.dart';
import 'package:carpool/user.dart';

class Booking extends StatefulWidget{

  static newBookings newpage = newBookings();

  @override
  newBookings createState() {
    newpage = new newBookings();
    return newpage;
  }

}

class newBookings extends State<Booking>{

  late String date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }

  
}