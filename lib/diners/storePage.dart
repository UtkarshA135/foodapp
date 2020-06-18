import 'package:maps/diners/dinerinfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';
import 'package:maps/services/authservice.dart';
import 'package:maps/diners/storeComponents/store.dart';
import 'package:maps/diners/shopCard.dart';
class StoresPage extends StatefulWidget {
 final String phNo;
  StoresPage({Key key,this.phNo}) : super(key: key);
  @override
  _StoresPageState createState() => _StoresPageState(phNo:phNo);
}

class _StoresPageState extends State<StoresPage> {
  final CollectionReference storesRef  = Firestore.instance.collection("stores");
  String phNo;
  _StoresPageState({this.phNo});
  List<double> myLocation=[0.0,0.0];

  @override
  void initState() {
    // TODO: implement initState
    _getMyLocation();
    super.initState();
  }

  _getMyLocation()async {

    var mylocation = await getLocation();
    setState(() {
      myLocation = mylocation;
    });
  }
   double _calcDistance(List<dynamic> storeLoc){
      if(this.myLocation[0] == 0.0 && this.myLocation[1]==0.0){
        return 0.0;
      }
      else{
          final Distance distance = new Distance();
              
          // km = 423
          final double km = distance.as(LengthUnit.Kilometer,
          new LatLng(storeLoc[0],storeLoc[1]),new LatLng(this.myLocation[0],this.myLocation[1]));
          
          // // meter = 422591.551
          final double meter = distance(
              new LatLng(storeLoc[0],storeLoc[1]),new LatLng(this.myLocation[0],this.myLocation[1])
              );
          // if(meter>1000){
          //   return '$km Km';
          // }
          // else{
            return meter;

          // }

      }
    }

  @override
  Widget build(BuildContext context) {
      bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color dynamiciconcolor = (!isDarkMode) ? Colors.black : Colors.white;
    Color dynamicuicolor =
        (!isDarkMode) ? new Color(0xfff8faf8) : Color.fromRGBO(25, 25, 25, 1.0);
        Color dynamicbgcolor =
        (!isDarkMode) ? Colors.grey[200] : Colors.black;
    return Container(
    //  backgroundColor: Colors.redAccent[900],
      /* appBar: AppBar(title:Text("Stores Near Me",
       
       ),
       centerTitle: true,
       backgroundColor: Colors.redAccent[900],
       actions: <Widget>[
         RaisedButton(
           child: Text('Sign Out'),
           onPressed: ()async{
                          AuthService().signOut();
                          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> AuthService().handleAuth()));


         })
       ],
       
       ),
       
       
       */
       
      child: StreamBuilder<QuerySnapshot>(
        stream: storesRef.snapshots(),
        builder: (context,snapshot){
            if(snapshot.hasData)
              {
              final List<StoreCard> docs = snapshot.data.documents.map(
                (doc)=>
                StoreCard(
                  store:Store(
                      name: doc['name'],
                      distance:  _calcDistance(doc['location']),
                      description: doc['description']??"" ,
                      contact: doc['phno'],
                      id:doc['id'],
                      sellerId: doc['sellerId'],
                      location: doc['location']
                  )  
                )
              ).toList();
             // docs.removeWhere((doc)=>doc.store.distance>2099.0);
              docs.sort((a,b)=>a.store.distance.compareTo(b.store.distance));
              
              return ListView(children: docs,physics: BouncingScrollPhysics(),);
            }
            else return Center(child: CupertinoActivityIndicator());
            

        },),

    );
  }
}
