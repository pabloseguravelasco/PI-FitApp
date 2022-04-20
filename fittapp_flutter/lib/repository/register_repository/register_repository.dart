

import 'package:fitapp_flutter/models/register_dto.dart';
import 'package:fitapp_flutter/models/register_response.dart';

abstract class RegisterRepository {

   Future<RegisterResponse> register(RegisterDto registerDto, String filePath);

}