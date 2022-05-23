

import 'package:fitapp_flutter/models/exercise_response.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> fetchExercise();
}
