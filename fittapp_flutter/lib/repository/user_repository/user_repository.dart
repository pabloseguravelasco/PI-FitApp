

import 'package:fitapp_flutter/models/user/user_dto.dart';

abstract class UserRepository {
  Future<UsuarioDTO> fetchUser();
}
