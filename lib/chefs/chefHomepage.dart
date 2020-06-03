import 'package:flutter/material.dart';
import 'package:maps/services/authservice.dart';
class ChefHomePage extends StatefulWidget {
  @override
  _ChefHomePageState createState() => _ChefHomePageState();
}

class _ChefHomePageState extends State<ChefHomePage> {
   final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title : Text("Chefs"),

        actions: <Widget>[
          IconButton(icon:  Icon(Icons.exit_to_app),

        onPressed: ()async { await _auth.signOut();  },)
        ],),
    );
  }
}