import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_auth_twilio/screen/phone_auth_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Phone Auth Tutorial',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PhoneAuthScreen());
  }
}

//for output
// enter phone no as  +917733872456 (only verified no. with twilio trial account for next 30 days)
