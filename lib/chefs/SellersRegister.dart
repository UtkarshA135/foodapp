import 'package:maps/chefs/chefinfo.dart';
import 'package:maps/chefs/chefHomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerRegisterPage extends StatefulWidget {
  SellerRegisterPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SellerRegisterPageState createState() => _SellerRegisterPageState();
}

class _SellerRegisterPageState extends State<SellerRegisterPage> {
  bool isLoading = false;
  bool showLoading = true;
  TextEditingController _shopnamecontroller,
      _phonenumber1controller,
      _shopkeepernamecontroller,
      _phonenumber2controller,
      _shopDescriptionController = new TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkuserExists();
    this._shopkeepernamecontroller = new TextEditingController();
    this._phonenumber1controller = new TextEditingController();
    this._phonenumber2controller = new TextEditingController();
    this._shopnamecontroller = new TextEditingController();
    this._shopDescriptionController = new TextEditingController();
  }

  checkuserExists() async {
    isUserExist().then((userExists) {
      if (userExists) {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => ChefHomePage()));
      } else {
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
      registerSeller(
              _shopnamecontroller?.text ?? "1",
              _phonenumber1controller?.text ?? "2",
              _shopkeepernamecontroller?.text ?? "3",
              _phonenumber2controller?.text ?? "4",
              _shopDescriptionController?.text ?? "6")
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
                new MaterialPageRoute(builder: (context) => ChefHomePage()));
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
                  // fillColor: Color(0xfff3f3f4),
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
            boxShadow: <BoxShadow>[],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: isLoading
            ? CupertinoActivityIndicator()
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
        _entryField("Shop name", controllervar: _shopnamecontroller),
        _entryField("Shop Description",
            controllervar: _shopDescriptionController),
        _entryField("Shopkeeper/Manager name",
            controllervar: _shopkeepernamecontroller),
        _entryField("Phone Number 1", controllervar: _phonenumber1controller),
        _entryField("Phone Number 2", controllervar: _phonenumber2controller),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color dynamiciconcolor = (!isDarkMode) ? Colors.black : Colors.white;
    Color dynamicuicolor =
        (!isDarkMode) ? new Color(0xfff8faf8) : Color.fromRGBO(25, 25, 25, 1.0);
    Color dynamicbgcolor = (!isDarkMode) ? Colors.grey[200] : Colors.black;
    if (showLoading) {
      return Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Hero(
                  tag: 'loading',
                  child: Container(
                    height: 200,
                    child: Image.asset('assets/chefs.jpg'),
                  )),
              SizedBox(
                height: 50,
              ),
              CupertinoActivityIndicator(
                radius: 25,
              ),
            ])),
      );
    } else
      return Scaffold(
          backgroundColor: dynamicbgcolor,
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
                    text: TextSpan(
                      text: 'Register your store with us',
                      style: TextStyle(color: dynamiciconcolor, fontSize: 25),
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
                ],
              ),
            ),
          ));
  }
}
