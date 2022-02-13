import 'package:carpool/auth.dart';
import 'package:carpool/database.dart';
import 'package:carpool/user.dart';
import 'package:flutter/material.dart';
import 'package:carpool/LoginForm.dart';
import 'landing.dart';

// ignore: non_constant_identifier_names
class OTP extends StatelessWidget {
  OTP({Key? key, @required this.emailidcontroller, @required this.rollnumbercontroller}) : super(key: key);
  final _otpcontroller = TextEditingController();
  final emailidcontroller;
  final rollnumbercontroller;
  // final database = DataBaseService();
  //final CollectionReference userCollection=FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.black,
            //   title: const Text("Verify OTP"),
            // ),
            backgroundColor: Colors.black,
            body: Padding(
                padding: const EdgeInsets.all(21),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Enter OTP",
                      style: TextStyle(fontSize: 18, color: Colors.grey, fontFamily: 'Helvetica'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: TextFormField(
                      validator: (value) {
                        if (value != null) {
                          return null;
                        }
                        return "Please Enter OTP";
                      },
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      controller: _otpcontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF424242),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0)),
                      ),
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          //removed otp for easy debug
                          bool flag = await verifyOTP(
                          emailidcontroller, _otpcontroller, context);
                          // bool flag = true;
                          if (flag) {
                            Future<bool> flag1 = DataBaseService.exists(emailidcontroller.text);
                            if (await flag1) {
                              //get existing user
                              LoginForm.u = await DataBaseService.getData(emailidcontroller.text);
                              await LoginForm.u!.fetchBookingRecord();
                            } else {
                              LoginForm.u = await User(emailId: emailidcontroller.text, rollNumber: rollnumbercontroller.text, dateRecords: []);
                              await LoginForm.u!.update();
                            }

                            // storing in local storage
                            User.storeUser(emailidcontroller.text);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const TabNavigator()));
                          }
                        },
                        child: const Text(
                          "Verify OTP",
                          style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Helvetica'),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          //add backend
                          sendOTP(emailidcontroller);
                        },
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Helvetica'),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
