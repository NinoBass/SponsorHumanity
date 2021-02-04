//import 'package:SponsorHumanity/common_services/common_functions.dart';
import 'package:sponsorhumanity/services/auth.dart';
import 'package:sponsorhumanity/services/common_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage  extends StatelessWidget {
  HomePage({Key key, this.auth }) : super(key: key);
  final Auth auth;

  Future<User> _signOut() async {
    User _user;

    try { 
        await FirebaseAuth.instance.signOut();
    } catch ( e ) {
      tmpPrint( 'Error: ${e.toString}' );
    }
    return ( _user );
  }

  @override
  Widget build( BuildContext context ) {
   return MaterialApp (
    home: Scaffold (
      appBar: AppBar(
//        title: Text( 'Welcome!'),
          actions: <Widget> [
            TextButton(
              child: Text('Logout', 
                          style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: _signOut,
              )
          ],   
        ),
        body: ListView(
          children: [
              SizedBox(   //Use of SizedBox 
              height: 30, 
            ), 
            textWelcomeSection,
              SizedBox(   //Use of SizedBox 
              height: 30, 
            ), 
            whatDoYouWantToDoSection,
            SizedBox(   //Use of SizedBox 
              height: 30, 
            ), 
            buttonSection,
          ]
        ),
    ),
   );
  }

  final Widget textWelcomeSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'Welcome!',
    textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30 ),
    softWrap: true,
    ),
  );

  final Widget whatDoYouWantToDoSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'What do you like to do?',
    textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24 ),
    softWrap: true,
    ),
  );

   final Widget buttonSection = Container(    
    child: Center(
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                onPressed: () {},
                padding: EdgeInsets.all(25.0),
                color: Color.fromRGBO(0, 160, 0, 1),
                textColor: Colors.black,
                child: Text("    Offer Support   ",
                    style: TextStyle(fontSize: 20)),
            ),
          ),

         Container(
            margin: EdgeInsets.all(20),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(color: Color.fromRGBO(0, 0, 255, 1))),
                onPressed: () {},
                padding: EdgeInsets.all(25.0),
                color: Color.fromRGBO(0, 160, 227, 1),
                textColor: Colors.black,
                child: Text(" Request Support",
                    style: TextStyle(fontSize: 20)),
            ),
          ),
        ],   
      ),
    ),
   );

}