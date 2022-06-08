import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iranigame/common/exception.dart';
import 'package:iranigame/data/repo/auth_repository.dart';

part 'username_event.dart';
part 'username_state.dart';

class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  final IAuthRepository authRepository;
  UsernameBloc(this.authRepository) : super(UsernameInitial()) {
    on<UsernameEvent>((event, emit) async{
      if (event is UsernameFinalRegistration) {
        // final response = await authRepository.
      }
    });
  }
}
