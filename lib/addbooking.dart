import 'package:carpool/user.dart';
import 'package:flutter/material.dart';

import 'LoginForm.dart';

class AddBooking extends StatefulWidget {
  late List<Widget> widgetlist;

  AddBooking(this.date, this.starttime, this.endtime,
      {Key? key, BookingRecord? br})
      : super(key: key) {
    brs = LoginForm.u.getBookingMatching(br!);
    widgetlist = [
      const ListTile(
        title: Center(
          child: Text(
            "Details",
            style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Helvetica',
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
        tileColor: Colors.black,
      ),
      ListTile(
        leading: const Icon(
          Icons.calendar_today_sharp,
          color: Colors.blue,
          size: 22,
        ),
        title: Text(
          "Date: $date",
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Helvetica', fontSize: 15),
        ),
        tileColor: Colors.black,
      ),
      ListTile(
        leading: const Icon(
          Icons.lock_clock,
          color: Colors.blue,
          size: 22,
        ),
        title: Text(
          "Time Slot: $starttime Hours to $endtime Hours",
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Helvetica', fontSize: 15),
        ),
        tileColor: Colors.black,
      ),
      const ListTile(
        title: Center(
          child: Text(
            "Available Carpools",
            style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Helvetica',
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
        tileColor: Colors.black,
      ),
    ];
  }

  final String date;
  final String starttime;
  final String endtime;
  late Future<List<BookingRecord>> brs;

  @override
  State<AddBooking> createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  // late List<BookingRecord> brs;
  List<String> carpools = [
    "Ishaan Jalan",
    "Rudransh Dixit",
    "hewwo",
    "manda",
    "ramesh",
    "mukesh",
    "sukesh",
    "nilesh"
  ];

  // TODO: add getBookingData..
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "ShareCab",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            Text(
              "Booking Details",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            )
          ],
        ),
        leadingWidth: 70,
        leading: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            heroTag: "button1",
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Colors.black,
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_back, color: Colors.white),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  backgroundColor: Colors.black,
                ),
              ],
            )),
        backgroundColor: Colors.black,
        shape: const Border(
            bottom: BorderSide(
              color: Color(0xFF424242),
            )),
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          heroTag: "button2",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlertDialog(
                  backgroundColor: Color(0xFF212121),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  title: const Center(
                    child: Text(
                      'Cancel Booking',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ), // To display the title it is optional
                  content: const Text(
                    'Are you sure you want to cancel the booking?',
                    style: TextStyle(color: Colors.white),
                  ), // Message which will be pop up on the screen
                  // Action widget which will provide the user to acknowledge the choice
                  actions: [
                    TextButton(
                      // FlatButton widget is used to make a text to work like a button
                      onPressed: () {
                        //DB deletion strategy same as home.dart
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // TODO: add delete
                      }, // function used to perform after pressing the button
                      child: const Text(
                        'YES',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'NO',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          backgroundColor: Colors.red,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          )),
      body: FutureBuilder<bool>(
          future: avlblcarpools(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              List<Widget> children = widget.widgetlist;
              return Scrollbar(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  children: widget.widgetlist,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      // body: Scrollbar(
      //   child: ListView(
      //     scrollDirection: Axis.vertical,
      //     shrinkWrap: true,
      //     padding: EdgeInsets.all(5),
      //     children: widget.widgetlist,
      //   ),
      // ),
    );
  }

  Future<bool> avlblcarpools() async {
    bool temp = false;
    List<BookingRecord> value = await widget.brs;
    for (int i = 0; i < value.length; i++) {
      temp = true;
      String name = value[i].uid;
      widget.widgetlist.add(
        ListTile(
          leading: const Icon(
            Icons.person,
            color: Colors.blue,
            size: 22,
          ),
          title: Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'Helvetica', fontSize: 15),
          ),
          tileColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
    if (value.isEmpty) {
      temp = false;
      widget.widgetlist.add(
        const ListTile(
          title: Center(
            child: Text(
              "Sorry, there are no carpools available in your time slot",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Helvetica', fontSize: 15),
            ),
          ),
          tileColor: Colors.black,
        ),
      );
    }
    return temp;
  }
}
