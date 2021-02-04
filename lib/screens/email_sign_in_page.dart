import 'package:flutter/material.dart';
import 'package:sponsorhumanity/screens/email_sign_in_form.dart';
import 'package:sponsorhumanity/services/auth.dart';

//import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage( { @required this.auth, @required this.signInOrUp });
  final AuthBase auth;
  final int signInOrUp;

  @override
  Widget build(BuildContext context) {

    String _appBarText;

    if ( signInOrUp == 0 ) {
      _appBarText = 'Sign In';
    } else {
      _appBarText = 'Register';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text( _appBarText ),
        elevation: 2.0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInForm( auth: auth, signInOrUp: signInOrUp ),
//            child: EmailSignInFormChangeNotifier.create(context),
          ),
        ),
      backgroundColor: Colors.grey[200],
    );
  }
}
