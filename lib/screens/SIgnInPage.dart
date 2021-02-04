import 'package:sponsorhumanity/services/auth.dart';
import 'package:sponsorhumanity/services/common_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({ Key key, this.auth }) : super( key: key);
  final AuthBase auth;

  Future<User> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
      tmpPrint( '_signInAnonmously(): ' );
    } catch ( e ) {
      tmpPrint( 'Error: ${e.toString}' );
    }
  }

  Future<User> _signInWithGoogle() async {
    tmpPrint( '_signInWithGoogle(): enter' );
    try {
      await auth.signInWithGoogle();
    } catch ( e ) {
      tmpPrint( '_signInWithGoogle(): Login Aborted or Invalid Token.' );
    }
  }

  Future<User> _signInWithFacebook() async {
    try {
      tmpPrint( 'before _signInWithFacebook(): ' );
      await auth.signInWithFacebook();
      tmpPrint( 'after _signInWithFacebook(): ' );
    } catch ( e ) {
      tmpPrint( '_signInWithFacebook(): Login Aborted or Invalid Token.' );
    }
  }

  void _signInWithEmail([BuildContext context, int signInOrUp] ) {
    Navigator.of( context ).push(
      MaterialPageRoute <void> (
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(auth: auth, signInOrUp: signInOrUp ),
      )
    ); 
  }

  @override
  Widget build(BuildContext context) {
//    Color color = Theme.of(context).primaryColor;
    Widget loginAnonymouslyButton = Container(
     padding: const EdgeInsets.all(10),
      child: TextButton(
        onPressed: _signInAnonymously,
        child: Text(
          'Use App Anonymously ',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );

    Widget signUpInButtonSection = Container(
        child:  ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max, 
          children: <Widget>[
             RaisedButton(
              child:  Text('Sign in',              
                      style: TextStyle(fontSize: 20)),
              color: Colors.indigo[900],
              textColor: Colors.white,  
              onPressed: () => _signInWithEmail( context, 0 ),
            ),
            new RaisedButton(
              child:  Text('Sign up', 
                      style: TextStyle(fontSize: 20)),
              color: Colors.indigo[900],
              textColor: Colors.white,
              onPressed: () => _signInWithEmail( context, 1 ),
            ),
          ],
        ),
    );

    Widget googleFacebookButtonSection = Container(
        child:  ButtonBar(
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max, 
          children: <Widget>[
             FlatButton(
              child: Image.asset('images/google-logo.png'),
              color: Colors.indigo[100],
              textColor: Colors.white,  
              onPressed: _signInWithGoogle,
//                onPressed: null,
            ),
            new RaisedButton(
              child: Image.asset('images/facebook-logo.png'), 
              color: Colors.indigo[900],
              textColor: Colors.white,
              onPressed: _signInWithFacebook,
//              onPressed: null,
            ),
          ],
        ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        '------- Or sign in with ------- ',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),
      softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Sponsor Humanity',
      home: Scaffold(
        /*
        appBar: AppBar(
          title: Text('Not used...'),
        ),
        */
        body: ListView(
          children: [
              SizedBox(   //Use of SizedBox 
              height: 10, 
            ), 
            Image.asset(
              'images/SponsorHumanityLogo.jpg',
              width: 100,
              height: 300,
              fit: BoxFit.fill,
            ),
            SizedBox(   //Use of SizedBox 
              height: 30, 
            ), 
            signUpInButtonSection,
            textSection,
            googleFacebookButtonSection,
            loginAnonymouslyButton,
          ],
        ),
      ),
    );
  }
}