import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/auth_event.dart';
import 'package:flutter_firebase/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';




class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences _prefs;

  AuthBloc(this._firebaseAuth, this._prefs) : super(AuthInitial()) {
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(AuthSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSignedIn());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'An unknown error occurred'));
    }
  }

  Future<void> _onSignUpRequested(AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      
      await _prefs.setBool('isNewUser', true);

      emit(AuthSignedIn());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'An unknown error occurred'));
    }
  }

  Future<void> _onSignOutRequested(AuthSignOutRequested event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut();
    emit(AuthSignedOut());
  }
}