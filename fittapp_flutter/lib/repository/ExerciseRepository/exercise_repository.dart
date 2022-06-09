

import 'package:fitapp_flutter/models/exercise/exercise_dto.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> fetchExercise();
   Future<ExerciseResponse> exercise(ExerciseDto exerciseDto, String filePath);
}
