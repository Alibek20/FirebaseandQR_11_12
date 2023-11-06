import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/qr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_bloc.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'welcome_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  
  runApp(MyApp(firebaseAuth: firebaseAuth, prefs: prefs));
}

class MyApp extends StatelessWidget {
  final FirebaseAuth firebaseAuth;
  final SharedPreferences prefs;

  MyApp({required this.firebaseAuth, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(firebaseAuth, prefs), 
      child: MaterialApp(
        title: 'Flutter Firebase App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignInPage(),
        routes: {
          '/signup': (context) => SignUpPage(),
          '/welcome': (context) => WelcomePage(),
          '/scan': (context) => ScanPage()
        },
      ),
    );
  }
}