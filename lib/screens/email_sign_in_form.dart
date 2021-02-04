
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sponsorhumanity/common_widgets/form_submit_button.dart';
import 'package:sponsorhumanity/common_widgets/validators.dart';
import 'package:sponsorhumanity/services/auth.dart';
//import 'package:provider/provider.dart';
//import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_model.dart';
//import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInForm({ @required this.auth, @required this.signInOrUp });
  final AuthBase auth;
  final int signInOrUp; /* 0 for Sign In, 1 for Sign Up */

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState( signInOrUp: signInOrUp); 

}

class _EmailSignInFormState extends State<EmailSignInForm> {
  _EmailSignInFormState( {@required this.signInOrUp} );
  final int signInOrUp;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
            

  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {

    print( "_EmailSignInFormState(): $signInOrUp");
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if ( _formType == EmailSignInFormType.signIn ) {
          await widget.auth.signInWithEmailAndPassword( _email, _password );
      } else {
          await widget.auth.createUserWithEmailAndPassword( _email, _password );
      }
      Navigator.of( context ).pop();
    } catch (e) {
        print( e.toString );
    } finally {
        setState(() {
          _isLoading = false;
    });
    }
  }

  void _emailEditingComplete() { 
    final newFocus = widget.emailValidator.isValid(_email) 
                    ? _passwordFocusNode
                    : _emailFocusNode;
    FocusScope.of(context).requestFocus( newFocus );                 
//    tmpPrint(' email editing complete');
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn ? EmailSignInFormType.register : EmailSignInFormType.signIn;
        });
    _emailController.clear();
    _passwordController.clear();
  } 

  List<Widget> _buildChildren() {

    print( "_buildChildren(): $signInOrUp");
    if ( signInOrUp == 0 ) { /* sign In */
      _formType = EmailSignInFormType.signIn;
    }
    else { /* sign Up */
      _formType = EmailSignInFormType.register;
    }       
        
    final primaryText = _formType == EmailSignInFormType.signIn ? 'Sign In' : 'Create an Account';
    final secondaryText = _formType == EmailSignInFormType.signIn ? 'Need an Account? Register' : 'Have an Account? Sign In';
    
    bool submitEnabled = widget.emailValidator.isValid(_email ) 
                        && widget.passwordValidator.isValid(_password )
                        && !_isLoading;

 
      return [
        _buildEmailTextField(),
        SizedBox( height: 8.0 ),
        _buildPasswordTextField(),
        SizedBox( height: 16.0 ),
        FormSubmitButton (
          text: primaryText,
          onPressed: submitEnabled ? _submit : null, 
        ),
        SizedBox( height: 8.0 ),
        FlatButton(
          child: Text ( secondaryText ),
          onPressed: !_isLoading ? _toggleFormType : null,
        )
      ];
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.passwordValidator.isValid( _password );
    return TextField (
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration( 
          labelText: 'Email',
          hintText: 'your_email.com',
          errorText: showErrorText ? widget.invalidEmailErrorText : null,
          enabled: _isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
      );
  }

  TextField _buildPasswordTextField() {
    bool showErrorText = _submitted && !widget.passwordValidator.isValid( _password );
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
        decoration: InputDecoration( 
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
    );
}

  // @override
  Widget build( BuildContext context ) {

    return Padding (
      padding: const EdgeInsets.all( 16.0 ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ), 
    );
  }

  void _updateState() {
//    tmpPrint( " Email: $_email, Pass: $_password");
    setState(() {});
  }
}

