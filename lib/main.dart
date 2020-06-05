import 'package:maps/diners/dinerHomepage.dart';
import 'package:maps/services/firebaseUserProvider.dart';
import 'package:flutter/material.dart';
import 'package:maps/services/authservice.dart';
import 'package:provider/provider.dart';
import 'services/chefsDetailProvider.dart';
void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider<FirebaseUserProvider>(
          create: (context) => FirebaseUserProvider()),
            ChangeNotifierProvider<SellerDetailsProvider>(
          create: (context) => SellerDetailsProvider()),

    
    ], child: MyApp()));

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isBuyer = true;
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<FirebaseUserProvider>(context, listen: false)
        .user; //initialising firebaseuserprovider
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      debugShowCheckedModeBanner: false,
     /* darkTheme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.deepOrange),*/
      theme: ThemeData(
        primarySwatch: Colors.blue,
       
      ),
      home: DinerHomePage(),
      // home: AuthService().handleAuth(),
    );
  }
}
