import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.auth }) : super(key: key);
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print( e.toString() );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sponsor Humanity Home'),
          actions: <Widget> [
            FlatButton( child: Text(
              'Logout', 
              style: TextStyle( 
                fontSize: 18.0, color: Colors.white 
                ),
              ), 
              onPressed: _signOut,
            ),
          ], 
        )
    );
  } // Widget
} // StatelessWidget