import 'package:fitapp_flutter/models/exercise_response.dart';

abstract class UserRepository {
  Future<UsuarioDTO> fetchUser();
}
