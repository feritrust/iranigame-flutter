part of 'username_bloc.dart';

abstract class UsernameState extends Equatable {
  const UsernameState();

  @override
  List<Object> get props => [];
}

class UsernameInitial extends UsernameState {}

class UsernameSuccess extends UsernameState {}

class UsernameError extends UsernameState {
  final AppException exception;

  const UsernameError(this.exception);
}
