import 'dart:convert';
import 'dart:io';


import 'package:fitapp_flutter/models/user/user_dto.dart';
import 'package:fitapp_flutter/repository/user_repository/user_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

  @override
  Future<UsuarioDTO> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
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
