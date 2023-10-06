import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class PhoneAuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController boxCountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isCodeSent = false;
  int numberOfFields = 6;

  late TwilioFlutter twilioFlutter;

  var sentOTP;

  showInvisibleWidgets() {
    isCodeSent = true;
    update();
  }

  sendSMS() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'ACf254bb5a91e22e10b2ba7b1e4b60694f', // replace it with your account SID
        authToken: '0f9a10f93922c389549f22850293e8e9', // replace it with your auth token
        twilioNumber: '+15172836551' // replace it with your purchased twilioNumber

        );

    var rnd = new Random();

    var digits = rnd.nextInt(900000) + 100000;

    sentOTP = digits;

    // lets print otp as well

    print(sentOTP);

    twilioFlutter.sendSMS(
        toNumber: phoneController.text,
        messageBody: 'Hello This is 6 digit otp code to verify phone $digits');
  }

  verifyOTP() {
    if (sentOTP.toString() == codeController.text) {
      Fluttertoast.showToast(
          msg: "OTP Verified SuccessFully!", backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(
          msg: "OTP didn't match!", backgroundColor: Colors.red);
    }
  }
}
