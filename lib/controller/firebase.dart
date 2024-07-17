import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smsproject/view/screen/otp.dart';

class Firebase extends StatefulWidget {
  @override
  _FirebaseState createState() => _FirebaseState();
}

class _FirebaseState extends State<Firebase> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _phoneNumber = ''; // Ensure you initialize this with the actual phone number

  void _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumber, // Ensure phone number is formatted correctly
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve the code and sign in
        await _auth.signInWithCredential(credential);
        // Navigate to the next screen if needed
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle failure
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Code has been sent; navigate to OTP screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpValidate(
              phoneNumber: _phoneNumber,
              verificationId: verificationId, onTap: () {  },
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
        print('Verification timeout');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Verification')),
      body: Center(
        child: ElevatedButton(
          onPressed: _verifyPhoneNumber,
          child: Text('Verify Phone Number'),
        ),
      ),
    );
  }
}
