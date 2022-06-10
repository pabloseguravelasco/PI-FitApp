import 'dart:convert';
import 'package:fitapp_flutter/models/exercise/exercise_dto.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'exercise_repository.dart';
import 'dart:io';
import '../../constants.dart';

class ExerciseRepositoryImpl extends ExerciseRepository {
  final Client _client = Client();

  @override
  Future<List<Exercise>> fetchExercise() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    final response =
        await _client.get(Uri.parse('${Constant.apiUrl}/exercise'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200) {
      return ExerciseResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load exercise');
    }
  }

  @override
  Future<ExerciseResponse> exercise(ExerciseDto exerciseDto, filePath) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}"
    };
    var uri = Uri.parse('${Constant.apiUrl}post/');
    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll(header);
    request.fields['title'] = exerciseDto.title;
    request.fields['text'] = exerciseDto.text;
    request.fields['link'] = exerciseDto.link;
    request.fields['duration'] = exerciseDto.duration;
    request.fields['zone'] = exerciseDto.zone;
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();

    if (response.statusCode == 201) {
      return ExerciseResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      throw Exception('Fail to save exercise');
    }
  }
}
/**CREAR METODO DE CREAR EJERECICIO */
