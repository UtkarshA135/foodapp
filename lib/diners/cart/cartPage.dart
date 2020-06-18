import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps/diners/cart/orderPlaced.dart';
import 'package:maps/services/authservice.dart';
import 'package:maps/services/firebaseUserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartcard.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
   final AuthService _auth = AuthService();
  List<dynamic> cartItems = new List();
  FirebaseUser user;
  CollectionReference cartRef;
  @override
  void initState() {
    
    setState(() {
      this.user =
          Provider.of<FirebaseUserProvider>(context, listen: false).user;
    });

    super.initState();
    
  }

  CollectionReference getCartStream() {
  //  this.user = Provider.of<FirebaseUserProvider>(context, listen: false).user;
    return Firestore.instance
        .collection('diners')
        .document('${this.user.uid}')
        .collection('cart');
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'cartpage',
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Your Cart',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Place Order',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => OrderPlacedPage()));

                },
              ),
            ],
            backgroundColor: Colors.grey[200],
            elevation: 1.0,
          ),
          body: Builder(
            builder: (context) {
              CollectionReference ref = getCartStream();

              return StreamBuilder<QuerySnapshot>(
                  stream: ref.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.documents.length == 0) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 70,
                                    color: Colors.grey,
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 10),
                                child: Text(
                                  'You have not added any items to cart',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 25),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]);
                      } else {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index > snapshot.data.documents.length)
                              return null;

                            return CartCard(
                              cartDetails: snapshot.data.documents[index],
                            );
                          },
                          itemCount: snapshot.data.documents.length,
                        );
                      }
                    } else
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 25),
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 70,
                                  color: Colors.grey,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 10),
                              child: Text(
                                'Fetching the items in your cart',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]);
                  });
            },
          ),
        ));
  }
}
