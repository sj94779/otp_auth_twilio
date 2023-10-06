import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:otp_auth_twilio/controller/phone_auth_controller.dart';

class PhoneAuthScreen extends StatelessWidget {
  PhoneAuthController controller = Get.put(PhoneAuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Phone Auth"),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<PhoneAuthController>(
          builder: (_) => Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "03472222", labelText: "Phone Number"),

                    // lets add validation
                    validator: (String? number) {
                      if (number!.isEmpty) {
                        return "Enter Phone Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.boxCountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "6", labelText: "Box Count"),

                    // lets add validation
                    validator: (String? number) {
                      if (number!.isEmpty) {
                        return "Enter Box Count";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: controller.isCodeSent,
                    child:
                    OtpTextField(
                      numberOfFields: controller.boxCountController.text.isEmpty ? controller.numberOfFields : int.parse(controller.boxCountController.text),
                      borderColor: Color(0xFF512DA8),
                      focusedBorderColor: Color(0xFF512DA8),
                    //  clearText: clearText,
                      showFieldAsBox: true,
                     // textStyle: theme.textTheme.subtitle1,
                      onCodeChanged: (String value) {
                       // controller.codeController.text = value;
                        //Handle each value
                      },
                      handleControllers: (controllers) {
                        //get all textFields controller, if needed
                      //  controller.codeController = controllers;
                      },
                      onSubmit: (String verificationCode) {
                        controller.codeController.text = verificationCode;


                      }, // end onSubmit
                    ),

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: !controller.isCodeSent,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {

                                controller.sendSMS();
                                controller.showInvisibleWidgets();
                              }
                            },
                            child: const Text('Submit'))),
                  ),
                  Visibility(
                    visible: controller.isCodeSent,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!
                                  .validate()) {

                                controller.verifyOTP();
                              }
                            },
                            child: const Text('Verify'))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
