import 'dart:developer';

import 'package:carpool/bookingdetails.dart';
import 'package:flutter/material.dart';
import 'package:carpool/LoginForm.dart';
import 'package:interval_tree/interval_tree.dart' as iv;
import 'package:carpool/user.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:carpool/addbooking.dart';

enum Options { OK, CANCEL }

class Booking extends StatefulWidget {
  static newBookings newpage = newBookings();

  @override
  newBookings createState() {
    newpage = new newBookings();
    return newpage;
  }
}

class newBookings extends State<Booking> {
  User curUser = LoginForm.u;
  late BookingRecord? curBookingRecord;
  late int curIntervalIndex;
  String date = "Select date";
  late String startime, endtime;
  String interval = "Select Time";
  late final TextEditingController select_start_time = TextEditingController();
  late final TextEditingController select_end_time = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  double height =100;
  double width =100;
  newBookings() {
    curBookingRecord = null;
    curIntervalIndex = -1;
    curUser = LoginForm.u;
  }

  @override
  Widget build(BuildContext context) {
    //settime(false);
    if(MediaQuery.maybeOf(context)!=null) {
      height = MediaQuery.maybeOf(context)!.size.height;
    }
    if(MediaQuery.maybeOf(context)!=null) {
      width = MediaQuery.maybeOf(context)!.size.width;
    }
    // print(width); print(height);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
            padding: EdgeInsets.fromLTRB(width*0.1,height*0.1, width*0.1, height*0.1),
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
                        SizedBox(
                          height: 0.1*height,
                        ),
                        ListTile(
                          leading: Text(
                            "Date: ",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          title: Center(
                            child: Text(date, style: TextStyle(color: Colors.grey[400], fontSize: 18)),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                _showCalendar(context);
                              },
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                              )),
                        ),
                        SizedBox(
                          height: 0.05*height,
                        ),
                        ListTile(
                          leading: Text(
                            "Time: ",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          title: Center(
                            child: Text(interval, style: TextStyle(color: Colors.grey[400], fontSize: 18)),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                _selectTimeSlot();
                              },
                              icon: Icon(
                                Icons.watch,
                                color: Colors.blue,
                              )),
                        ),
                        SizedBox(
                          height: 0.05*height,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 0.05*height),
                          child: ElevatedButton(
                            onPressed: () {
                              //call bookifexusts
                              //store result in flag
                              // if flag is ok -> navigator push
                              //else toast message "Booking already exists"
                              if (curBookingRecord != null) {
                                if (curUser.doesIntervalExist(curBookingRecord!, iv.Interval(int.parse(startime), int.parse(endtime)))) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("A Record already exists ! Please add a different timeslot"),
                                  ));
                                  return;
                                }
                              } else if (date == "Select date" || interval == "Select Time") {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all the fields !")));
                                return;
                              }
                              print(startime + " " + endtime);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddBooking(date, startime, endtime, curIntervalIndex, curBookingRecord)));
                            },
                            child: const Text(
                              "Get Details",
                              style: TextStyle(fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                              primary: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
                              //EdgeInsets.only(bottom: 0.1*height),
                            ),
                          ),
                        )
                      ],
                    )))));
  }

  void setdate(bool val) async {
    setState(() {
      if (val) {
        print("setdate called");
        var newFormat = DateFormat("yyyy-MM-dd");
        if (LoginForm.u.selected != null) date = newFormat.format(LoginForm.u.selected!);
      } else {
        date = "Select Date";
      }
    });
  }

  void settime(bool val) async {
    setState(() {
      if (val) {
        print("settime called");
        startime = select_start_time.text;
        endtime = select_end_time.text;
        interval = startime + ":00 hrs to " + endtime + ":00 hrs";
      } else {
        startime = "";
        endtime = "";
        interval = "Select Time";
      }
    });
  }

  _showCalendar(BuildContext context) async {
    LoginForm.u.selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2060),
    );
    setbookings();
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
              Form(
                  key: key,
                  child: Column(children: <Widget>[
                    const ListTile(
                        title: Center(
                            child: Text(
                      "Select Time Interval",
                      style: TextStyle(color: Colors.blue, fontSize: 22, fontFamily: 'Helvetica', fontWeight: FontWeight.bold),
                    ))),
                    SizedBox(
                      height: 10,
                    ),
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
                              if (value != null || value != "") {
                                if (int.parse(value!) < 0 || int.parse(value) > 22) {
                                  return 'Please Enter Valid Start Time';
                                } else {
                                  return null;
                                }
                                //start vary from 0-22,end 0-23
                                //and start <= end
                              }
                              if (value!.isEmpty) {
                                return 'Select Start-Time';
                              }

                              return 'Enter Valid Time';
                            },
                            keyboardType: TextInputType.number,
                            controller: select_start_time,
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
                    SizedBox(height: 10),
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
                              if (value != "") {
                                if (int.parse(value!) < 0 || int.parse(value) > 23) {
                                  return 'Please Enter Valid Start Time';
                                } else {
                                  return null;
                                }
                                //start vary from 0-22,end 0-23
                                //and start <= end
                              }
                              if (value!.isEmpty) {
                                return 'Select Start-Time';
                              }

                              return 'Enter Valid Time';
                            },
                            keyboardType: TextInputType.number,
                            controller: select_end_time,
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
                    SizedBox(height: 10),
                    ListTile(
                      trailing: SimpleDialogOption(
                        onPressed: () {
                          setState(() {
                            bool f = false;
                            if (select_start_time.text == null ||
                                select_end_time.text == null ||
                                select_end_time.text == "" ||
                                select_end_time.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Please fill all fields"),
                              ));
                            } else {
                              if (int.parse(select_start_time.text) < int.parse(select_end_time.text)) {
                                f = true;
                              }

                              if (f && key.currentState!.validate()) {
                                print("Hello its me");
                                settime(true);
                                //validator
                              } else if (!f) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Please Enter Valid Time"),
                                ));
                              } else {
                                print("not valid");
                              }
                              Navigator.pop(context, Options.OK);
                            }
                          });
                          //CALL VALIDATOR HERE
                          //Navigator.pop(context, Options.OK);
                        },
                        child: const Text('OK', style: TextStyle(color: Colors.green, fontSize: 14, fontFamily: 'Helvetica')),
                        // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                      ),
                      leading: SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, Options.CANCEL);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ]))
            ],
          );
        })) {
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
    if (LoginForm.u.selected != null) dt = newFormat.format(LoginForm.u.selected!);

    // I have preset Date, there might be booking on that day or not
    // User -> BookingRecord
    // if (curBookingRecord is null) means that day has no record

    curBookingRecord = curUser.bookingRecordExists(dt);
  }
}
