// To parse this JSON data, do
//
//     final journalCalendars = journalCalendarsFromJson(jsonString);

import 'dart:convert';

List<JournalCalendars> journalCalendarsFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<JournalCalendars>.from(jsonData.map((x) => JournalCalendars.fromJson(x)));
}

String journalCalendarsToJson(List<JournalCalendars> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class JournalCalendars {
    String day;
    bool sucess;

    JournalCalendars({
        this.day,
        this.sucess,
    });

    factory JournalCalendars.fromJson(Map<String, dynamic> json) => new JournalCalendars(
        day: json["day"],
        sucess: json["sucess"],
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "sucess": sucess,
    };
}
