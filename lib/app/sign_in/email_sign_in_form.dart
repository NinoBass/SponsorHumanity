import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/validators.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';
import 'package:time_tracker/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInForm( {@required this.auth });
  final AuthBase auth;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {

  final TextEditingController _emailController = TextEditingController(); 
  final TextEditingController _passwordController = TextEditingController(); 
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode= FocusNode();

  String get _email => _emailController.text; 
  String get _password => _passwordController.text;
 
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {
   // print( 'submitted called.');
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
      Navigator.of(context).pop(); // dismiss sign in form.
    } catch( e ) {
      print ( e.toString() );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

   // print( 'email ${_emailController.text}, pwd ${_passwordController.text}');
  }

  void _emailEditingComplete(){
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of( context ).requestFocus( newFocus );
  }

  void _toggleFormType () {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn ? 
        EmailSignInFormType.register : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

List<Widget> _buildChildren( ) {
  final primaryText = _formType == EmailSignInFormType.signIn ? 
    'Sign In' : 'Create an account';
  final secondaryText = _formType == EmailSignInFormType.signIn ? 
    'Need an account?' : 'Have an account? Sign in';  

  bool submitEnabled = widget.emailValidator.isValid( _email ) && 
    widget.passwordValidator.isValid( _password ) && !_isLoading;

  return [
    _buildEmailTextField(),
    SizedBox( height: 8.0 ),

    _buildPasswordTextField(),  
    SizedBox( height: 8.0 ),   

    FormSubmitButton(
      text: primaryText,
      onPressed: submitEnabled ? _submit : null,
    ),
    SizedBox( height: 8.0 ),

    FlatButton(
      child: Text( secondaryText ),
      onPressed: !_isLoading ? _toggleFormType : null,
    ),  
  ];
}

TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid( _email );
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration( 
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingComplete,
    );
}

TextField _buildPasswordTextField() {
    bool showErrorText = _submitted && !widget.passwordValidator.isValid( _password );
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(  
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (pasword) => _updateState(),
      onEditingComplete: _submit,
    );
}

  @override
  Widget build(BuildContext context) {
    return Padding( 
      padding: const EdgeInsets.all( 16.0 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
//  print( 'email: $_email, password: $_password');
    setState (() {} );
  }
}
