import 'dart:convert';
import 'dart:io';

import 'package:fitapp_flutter/models/exercise_response.dart';
import 'package:fitapp_flutter/repository/user_repository/user_repository.dart';
import 'package:http/http.dart';

import '../../constants.dart';

class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

  @override
  Future<UsuarioDTO> fetchUser() async {
    String token = Constant.token;
    final response =
        await _client.get(Uri.parse('${Constant.apiUrl}/me'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (response.statusCode == 200) {
      return UsuarioDTO.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load user');
    }
  }
}
