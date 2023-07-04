class HealthRecordModel {
  final String diagnostic;
  final String prescription;
  final String note;

  HealthRecordModel.fromMap(Map<String, dynamic> map)
      : diagnostic = map["diagnostic"],
        prescription = map["prescription"],
        note = map["note"];

  Map<String, dynamic> toMap() {
    return {
      "diagnostic": diagnostic,
      "prescription": prescription,
      "note": note,
    };
  }
}
