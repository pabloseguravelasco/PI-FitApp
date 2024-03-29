

import 'package:fitapp_flutter/models/exercise/exercise_dto.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> fetchExercise();
   Future<Exercise> newExercise(ExerciseDto exerciseDto, String filePath);
     Future<Exercise> editExercise(ExerciseDto exerciseDto, String filePath, int id);
    void deleteExercise(int id); 
}
