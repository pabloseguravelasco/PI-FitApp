import 'package:fitapp_flutter/models/user/login_dto.dart';
import 'package:fitapp_flutter/models/login_response.dart';


abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  
}
