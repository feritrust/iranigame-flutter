part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}


class OtpButtonClicked extends OtpEvent {
final String code;

  OtpButtonClicked(this.code);
}

class OtpRetrySendCode extends OtpEvent {}


