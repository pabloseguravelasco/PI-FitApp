import 'package:fitapp_flutter/models/register_dto.dart';
import 'package:fitapp_flutter/models/register_response.dart';
import 'package:fitapp_flutter/repository/register_repository/register_repository.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  @override
  Future<RegisterResponse> register(RegisterDto registerDto, filePath) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    var uri = Uri.parse('${Constant.apiUrl}auth/register/');
    var request = http.MultipartRequest('POST', uri);

    request.fields['nombre'] = registerDto.nombre;
    request.fields['nick'] = registerDto.nick;
    request.fields['email'] = registerDto.email;
    request.fields['fechaNacimiento'] = registerDto.fechaNacimiento;
    request.fields['password'] = registerDto.password;
    request.fields['password2'] = registerDto.password;

    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      throw Exception('Failed to register');
    }
  }
}
