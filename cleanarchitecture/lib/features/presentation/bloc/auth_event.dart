part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoLogin extends AuthEvent {
  final String email;
  final String password;

  DoLogin(this.email, this.password);
}

class DoRegister extends AuthEvent {
  final String email;
  final String password;

  DoRegister(this.email, this.password);
}