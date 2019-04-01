// To parse this JSON data, do
//
//     final journalList = journalListFromJson(jsonString);

import 'dart:convert';

List<JournalList> journalListFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<JournalList>.from(jsonData.map((x) => JournalList.fromJson(x)));
}

String journalListToJson(List<JournalList> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class JournalList {
    int id;
    int userId;
    int cal;
    double carbo;
    double protein;
    double fat;
    int schedule;
    String createdAt;
    String updatedAt;

    JournalList({
        this.id,
        this.userId,
        this.cal,
        this.carbo,
        this.protein,
        this.fat,
        this.schedule,
        this.createdAt,
        this.updatedAt,
    });

    factory JournalList.fromJson(Map<String, dynamic> json) => new JournalList(
        id: json["id"],
        userId: json["user_id"],
        cal: json["cal"],
        carbo: json["carbo"].toDouble(),
        protein: json["protein"].toDouble(),
        fat: json["fat"].toDouble(),
        schedule: json["schedule"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "cal": cal,
        "carbo": carbo,
        "protein": protein,
        "fat": fat,
        "schedule": schedule,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
