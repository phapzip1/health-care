class Symptom {
  final String name;
  final String icon;

  Symptom(this.name, this.icon);

  Symptom.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        icon = map["icon"];
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "icon": icon,
    };
  }
}
