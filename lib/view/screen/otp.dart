// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:smsproject/view/widget/button.dart';

class OtpValidate extends StatefulWidget {
  final String phoneNumber;
  final String verificationId; // Add this line

  const OtpValidate({super.key, required this.phoneNumber, required this.verificationId, required Null Function() onTap});

  @override
  State<OtpValidate> createState() => _OtpValidateState();
}

class _OtpValidateState extends State<OtpValidate> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        for (var controller in _controllers) {
          controller.clear();
        }
      }
    });
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).nextFocus(); // Move to the next field
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus(); // Move to the previous field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Verify Phone",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Code is sent to ${widget.phoneNumber}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: index == 0 ? _focusNode : null,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _onChanged(value, index),
                  ),
                );
              }),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't receive the code?"),
                Text(
                  " Request Again",
                  style: TextStyle(
                      color: Color.fromARGB(255, 1, 39, 96),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 25),
            MyButton(
              text: "VERIFY AND CONTINUE",
              onTap: () {
                String otp = _controllers.map((controller) => controller.text).join();
                // Add your verification logic with the OTP
                print("Entered OTP: $otp");
              },
            ),
          ],
        ),
      ),
    );
  }
}
