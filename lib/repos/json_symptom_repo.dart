import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:health_care/models/symptom_model.dart';
import 'package:health_care/repos/repo_exception.dart';
import 'package:health_care/repos/symptom_repo.dart';

class JsonSymptomRepo extends SymptomRepo {
  @override
  Future<List<SymptomModel>> getAll() async {
    try {
      String data = await rootBundle.loadString("assets/symptoms.json");
      List<Map<String, dynamic>> jsonResult = (jsonDecode(data) as List).map((e) => e as Map<String, dynamic>).toList();
      return jsonResult.map((e) => SymptomModel.fromMap(e)).toList();
    } catch (e) {
      throw GenericDBException();
    }
  }
}
