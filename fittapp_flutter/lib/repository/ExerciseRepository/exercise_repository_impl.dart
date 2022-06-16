import 'dart:convert';
import 'package:fitapp_flutter/models/exercise/exercise_dto.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'exercise_repository.dart';
import 'dart:io';
import '../../constants.dart';
import 'package:http_parser/http_parser.dart';

class ExerciseRepositoryImpl extends ExerciseRepository {
  final Client _client = Client();

  @override
  Future<List<Exercise>> fetchExercise() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    final response =
        await _client.get(Uri.parse('${Constant.apiUrl}/exercise/list'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200) {
      return //ExerciseResponse.fromJson(json.decode(response.body)).content;
      ExerciseResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load exercises');
    }
  }

  @override
  Future<Exercise> newExercise(ExerciseDto exerciseDto, filePath) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
     Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': "multipart/form-data",
    };
    var uri = Uri.parse('${Constant.apiUrl}/exercise/');
    final body = jsonEncode({
      'title': exerciseDto.title,
      'text': exerciseDto.text,
      'duration': exerciseDto.duration,
      'zone': exerciseDto.zone,
      'link': exerciseDto.link
      
    });

    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromString('exercise', body,
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromPath('file', filePath))
      ..headers.addAll(headers);

    var response = await request.send();

    final responded = await http.Response.fromStream(response);


    if (response.statusCode == 201) {
      return Exercise.fromJson(
          json.decode(responded.body));
    } else {
      throw Exception('Fail to save exercise');
    }
  }

  @override
  Future<Exercise> editExercise(ExerciseDto exerciseDto, filePath, int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
     Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': "multipart/form-data",
    };
    var uri = Uri.parse('${Constant.apiUrl}/exercise/${id}');
    final body = jsonEncode({
      'title': exerciseDto.title,
      'text': exerciseDto.text,
      'duration': exerciseDto.duration,
      'zone': exerciseDto.zone,
      'link': exerciseDto.link
      
    });

    final request = http.MultipartRequest('PUT', uri)
      ..files.add(http.MultipartFile.fromString('exercise', body,
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromPath('file', filePath))
      ..headers.addAll(headers);

    var response = await request.send();

    final responded = await http.Response.fromStream(response);


    if (response.statusCode == 200) {
      return Exercise.fromJson(
          json.decode(responded.body));
    } else {
      throw Exception('Fail to save exercise');
    }
  }
  

  @override
   void deleteExercise(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
     Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': "multipart/form-data",
    };
    var uri = Uri.parse('${Constant.apiUrl}/exercise/${id}');
     final request = http.MultipartRequest('DELETE', uri)
      ..headers.addAll(headers);

    await request.send();  

      
  }

}

