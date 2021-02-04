import 'package:sponsorhumanity/services/auth.dart';
import 'package:sponsorhumanity/screens/Landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sponsorhumanity/services/common_functions.dart';
  
Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  tmpPrint( ' before Firebase Init App()');
  await Firebase.initializeApp();
  tmpPrint( 'After Firebase Init App()');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: LandingPage(
            auth: Auth( ),
      ),
    );
  }
}
