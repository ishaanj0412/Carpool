import 'package:flutter/material.dart';
import 'package:carpool/LoginForm.dart';
import 'package:carpool/user.dart';
import 'package:intl/intl.dart';

class Booking extends StatefulWidget{

  static newBookings newpage = newBookings();

  @override
  newBookings createState() {
    newpage = new newBookings();
    return newpage;
  }

}

class newBookings extends State<Booking>{

  String date = "Please Select date";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(75, 100, 75, 100),
        child: Center(
          child: ListTile(
            tileColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: ListView(
              children: <Widget>[
                ListTile(

                ),
              ],
            )
          )
        )
      )
    );
  }

  void setdate(bool val) async {
    setState(() {
      if(val){
        print("setdate called");
        var newFormat = DateFormat("dd-MM-yyyy");
        if (LoginForm.u.selected != null) date = newFormat.format(LoginForm.u.selected!);
      }
      else{
        date = "Please Select Date";
      }
    });  
  }
}