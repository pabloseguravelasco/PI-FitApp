


import 'package:fitapp_flutter/models/diet/diet_dto.dart';
import 'package:fitapp_flutter/models/diet/diet_response.dart';

abstract class DietRepository {
  Future<List<Diet>> fetchDiet();
  Future<DietResponse> diet(DietDto exerciseDto, String filePath);
}
