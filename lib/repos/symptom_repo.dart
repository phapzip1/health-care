import 'package:health_care/models/symptom_model.dart';

abstract class SymptomRepo {
  Future<List<SymptomModel>> getAll();
}