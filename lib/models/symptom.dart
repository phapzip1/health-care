import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class Symptom {
  final String name;
  final String icon;

  Symptom(this.name, this.icon);

}

class SymptomsProvider {
  static Future<List<Symptom>> getSymtoms() async {
    Directory.current;
    final file = await rootBundle.loadString("assets/symptoms.json");
    final data = jsonDecode(file) as List<dynamic>;
    return data.map((e) => Symptom(e["name"], e["icon"])).toList();
  }
}