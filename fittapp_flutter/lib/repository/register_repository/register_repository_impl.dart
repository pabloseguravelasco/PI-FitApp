import 'package:fitapp_flutter/models/register_dto.dart';
import 'package:fitapp_flutter/models/register_response.dart';
import 'package:fitapp_flutter/repository/register_repository/register_repository.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';


import '../../constants.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  @override
  Future<RegisterResponse> register(RegisterDto registerDto, filePath) async {
    Map<String, String> headers = {
      'Content-Type': "multipart/form-data",
    };
    var uri = Uri.parse('${Constant.apiUrl}/auth/register');
    final body = jsonEncode({
      'nombre': registerDto.nombre,
      'nickname': registerDto.nickname,
      'email':registerDto.email,
      'fechaNacimiento': registerDto.fechaNacimiento,
      'password':registerDto.password,
      'password2':registerDto.password
    });

    final request = http.MultipartRequest('POST',uri)
      ..files.add(http.MultipartFile.fromString('user', body, contentType: MediaType('application','json')))
      ..files.add(await http.MultipartFile.fromPath('file', filePath))
      ..headers.addAll(headers);

    var response = await request.send();

    final responded = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return RegisterResponse.fromJson(
          json.decode(responded.body));
    } else {
      throw Exception('Failed to register');
    }
  }
}
