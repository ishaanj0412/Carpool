import 'dart:developer';

import 'package:carpool/bookingdetails.dart';
import 'package:flutter/material.dart';
import 'package:carpool/LoginForm.dart';
import 'package:carpool/user.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:carpool/addbooking.dart';

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

  User curUser = LoginForm.u;
  late BookingRecord? curBookingRecord;
  late int curIntervalIndex;
  String date = "Select date";
  late TimeOfDay start;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 60, 40, 60),
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
                  height: 130,
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
                    onPressed: (){_selectTimeSlot();},
                    icon : Icon(
                      Icons.watch,
                      color: Colors.blue,
                    )
                  ),
                  ),
                  const SizedBox(
                  height: 130,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddBooking("11-02-2022", "2:00", "3:00", curIntervalIndex, curBookingRecord)));
                  },
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
        date = "Select Date";
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
        backgroundColor: Color(0xFF212121),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        children: <Widget>[
          const ListTile(
            title: Center(
              child: Text(
                "Select Time Interval",
                style: TextStyle(color: Colors.blue, fontSize: 22, fontFamily: 'Helvetica',fontWeight: FontWeight.bold),
              )
            )
          ),
          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Text(
                "Start-Time:",
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              title: Center(
                child: TextFormField(
                        validator: (value) {
                          if (value != null) {
            
                          }
                          if (value!.isEmpty) {
                            return 'Select Start-Time' ;
                          }

                          return 'Enter Valid Time';
                        },
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Helvetica'),
                          hintText: "Start-Time",
                          filled: true,
                          fillColor: const Color(0xFF424242),
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height:10),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: const Text(
                  "End-Time:",
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                  
                ),
              ),
              title: Center(
                child: TextFormField(
                        validator: (value) {
                          if (value != null) {
            
                          }
                          if (value!.isEmpty) {
                            return 'Select End-Time' ;
                          }

                          return 'Enter Valid Time';
                        },
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Helvetica'),
                          hintText: "End-Time",
                          filled: true,
                          fillColor: const Color(0xFF424242),
                          contentPadding: const EdgeInsets.fromLTRB(17, 15, 17, 15),
                          
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height:10),
          ListTile(
          trailing: SimpleDialogOption(
            onPressed: () { Navigator.pop(context, Options.OK); },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.green, fontSize: 14, fontFamily: 'Helvetica')
              ),
            // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
          ),
          leading: SimpleDialogOption(
            onPressed: () { Navigator.pop(context, Options.CANCEL); },
            child: const Text('Cancel',
            style: TextStyle(color: Colors.red),
            
          ),
          ),
          ),
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
void setbookings() async {
    print("setbookings called");
    var newFormat = DateFormat("yyyy-MM-dd");
    String dt = "";
    if (LoginForm.u.present != null) dt = newFormat.format(LoginForm.u.present!);

    curBookingRecord = null;
    curIntervalIndex = -1;
    curUser = LoginForm.u;

    // I have preset Date, there might be booking on that day or not
    // User -> BookingRecord
    // if (curBookingRecord is null) means that day has no record

    curBookingRecord = curUser.bookingRecordExists(dt);
  }
}