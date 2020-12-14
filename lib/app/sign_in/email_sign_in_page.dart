import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 4.0,
      ),
      body: Padding(
        padding: EdgeInsets.all( 16.0 ),  
        child: Card(
          child: EmailSignInForm(),
        ),
      ),
      backgroundColor: Colors.grey[400],
    );
  }     
}