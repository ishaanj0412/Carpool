import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carpool/LoginForm.dart';
import 'package:carpool/user.dart';
import 'package:intl/intl.dart';

enum Options {OK,CANCEL}

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
  late TimeOfDay start;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(75, 150, 75, 150),
        child: Center(
          child: ListTile(
            tileColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: ListView(
              children: <Widget>[
                const ListTile(
                  title: Center(
                    child: Text(
                    "New Booking",
                    style: TextStyle(color: Colors.blue, fontSize: 24, fontFamily: 'Helvetica'),
                    ),
                  ),
                  tileColor: Color(0xFF212121),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Text(
                      "Date: ",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  title: Center(
                    child: Text(
                    date,
                    style: TextStyle(color: Colors.grey[400], fontSize: 18)),
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      _showCalendar(context);
                    },
                    icon : Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    )
                  ),
                  ),
                  const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Text(
                      "Time: ",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  title: Center(
                    child: Text(
                    date,
                    style: TextStyle(color: Colors.grey[400], fontSize: 18)),
                  ),
                  trailing: IconButton(
                    onPressed: (){},
                    icon : Icon(
                      Icons.watch,
                      color: Colors.blue,
                    )
                  ),
                  ),
                  const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                        "Get Details",
                        style: TextStyle(fontSize: 18),
                      ),
                  style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                        primary: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
                      ),
                )  
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

  _showCalendar(BuildContext context) async {
      LoginForm.u.selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2060),
      );
      // homepage.createState().setbookings();
      setdate(true);
    }
  
  Future<void> _selectTimeSlot() async {
  switch (await showDialog<Options>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text('Select assignment'),
        children: <Widget>[
          


          SimpleDialogOption(
            onPressed: () { Navigator.pop(context, Options.OK); },
            child: const Text('OK'),
            // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
          ),
          // SimpleDialogOption(
          //   onPressed: () { Navigator.pop(context, Options.CANCEL); },
          //   child: const Text('State department'),
          // ),
        ],
      );
    }
  )) {
    case Options.OK:
      // Let's go.
      // ...
    break;
    case Options.CANCEL:
      // ...
    break;
    case null:
      // dialog dismissed
    break;
  }
}
}