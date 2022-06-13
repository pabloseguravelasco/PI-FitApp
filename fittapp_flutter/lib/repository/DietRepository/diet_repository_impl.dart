import 'dart:convert';
import 'package:fitapp_flutter/models/diet/diet_dto.dart';
import 'package:fitapp_flutter/models/diet/diet_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart';
import '../../constants.dart';
import 'diet_repository.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class DietRepositoryImpl extends DietRepository {
  final Client _client = Client();

  @override
  Future<List<Diet>> fetchDiet() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    final response =
        await _client.get(Uri.parse('${Constant.apiUrl}/diet/list'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200) {
      return DietResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load diets');
    }
  }

  @override
  Future<Diet> newDiet(DietDto dietDto, filePath) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
     Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': "multipart/form-data",
    };
    var uri = Uri.parse('${Constant.apiUrl}/diet/');
    final body = jsonEncode({
      'title': dietDto.title,
      'ingredient': dietDto.ingredient,
      'calories': dietDto.calories,
    
    });

    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromString('diet', body,
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromPath('file', filePath))
      ..headers.addAll(headers);

    var response = await request.send();

    final responded = await http.Response.fromStream(response);


    if (response.statusCode == 201) {
      return Diet.fromJson(
         json.decode(responded.body));
    } else {
      throw Exception('Fail to save diet');
    }
  }

    @override
   void deleteDiet(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
     Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': "multipart/form-data",
    };
    var uri = Uri.parse('${Constant.apiUrl}/diet/${id}');
     final request = http.MultipartRequest('DELETE', uri)
      ..headers.addAll(headers);

    await request.send();  

      
  }

 
}
