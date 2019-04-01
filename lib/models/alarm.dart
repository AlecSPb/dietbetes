// To parse this JSON data, do
//
//     final alarm = alarmFromJson(jsonString);

import 'dart:convert';

List<Alarm> alarmFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<Alarm>.from(jsonData.map((x) => Alarm.fromJson(x)));
}

String alarmToJson(List<Alarm> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class Alarm {
    int id;
    int userId;
    String title;
    String note;
    String remindAt;
    dynamic remindOn;
    int status;
    String createdAt;
    String updatedAt;
    dynamic deletedAt;

    Alarm({
        this.id,
        this.userId,
        this.title,
        this.note,
        this.remindAt,
        this.remindOn,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory Alarm.fromJson(Map<String, dynamic> json) => new Alarm(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        note: json["note"],
        remindAt: json["remind_at"],
        remindOn: json["remind_on"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "note": note,
        "remind_at": remindAt,
        "remind_on": remindOn,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
    };
}
