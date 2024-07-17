// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:smsproject/view/screen/otp.dart';
import 'package:smsproject/view/widget/button.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class NumberInput extends StatefulWidget {
  const NumberInput({super.key, required Null Function() onTap});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'IN');
  final TextEditingController _controller = TextEditingController();

  // Method to validate phone number length based on selected country
  bool _isValidPhoneNumber(String number, String isoCode) {
    switch (isoCode) {
      case 'IN':
        return number.length == 10; // India
      case 'US':
        return number.length == 10; // USA
      case 'GB':
        return number.length >= 10 && number.length <= 11; // UK
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Please enter your mobile number",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "You'll receive a 6 digit code \nto verify next.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(height: 20),
              Container(
                height: 80,
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      _phoneNumber = number;
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: _phoneNumber,
                    textFieldController: _controller,
                    inputDecoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: InputBorder.none,
                    ),
                    formatInput: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // return 'Please enter a phone number';
                      }
                      return null; // No error
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              MyButton(
                text: "CONTINUE",
                onTap: () {
                  String phoneNumber = _controller.text.trim();

                  if (_formKey.currentState?.validate() ?? false) {
                    // Validate phone number length based on selected country
                    if (_isValidPhoneNumber(phoneNumber, _phoneNumber.isoCode!)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpValidate(
                            onTap: () {}, phoneNumber: phoneNumber, verificationId: '',
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a valid phone number')),
                      );
                    }
                  } else {
                    print('Form is invalid');
                    print('Entered phone number: $phoneNumber');

                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
