// To parse this JSON data, do
//
//     final fatSecretFoods = fatSecretFoodsFromJson(jsonString);

import 'dart:convert';

FatSecretFoods fatSecretFoodsFromJson(String str) {
    final jsonData = json.decode(str);
    return FatSecretFoods.fromJson(jsonData);
}

String fatSecretFoodsToJson(FatSecretFoods data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class FatSecretFoods {
    List<Food> food;
    String maxResults;
    String pageNumber;
    String totalResults;

    FatSecretFoods({
        this.food,
        this.maxResults,
        this.pageNumber,
        this.totalResults,
    });

    factory FatSecretFoods.fromJson(Map<String, dynamic> json) => new FatSecretFoods(
        food: new List<Food>.from(json["food"].map((x) => Food.fromJson(x))),
        maxResults: json["max_results"],
        pageNumber: json["page_number"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "food": new List<dynamic>.from(food.map((x) => x.toJson())),
        "max_results": maxResults,
        "page_number": pageNumber,
        "total_results": totalResults,
    };
}

class Food {
    String brandName;
    String foodDescription;
    String foodId;
    String foodName;
    FoodType foodType;
    String foodUrl;

    Food({
        this.brandName,
        this.foodDescription,
        this.foodId,
        this.foodName,
        this.foodType,
        this.foodUrl,
    });

    factory Food.fromJson(Map<String, dynamic> json) => new Food(
        brandName: json["brand_name"] == null ? null : json["brand_name"],
        foodDescription: json["food_description"],
        foodId: json["food_id"],
        foodName: json["food_name"],
        foodType: foodTypeValues.map[json["food_type"]],
        foodUrl: json["food_url"],
    );

    Map<String, dynamic> toJson() => {
        "brand_name": brandName == null ? null : brandName,
        "food_description": foodDescription,
        "food_id": foodId,
        "food_name": foodName,
        "food_type": foodTypeValues.reverse[foodType],
        "food_url": foodUrl,
    };
}

enum FoodType { BRAND, GENERIC }

final foodTypeValues = new EnumValues({
    "Brand": FoodType.BRAND,
    "Generic": FoodType.GENERIC
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
