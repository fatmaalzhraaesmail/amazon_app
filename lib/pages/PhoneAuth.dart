import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:amazon_app/services/Auth_Services.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  int start = 30;
  bool wait = false;
  String buttonName = "send";
  String verificationidFinal = "";
  String smsCode = "";
  TextEditingController phoneController = TextEditingController();
  AuthClass authclass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text(
          "SignUp",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
             textField(),
              SizedBox(
                height: 30,
              ),
               Container(
              width: MediaQuery.of(context).size.width - 30,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                  ),
                  Text(
                    "Enter 6 Digit OTP",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  Expanded(
                      child: Container(
                    height: 1,
                    color: Colors.grey,
                     margin: EdgeInsets.symmetric(horizontal: 12),
                  ))
                ],
              ),
            ),
             SizedBox(
                height: 30,
              ),
               otpField(),
                SizedBox(
                height: 40,
              ),
               RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: "Send OTP again in ",
                    style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                  ),
                  TextSpan(
                    text: "00:$start",
                    style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                  ),
                  TextSpan(
                    text: " sec ",
                    style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                  ),
                ],
              )),
              SizedBox(
                height: 150,
              ),


            InkWell(
              onTap: () {
                authclass.signInwithPhoneNumber(
                    verificationidFinal, smsCode, context);
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color: Color(0xffff9601),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Lets Go",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xfffbe2ae),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
           
           
          ],
        )),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      //  onChanged: ,
      onCompleted: (var pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
          FocusScope.of(
                            context).unfocus(
                        );
        });
        
        
      },
      onChanged: (text){
        smsCode = text;

      },
     
      
    );
    
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone Number",
          hintStyle: TextStyle(
            color: Colors.white54,
            fontSize: 17,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Text(
              "(+20)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                    setState(() {
                      start = 30;
                      wait = true;
                      buttonName = "Resend";
                    });
                    await authclass.verifyPhoneNumber(
                        "+20 ${phoneController.text}", context, setData);
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                "send",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(verificationid) {
    setState(() {
      verificationidFinal = verificationid;
    });
    startTimer();
  }
}