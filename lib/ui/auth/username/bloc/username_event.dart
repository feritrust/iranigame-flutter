part of 'username_bloc.dart';

abstract class UsernameEvent extends Equatable {
  const UsernameEvent();
  @override
  List<Object> get props => [];
}

class UsernameFinalRegistration extends UsernameEvent {
  final String fullName,username,phone,password;

  const UsernameFinalRegistration(this.username, this.fullName, this.phone, this.password);
}
