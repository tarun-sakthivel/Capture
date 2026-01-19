part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SubmitLogin extends AuthEvent {
  final String username;
  final String phone;

  SubmitLogin({required this.username, required this.phone});
}