
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String country;

  AuthSignUpRequested(this.email, this.password, this.fullName, this.phoneNumber, this.country);

  @override
  List<Object> get props => [email, password, fullName, phoneNumber, country];
}

class AuthSignOutRequested extends AuthEvent {}