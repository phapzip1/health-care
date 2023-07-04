class SymptomModel {
  final String name;
  final String icon;

  SymptomModel(this.name, this.icon);

  SymptomModel.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        icon = map["icon"];
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "icon": icon,
    };
  }
}
