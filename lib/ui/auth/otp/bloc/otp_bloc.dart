import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iranigame/common/exception.dart';
import 'package:iranigame/data/repo/auth_repository.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final IAuthRepository authRepository;
  final String username;
  final String password;

  OtpBloc(this.authRepository, this.username, this.password) : super(OtpInitial()) {
    on<OtpEvent>((event, emit) async{
      if (event is OtpButtonClicked) {
        emit(OtpLoading());
        final response = await authRepository.sendCode(username,password,event.code);
        if(response.isDone){
          emit(OtpSuccess());
        }
      } else if (event is OtpRetrySendCode) {
        final response = await authRepository.sendSms(username, password);
      }
    });
  }
}
