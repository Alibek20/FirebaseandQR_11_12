import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/auth_event.dart';
import 'package:flutter_firebase/auth_state.dart';
import 'auth_bloc.dart';

class SignUpPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedIn) {
            Navigator.pushReplacementNamed(context, '/welcome');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.message),
              ));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextField(controller: _fullNameController, decoration: InputDecoration(labelText: 'Full Name')),
              TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password')),
              TextField(controller: _phoneNumberController, decoration: InputDecoration(labelText: 'Phone Number')),
              TextField(controller: _countryController, decoration: InputDecoration(labelText: 'Country')),
              ElevatedButton(
  onPressed: () {
   
    context.read<AuthBloc>().add(
      AuthSignUpRequested(
        _emailController.text, 
        _passwordController.text,
        _fullNameController.text, 
        _phoneNumberController.text, 
        _countryController.text, 
      ),
    );
  },
  child: Text('Sign Up'),
),
            ],
          );
        },
      ),
    );
  }
}