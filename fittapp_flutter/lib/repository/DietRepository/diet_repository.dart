


import 'package:fitapp_flutter/models/diet_response.dart';

abstract class DietRepository {
  Future<List<Diet>> fetchDiet();
}
