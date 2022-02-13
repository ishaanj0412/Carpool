import 'dart:async';

import 'package:carpool/landing.dart';
import 'package:carpool/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginForm.dart';
import 'database.dart';
import 'landing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyCfwoPfMpHN4Z1a8cyKwU0PcvgQmeAb1WE',
        appId: "1:1007164354983:android:7fbeddace7d008117b4682",
        databaseURL: "https://sharecab-4e0f6-default-rtdb.firebaseio.com/",
        messagingSenderId: "1007164354983",
        projectId: "sharecab-4e0f6"),
  );
  runApp(const MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
  // runApp(const MaterialApp(
  //   home: Landing(),
  //   debugShowCheckedModeBanner: false,
  // ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: non_constant_identifier_names
  final form_key = GlobalKey<FormState>();
  final email_id_controller = TextEditingController();
  final roll_num_controller = TextEditingController();
  static const String orgid = "iiitb.ac.in";

  Widget _body = CircularProgressIndicator();

  bool isLoggedIn = false;
  String name = "";

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    SharedPreferences.getInstance().then((value) {
      final String? emailID = value.getString("emailID");
      LoginForm.email = emailID;
      if (emailID != null || emailID != "") {
        setState(() => _body = Stack(children: const <Widget>[
              TabNavigator(),
            ]));
        
        LoginForm.u = null;
      } else {
        setState(() => _body = Stack(
              children: <Widget>[
                //TabNavigator(),
                LoginForm(form_key: form_key, orgid: orgid, email_id_controller: email_id_controller, roll_num_controller: roll_num_controller),
              ],
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Scaffold? scaffold = null;

    // if (check) {
    //   return Scaffold(
    //     backgroundColor: Colors.black,
    //     body: Stack(
    //       children: const <Widget>[
    //         TabNavigator(),
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      backgroundColor: Colors.black,
      body: _body,
    );
  }
}
