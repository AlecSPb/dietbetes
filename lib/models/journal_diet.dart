// To parse this JSON data, do
//
//     final journalDiet = journalDietFromJson(jsonString);

import 'dart:convert';

JournalDiet journalDietFromJson(String str) {
    final jsonData = json.decode(str);
    return JournalDiet.fromJson(jsonData);
}

String journalDietToJson(JournalDiet data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class JournalDiet {
    Requirement requirement;
    Result result;

    JournalDiet({
        this.requirement,
        this.result,
    });

    factory JournalDiet.fromJson(Map<String, dynamic> json) => new JournalDiet(
        requirement: Requirement.fromJson(json["requirement"]),
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "requirement": requirement.toJson(),
        "result": result.toJson(),
    };
}

class Requirement {
    String type;
    num calories;
    num protein;
    num fat;
    num carbo;
    num realCalories;
    String giziStatus;

    Requirement({
        this.type,
        this.calories,
        this.protein,
        this.fat,
        this.carbo,
        this.realCalories,
        this.giziStatus,
    });

    factory Requirement.fromJson(Map<String, dynamic> json) => new Requirement(
        type: json["type"],
        calories: json["calories"],
        protein: json["protein"],
        fat: json["fat"],
        carbo: json["carbo"],
        realCalories: json["real_calories"],
        giziStatus: json["gizi_status"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "calories": calories,
        "protein": protein,
        "fat": fat,
        "carbo": carbo,
        "real_calories": realCalories,
        "gizi_status": giziStatus,
    };
}

class Result {
    int calories;
    double protein;
    double fat;
    double carbo;

    Result({
        this.calories,
        this.protein,
        this.fat,
        this.carbo,
    });

    factory Result.fromJson(Map<String, dynamic> json) => new Result(
        calories: json["calories"],
        protein: json["protein"].toDouble(),
        fat: json["fat"].toDouble(),
        carbo: json["carbo"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "calories": calories,
        "protein": protein,
        "fat": fat,
        "carbo": carbo,
    };
}
