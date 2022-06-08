import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iranigame/common/exception.dart';
import 'package:iranigame/data/repo/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  bool isLoginMode;

  AuthBloc({required this.authRepository, this.isLoginMode = true})
      : super(AuthInitial(isLoginMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        emit(AuthInitial(isLoginMode));
        if (event is AuthButtonIsClicked) {
          emit(AuthLoading(isLoginMode));
          if (isLoginMode) {
          } else {
            final sendSmsResponse =
                await authRepository.sendSms(event.username, event.password);
            if (sendSmsResponse.isDone) {
              emit(AuthSuccess(isLoginMode));
            } else {
              emit(AuthError(isLoginMode, AppException()));
            }
          }
        } else if (event is AuthModeChangeIsClicked) {
          isLoginMode = !isLoginMode;
          emit(AuthInitial(isLoginMode));
        }
      } catch (e) {
        emit(AuthError(isLoginMode, AppException()));
      }
    });
  }
}
