part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserFetched extends UserState {
  final UsuarioDTO usuarioDTO;
  

  const UserFetched(this.usuarioDTO);
  @override
  List<Object> get props => [usuarioDTO];

}

class UserFetchedError extends UserState {
  final String message;
  const UserFetchedError(this.message);
  List<Object> get props => [message];
}