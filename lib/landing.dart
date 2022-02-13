import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carpool/home.dart';
import 'package:carpool/newbooking.dart';
import 'package:carpool/LoginForm.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  Landing createState() {
    return Landing();
  }
}

class Landing extends State<TabNavigator> {
  int state = 0;

  PageController pageController = PageController(initialPage: 0);
  DateTime pre_backpress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 1);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            final snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            SystemNavigator.pop();
            return true;
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ShareCab",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  Text(
                    appcaption(),
                    style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  )
                ],
              ),
              leading: const Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  backgroundColor: Colors.black,
                ),
              ),
              backgroundColor: Colors.black,
              actions: actionwidgets(),
              shape: const Border(
                  bottom: BorderSide(
                color: Color(0xFF424242),
              )),
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(width: 0.5, color: Color(0xFF424242)),
              )),
              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    backgroundColor: Colors.black,
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    label: 'New Booking',
                    backgroundColor: Colors.black,
                  ),
                ],
                type: BottomNavigationBarType.shifting,
                currentIndex: state,
                onTap: (index) {
                  pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                },
                backgroundColor: Colors.black,
              ),
            ),
            body: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  state = index;
                });
              },
              children: [
                Home(),
                Booking(),
              ],
            ),
            backgroundColor: Colors.black));
  }

  _showCalendar(BuildContext context) async {
    final DateTime? temp;
    if (state == 0) {
      temp = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2060),
      );
      if (temp != null) {
        LoginForm.u.present = temp;
        await Home.homep.setbookings();
      }
      // homepage.createState().setbookings();

    }
  }

  String appcaption() {
    String a;
    if (state == 0) {
      a = "Your bookings";
    } else {
      a = "Add a New Booking";
    }
    return a;
  }

  List<Widget>? actionwidgets() {
    List<Widget>? temp;
    if (state == 0) {
      temp = <Widget>[
        IconButton(
          icon: const Icon(
            Icons.date_range,
            color: Colors.blue,
          ),
          onPressed: () {
            _showCalendar(context);
          },
        ),
      ];
    }
    return temp;
  }
}
