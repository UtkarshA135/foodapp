import 'package:maps/diners/dinerHomepage.dart';
import 'package:maps/diners/dinerinfo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BuyerRegisterPage extends StatefulWidget {
  BuyerRegisterPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _BuyerRegisterPageState createState() => _BuyerRegisterPageState();
}

class _BuyerRegisterPageState extends State<BuyerRegisterPage> {
  bool isLoading = false;
  bool showLoading = true;
  TextEditingController _namecontroller;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkuserExists();
    this._namecontroller = new TextEditingController();
  }

  checkuserExists() async {
    isUserExist().then((userExists) {
      if (userExists) {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => 
             DinerHomePage()));
      } else {
        print("first time login");
        setState(() {
          showLoading = false;
        });
      }
    });
  }

  onPressRegister() {
    if (!_formKey.currentState.validate()) {
    } else {
      setState(() {
        this.isLoading = true;
      });
      registerBuyer(
              _namecontroller?.text ?? "1",
              )
          .then((statusCode) {
        setState(() {
          this.isLoading = false;
        });
        switch (statusCode) {
          case 1:
            print('registered');
            Fluttertoast.showToast(
                msg: "Registered",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                fontSize: 16.0); 
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => DinerHomePage()));
            break;
          case 2:
            print('check your internet connection');
            Fluttertoast.showToast(
                msg: "Check your Internet Connection",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                fontSize: 16.0);
            break;
          case 3:
            print('please try again later');
            Fluttertoast.showToast(
                msg: "Please try again later",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                fontSize: 16.0);
            break;
        }
      });
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {TextEditingController controllervar}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please fill in this field';
                }
                return null;
              },
              // obscureText: isPassword,
              controller: controllervar,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  //fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return FlatButton(
      onPressed: onPressRegister,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
             
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                'Register Now',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }


  Widget _formfieldswidgets() {
    return Column(
      children: <Widget>[
        _entryField("Name", controllervar: _namecontroller),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color dynamiciconcolor = (!isDarkMode) ? Colors.black : Colors.white;
    Color dynamicuicolor =
        (!isDarkMode) ? new Color(0xfff8faf8) : Color.fromRGBO(25, 25, 25, 1.0);
    if (showLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else
      return Scaffold(
          key: _scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Form(
              key: _formKey,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                    SizedBox(
                    height: 50,
                  ),
                   RichText(
      textAlign: TextAlign.center,
      text: 
        TextSpan(
          text: 'Register',
          style: TextStyle(color:dynamiciconcolor,fontSize: 25),
        ),
      
                   ),
                  SizedBox(
                    height: 50,
                  ),
                  _formfieldswidgets(),
                  SizedBox(
                    height: 20,
                  ),
                  _submitButton(),
                  // Expanded(
                  //   flex: 2,
                  //   child: SizedBox(),
                  // ),
                  /*Align(
                    alignment: Alignment.bottomCenter,
                    child: _loginAccountLabel(),
                  ),*/
                ],
              ),
            ),
          ));
  }
}
