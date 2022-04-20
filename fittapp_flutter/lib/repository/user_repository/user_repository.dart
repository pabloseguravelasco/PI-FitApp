import 'package:fitapp_flutter/models/post_response.dart';

abstract class UserRepository {
  Future<UsuarioDTO> fetchUser();
}
