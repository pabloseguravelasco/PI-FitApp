import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:fitapp_flutter/models/user/user_dto.dart';
import 'package:fitapp_flutter/repository/user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
   final UserRepository userRepository;
 

  UserBloc(this.userRepository) : super(UserInitial()) {
 
    on<FetchUserWithType>(_userFetched);
  }

  void _userFetched(FetchUserWithType event, Emitter<UserState> emit) async {
    try {
      final user = await userRepository.fetchUser();
      emit(UserFetched(user));
      return;
    } on Exception catch (e) {
      emit(UserFetchedError(e.toString()));
    }
  }
}
