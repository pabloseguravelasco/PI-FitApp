import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitapp_flutter/models/user/login_dto.dart';
import 'package:fitapp_flutter/models/login_response.dart';
import 'package:fitapp_flutter/repository/auth_repository/auth_repository.dart';

part 'login_state.dart';
part 'login_event.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitialState()) {
    on<DoLoginEvent>(_doLoginEvent);
  }

  void _doLoginEvent(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      final loginResponse = await authRepository.login(event.loginDto);
      emit(LoginSuccessState(loginResponse));
      return;
    } on Exception catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}