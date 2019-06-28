// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

List<Menu> menuFromJson(String str) => new List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
    int id;
    dynamic type;
    String time;
    String title;
    String ingredients;
    String tutorial;
    int status;

    Menu({
        this.id,
        this.type,
        this.time,
        this.title,
        this.ingredients,
        this.tutorial,
        this.status,
    });

    factory Menu.fromJson(Map<String, dynamic> json) => new Menu(
        id: json["id"],
        type: json["type"],
        time: json["time"],
        title: json["title"],
        ingredients: json["ingredients"],
        tutorial: json["tutorial"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "time": time,
        "title": title,
        "ingredients": ingredients,
        "tutorial": tutorial,
        "status": status,
    };
}
