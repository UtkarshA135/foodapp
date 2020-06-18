import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartCard extends  StatelessWidget{
  DocumentSnapshot cartDetails;

  CartCard({this.cartDetails});

  @override
  Widget build(BuildContext context) {
    List<Widget > items = new List();

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(this.cartDetails['storeName']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.cartDetails['items'].map<Widget>((item){
                return Text(item['itemName']+" - ₹"+ item["itemPrice"].toString()+' x'+item['quantity'].toString());
            }).toList() ),
        ),
      ),
    );
  }
}
