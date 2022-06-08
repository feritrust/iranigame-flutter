part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpError extends OtpState {
  final AppException exception;

  const OtpError(this.exception);

  @override
  List<Object> get props => [exception];
}
