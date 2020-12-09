import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';
//import 'package:time_tracker/common_widgets/custom_raised_button.dart';

class SignInPage extends StatelessWidget {  

  const SignInPage({Key key, @required this.auth }) : super(key: key);
  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print( e.toString() );
    }
  }

Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print( e.toString() );
    }
  }
  
Future<void> _signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print( e.toString() );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sponsor Humanity'),
        elevation: 4.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[400],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 48.0),
            SigInButton(
              text: 'Sign in with Google',
              color: Colors.white,
              textColor: Colors.black87,
              onPressed: _signInWithGoogle,
            ),
            SizedBox(height: 8.0),
            SigInButton(
              text: 'Sign in with Facebook',
              color: Color(0xFF334D92),
              textColor: Colors.white,
              onPressed: _signInWithFacebook,
            ),
            SizedBox(height: 8.0),
            SigInButton(
              text: 'Sign in with E-mail',
              color: Colors.teal[700],
              textColor: Colors.white,
              onPressed: () {},
            ),
            SizedBox(height: 8.0),
            Text(
              'or',
              style: (TextStyle(fontSize: 20.0, color: Colors.black87)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            SigInButton(
              text: 'Sign in Anon',
              color: Colors.lime[300],
              textColor: Colors.black,
              onPressed: _signInAnonymously,
                          ),
                        ]));
   }            
}




