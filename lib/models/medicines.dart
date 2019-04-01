// To parse this JSON data, do
//
//     final medicines = medicinesFromJson(jsonString);

import 'dart:convert';

List<Medicines> medicinesFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<Medicines>.from(jsonData['data'].map((x) => Medicines.fromJson(x)));
}

String medicinesToJson(List<Medicines> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class Medicines {
    int id;
    String type;
    String generic;
    String name;
    String content;
    String dose;
    String workingHour;
    String frequent;
    String suggestion;

    Medicines({
        this.id,
        this.type,
        this.generic,
        this.name,
        this.content,
        this.dose,
        this.workingHour,
        this.frequent,
        this.suggestion,
    });

    factory Medicines.fromJson(Map<String, dynamic> json) => new Medicines(
        id: json["id"],
        type: json["type"],
        generic: json["generic"],
        name: json["name"],
        content: json["content"] == null ? null : json["content"],
        dose: json["dose"] == null ? null : json["dose"],
        workingHour: json["working_hour"] == null ? null : json["working_hour"],
        frequent: json["frequent"] == null ? null : json["frequent"],
        suggestion: json["suggestion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "generic": generic,
        "name": name,
        "content": content == null ? null : content,
        "dose": dose == null ? null : dose,
        "working_hour": workingHour == null ? null : workingHour,
        "frequent": frequent == null ? null : frequent,
        "suggestion": suggestion,
    };
}
