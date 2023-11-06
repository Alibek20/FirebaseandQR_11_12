import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/auth_event.dart';
import 'auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isNewUser = false;

  @override
  void initState() {
    super.initState();
    _loadNewUserStatus();
  }

  Future<void> _loadNewUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNewUser = prefs.getBool('isNewUser') ?? false;

      if (_isNewUser) {
        prefs.setBool('isNewUser', false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOutRequested());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the App!'),
            if (_isNewUser) ...[
              Text('Добро пожаловать!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
            ],
            Text('You are now signed in.'),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOutRequested());
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('Sign Out'),
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () {
                
                Navigator.pushNamed(context, '/scan');
              },
              child: Text('Go to QR'),
            ),
          ],
        ),
      ),
    );
  }
}