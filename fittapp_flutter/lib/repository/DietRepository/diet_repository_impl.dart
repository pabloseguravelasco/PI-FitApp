import 'dart:convert';
import 'package:fitapp_flutter/models/diet_response.dart';
import 'package:fitapp_flutter/models/exercise_response.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart';
import '../constants.dart';
import 'diet_repository.dart';
import 'dart:io';

class DietRepositoryImpl extends DietRepository {
  final Client _client = Client();

  @override
  Future<List<Diet>> fetchDiet() async {
  
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    final response = await _client
        .get(Uri.parse('${Constants.baseUrl}/diet'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200) {
      return DietResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load diet');
    }
  }
}
