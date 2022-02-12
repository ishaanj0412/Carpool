import 'package:flutter/material.dart';
import 'package:carpool/user.dart';
import 'package:carpool/LoginForm.dart';
import 'package:interval_tree/interval_tree.dart' as a;
import 'package:intl/intl.dart';
import 'package:carpool/bookingdetails.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  static Homepage homep = Homepage();
  @override
  Homepage createState() {
    print("Createstate called");
    homep = new Homepage();
    return homep;
  }
}

enum Options { Remove, ShowDetails }

class Homepage extends State<Home> {
  Widget presentwidget = Container(
      child: const Center(
    child: Text(
      "You have no bookings available for the selected date.",
      style: TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
    ),
  ));

  // List<a.Interval> userintervals = [];

  User curUser = LoginForm.u;
  late BookingRecord? curBookingRecord;
  late int curIntervalIndex;

  List<Widget> widgetlist = [];

  bool didOpenDialog = false;

  Future<void> OpenDialog() async {
    didOpenDialog = true;
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Color(0xFF212121),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            title: const Center(
              child: Text(
                "Booking Options",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Options.ShowDetails);
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.list,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "Show Details",
                    style: TextStyle(color: Colors.white),
                  ),
                  tileColor: Color(0xFF303030),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Options.Remove);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Cancel Booking",
                    style: TextStyle(color: Colors.white),
                  ),
                  tileColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ],
          );
        })) {
      case Options.ShowDetails:
        // Let's go.
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetails("11-02-2022", "2:00", "3:00", br: curBookingRecord)));
        // TODO: connect with backend
        print("show details clicked");
        break;
      case Options.Remove:
        //remove stuff from databse
        //call build ui
        if (curIntervalIndex != -1) {
          LoginForm.u.deleteBooking(curBookingRecord!, curBookingRecord!.intervals[curIntervalIndex]);
        }

        print("remove clicked");
        break;
    }
    curIntervalIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    setbookings();
    return Scaffold(backgroundColor: Colors.black, body: presentwidget);
  }

  void bookings() {
    String dt;
    var newFormat = DateFormat("yyyy-MM-dd");
    dt = newFormat.format(LoginForm.u.present!);
    setState(() {
      if (curBookingRecord != null) {
        if (curBookingRecord!.intervals.isNotEmpty) {
          print(0);
          widgetlist = [
            const SizedBox(
              height: 10,
            ),
            Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.lock_clock, size: 22, color: Colors.blue),
                      ),
                      TextSpan(
                        text: " $dt",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                )
            ),
            const SizedBox(
              height: 15,
            ),
          ];

          for(int i=0; i<curBookingRecord!.intervals.length ; i++){
            String starttime = curBookingRecord!.intervals[i].start.toString() + ":00";
            String endtime = curBookingRecord!.intervals[i].end.toString() + ":00";
            widgetlist.add(
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                        leading: const Icon(
                          Icons.car_rental,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Booking Time: $starttime to $endtime",
                          style: const TextStyle(color: Colors.white),
                        ),
                        tileColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              curIntervalIndex = i;
                              OpenDialog().then((value) => bookings());
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ))),
                  ),
                )
            );
          }
          presentwidget = Scrollbar(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: widgetlist,
              ));
        }
      } else {
          print(1);
          widgetlist = [
            const SizedBox(
              height: 10,
            ),
            Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.lock_clock, size: 22, color: Colors.blue),
                      ),
                      TextSpan(
                        text: " $dt",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                )
            ),
            const SizedBox(
              height: 220,
            ),
            const Center(
              child: Text(
                "You have no bookings available for the selected date.",
                style: TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
              ),
            ),
          ];

          presentwidget = Scrollbar(
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: widgetlist,
          ));
        }
      });
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
    bookings();
  }
}
