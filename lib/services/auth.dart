import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/semantics.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

//
// Public Interface AuthBase that implements all authentications.
//
abstract class AuthBase {
  User get currentUser;
  Stream<void> authStateChanges();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<void> signOut();
}

class Auth implements AuthBase {

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<void> authStateChanges() => _firebaseAuth.authStateChanges(); 

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if ( googleUser != null ) { // user has previously signed in
      final googleAuth = await googleUser.authentication;
      if ( googleAuth.idToken != null ) {
        final userCredential = await _firebaseAuth.signInWithCredential(
           GoogleAuthProvider.credential(
             idToken: googleAuth.idToken, 
             accessToken: googleAuth.accessToken,
           ));
           return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user.',
      );    
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(    
      permissions: [FacebookPermission.publicProfile, FacebookPermission.email, ]
    );
    switch (response.status ) {
      case FacebookLoginStatus.Success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential( accessToken.token ));
        return userCredential.user;
          break;
      case FacebookLoginStatus.Cancel:
        throw FirebaseAuthException( 
          code: 'ERROR_ABORTED_BY_USER',
          message: 'User aborted Facebook login',
        );
        break;
      case FacebookLoginStatus.Error:
         throw FirebaseAuthException( 
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error.developerMessage,
        );
        break;
      default: 
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final facebookSignIn = FacebookLogin();
    await facebookSignIn.logOut();
    
    await _firebaseAuth.signOut();
  }
}