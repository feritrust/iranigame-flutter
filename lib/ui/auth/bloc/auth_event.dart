part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthButtonIsClicked extends AuthEvent{
  final String username,password;

  const AuthButtonIsClicked(this.username, this.password);
}

class AuthModeChangeIsClicked extends AuthEvent{}
