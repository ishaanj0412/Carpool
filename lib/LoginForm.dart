import 'package:carpool/auth.dart';
import 'package:carpool/user.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:string_validator/string_validator.dart';

import 'OTP.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.form_key,
    required this.orgid,
    required this.email_id_controller,
    required this.roll_num_controller,
  }) : super(key: key);

  final GlobalKey<FormState> form_key;
  final String orgid;
  final TextEditingController email_id_controller;
  final TextEditingController roll_num_controller;
  static late User u;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form_key,
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Card(
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo.png',
                      width: 200,
                      height: 90,
                    ),
                    const Text(
                      "ShareCab\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white, fontFamily: 'Helvetica'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value != null) {
                          if (value.contains(orgid) && value.contains("@")) {
                            return null;
                          }
                        }
                        if (value!.isEmpty) {
                          return 'Enter Email Please';
                        }

                        return 'Enter Valid Organisation Email ID';
                      },
                      controller: email_id_controller,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Helvetica'),
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Helvetica'),
                        hintText: "Enter Your Email",
                        labelText: "Email ID",
                        filled: true,
                        fillColor: const Color(0xFF424242),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value != null) {
                          if (isAlphanumeric(value)) {
                            return null;
                          }
                        }
                        return 'Enter Valid Roll Number';
                      },
                      controller: roll_num_controller,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Helvetica'),
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Helvetica'),
                        hintText: "Enter Your Roll Number",
                        labelText: "Roll Number",
                        filled: true,
                        fillColor: const Color(0xFF424242),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (form_key.currentState!.validate()) {
                          //add backend

                          print("Validated");
                          sendOTP(email_id_controller);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTP(
                                        emailidcontroller: email_id_controller,
                                        rollnumbercontroller: roll_num_controller,
                                      )));
                        } else {
                          print("not valid");
                        }
                      },
                      child: const Text(
                        "Get OTP",
                        style: TextStyle(fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        primary: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
