import 'package:firebase_auth/firebase_auth.dart';
import 'package:maps/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:maps/services/authservice.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;
Widget getImageAsset(){
  AssetImage assetImage = AssetImage("assets/welcome.jpg");
  Image image = Image(image: assetImage,width:1000.0,height:600.0,fit: BoxFit.cover,);
  return Container(child: image,);
}
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Form(
          key: formKey,
          child:Center(
        child: ListView(
          children: <Widget>[
             getImageAsset(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    
                    decoration: InputDecoration(hintText: ' Enter your phone number',prefixText: '+91',prefixIcon: Icon(Icons.phone),enabledBorder: OutlineInputBorder(
          borderSide:BorderSide(color: Colors.grey)),
                border: OutlineInputBorder(),
          ),
                    onChanged: (val) {
                      setState(() {
                        this.phoneNo = '+91'+val;
                      });
                    },
                  )),
                  codeSent ? Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP',prefixIcon: Icon(Icons.vpn_key),enabledBorder: OutlineInputBorder(
          borderSide:BorderSide(color: Colors.grey)),
          border: OutlineInputBorder(),),
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                  )) : Container(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0,top: 10),
                  child: RaisedButton(
                      child: Center(child: codeSent ? Text('Continue',style: TextStyle(fontSize: 20),):Text('Verify',style: TextStyle(fontSize: 20),)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),),
                      
                      onPressed: () {
                        AuthService().savePhoneNumber(this.phoneNo);
                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                      }))
            ],
          )),
     ) );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

}