import 'package:sponsorhumanity/services/auth.dart';
import 'package:sponsorhumanity/services/common_functions.dart';
import 'package:sponsorhumanity/screens/Home_page.dart';
import 'package:sponsorhumanity/screens/SIgnInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget{  
  const LandingPage({Key key, this.auth}) : super(key: key);
  final Auth auth;

  @override
    Widget build(BuildContext context) { 
        tmpPrint( 'LandingPage(): called');
      return StreamBuilder<User> (
        stream: auth.authStateChanges(),
        builder: (context, snapshot ) {
          if (snapshot.connectionState == ConnectionState.active ) {
            final User user = snapshot.data;
            if ( user == null ) {
            return SignInPage(
                auth: auth, key: null,
              ); 
            }
            print( 'Landing_Page.dart: calling HomePage()');
            return HomePage(
              auth: auth, 
            ); 
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator()
              ),
            );
          },
      );   
    }
}