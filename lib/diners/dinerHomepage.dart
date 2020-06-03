import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maps/services/authservice.dart';
class DinerHomePage extends StatefulWidget {
  @override
  _DinerHomePageState createState() => _DinerHomePageState();
}

class _DinerHomePageState extends State<DinerHomePage> {
   final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text("Diners"),

        actions: <Widget>[
          IconButton(icon:  Icon(Icons.exit_to_app),

        onPressed: ()async { await _auth.signOut();  },)
        ],),
    );
  }
}