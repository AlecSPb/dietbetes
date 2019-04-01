// To parse this JSON data, do
//
//     final fatSecretFood = fatSecretFoodFromJson(jsonString);

import 'dart:convert';

FatSecretFood fatSecretFoodFromJson(String str) {
    final jsonData = json.decode(str);
    return FatSecretFood.fromJson(jsonData);
}

String fatSecretFoodToJson(FatSecretFood data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class FatSecretFood {
    String foodId;
    String foodName;
    String foodType;
    String foodUrl;
    Serving serving;

    FatSecretFood({
        this.foodId,
        this.foodName,
        this.foodType,
        this.foodUrl,
        this.serving,
    });

    factory FatSecretFood.fromJson(Map<String, dynamic> json) => new FatSecretFood(
        foodId: json["food_id"],
        foodName: json["food_name"],
        foodType: json["food_type"],
        foodUrl: json["food_url"],
        serving: Serving.fromJson(json["serving"]),
    );

    Map<String, dynamic> toJson() => {
        "food_id": foodId,
        "food_name": foodName,
        "food_type": foodType,
        "food_url": foodUrl,
        "serving": serving.toJson(),
    };
}

class Serving {
    String calcium;
    String calories;
    String carbohydrate;
    String cholesterol;
    String fat;
    String fiber;
    String iron;
    String measurementDescription;
    String metricServingAmount;
    String metricServingUnit;
    String monounsaturatedFat;
    String numberOfUnits;
    String polyunsaturatedFat;
    String potassium;
    String protein;
    String saturatedFat;
    String servingDescription;
    String servingId;
    String servingUrl;
    String sodium;
    String sugar;
    String vitaminA;
    String vitaminC;

    Serving({
        this.calcium,
        this.calories,
        this.carbohydrate,
        this.cholesterol,
        this.fat,
        this.fiber,
        this.iron,
        this.measurementDescription,
        this.metricServingAmount,
        this.metricServingUnit,
        this.monounsaturatedFat,
        this.numberOfUnits,
        this.polyunsaturatedFat,
        this.potassium,
        this.protein,
        this.saturatedFat,
        this.servingDescription,
        this.servingId,
        this.servingUrl,
        this.sodium,
        this.sugar,
        this.vitaminA,
        this.vitaminC,
    });

    factory Serving.fromJson(Map<String, dynamic> json) => new Serving(
        calcium: json["calcium"],
        calories: json["calories"],
        carbohydrate: json["carbohydrate"],
        cholesterol: json["cholesterol"],
        fat: json["fat"],
        fiber: json["fiber"],
        iron: json["iron"],
        measurementDescription: json["measurement_description"],
        metricServingAmount: json["metric_serving_amount"],
        metricServingUnit: json["metric_serving_unit"],
        monounsaturatedFat: json["monounsaturated_fat"],
        numberOfUnits: json["number_of_units"],
        polyunsaturatedFat: json["polyunsaturated_fat"],
        potassium: json["potassium"],
        protein: json["protein"],
        saturatedFat: json["saturated_fat"],
        servingDescription: json["serving_description"],
        servingId: json["serving_id"],
        servingUrl: json["serving_url"],
        sodium: json["sodium"],
        sugar: json["sugar"],
        vitaminA: json["vitamin_a"],
        vitaminC: json["vitamin_c"],
    );

    Map<String, dynamic> toJson() => {
        "calcium": calcium,
        "calories": calories,
        "carbohydrate": carbohydrate,
        "cholesterol": cholesterol,
        "fat": fat,
        "fiber": fiber,
        "iron": iron,
        "measurement_description": measurementDescription,
        "metric_serving_amount": metricServingAmount,
        "metric_serving_unit": metricServingUnit,
        "monounsaturated_fat": monounsaturatedFat,
        "number_of_units": numberOfUnits,
        "polyunsaturated_fat": polyunsaturatedFat,
        "potassium": potassium,
        "protein": protein,
        "saturated_fat": saturatedFat,
        "serving_description": servingDescription,
        "serving_id": servingId,
        "serving_url": servingUrl,
        "sodium": sodium,
        "sugar": sugar,
        "vitamin_a": vitaminA,
        "vitamin_c": vitaminC,
    };
}
