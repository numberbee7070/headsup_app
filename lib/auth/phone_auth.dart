import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home.dart';

class PhoneAuth extends StatefulWidget {
  static String routeName = "phone_auth";
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isCodeSent = false;
  bool _enableSubmit = false;
  String _verificationId;
  String _countryCode = CountryCode.fromCode("IN").dialCode;
  int _secondsLeft = 30;
  TextEditingController _otpController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: _isCodeSent
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _enableSubmit
                          ? "Enter OTP"
                          : "Wating for OTP 00:${_secondsLeft.toString().padLeft(2, '0')}",
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    FlatButton(
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      child: Text("Verify"),
                      onPressed: _enableSubmit ? signInWithCode : null,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Icon(Icons.arrow_drop_down),
                        CountryCodePicker(
                          onChanged: (CountryCode countryCode) =>
                              this.setState(() {
                            this._countryCode = countryCode.dialCode;
                          }),
                          padding: EdgeInsets.only(
                            left: 15.0,
                            top: 10.0,
                            bottom: 10.0,
                            right: 30.0,
                          ),
                          initialSelection: 'IN',
                          favorite: ['IN', 'US'],
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: true,
                          alignLeft: false,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _phoneController,
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter Phone number',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(this._countryCode),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    FlatButton(
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      child: Text("SEND OTP"),
                      onPressed: phoneAuth,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_secondsLeft < 1) {
            timer.cancel();
            this.setState(() {
              this._enableSubmit = true;
            });
          } else {
            this.setState(() {
              _secondsLeft -= 1;
            });
          }
        },
      ),
    );
  }

  void displaySnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  void moveToHome() {
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  Future signInWithCode() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this._verificationId,
        smsCode: this._otpController.text);
    try {
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      moveToHome();
    } on FirebaseAuthException catch (e) {
      displaySnackBar(e.message);
      print(e.message);
    }
  }

  Future<void> phoneAuth() async {
    var _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
      phoneNumber: this._countryCode + this._phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY Sign the user in with the auto-generated credential
        _otpController.text = credential.smsCode;
        await _auth.signInWithCredential(credential);
        displaySnackBar("successfully signed in");
        print("phone: ${_auth.currentUser.phoneNumber}");
        moveToHome();
      },
      verificationFailed: (FirebaseAuthException error) {
        print("error: ${error.message}");
        displaySnackBar(error.message);
      },
      codeSent: (String verificationId, int forceResendingToken) async {
        setState(() {
          this._isCodeSent = true;
          this._verificationId = verificationId;
        });
        startTimer();
        print("verification code sent");
        displaySnackBar("verification code sent");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("verification id : $verificationId");
      },
    );
  }
}
