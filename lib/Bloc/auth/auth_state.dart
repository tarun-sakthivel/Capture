part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final token;

  LoginSuccess(this.token);
}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure(this.error);
}
