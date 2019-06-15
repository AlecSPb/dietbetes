// To parse this JSON data, do
//
//     final userGlucose = userGlucoseFromJson(jsonString);

import 'dart:convert';

UserGlucose userGlucoseFromJson(String str) {
    final jsonData = json.decode(str);
    return UserGlucose.fromJson(jsonData);
}

String userGlucoseToJson(String data) {
    return json.encode(data);
}

class UserGlucose {
    int id;
    int userId;
    num hba1C;
    num gdp;
    num gds;
    num ttgo;
    String createdAt;
    String updatedAt;
    String status;

    UserGlucose({
        this.id,
        this.userId,
        this.hba1C,
        this.gdp,
        this.gds,
        this.ttgo,
        this.createdAt,
        this.updatedAt,
        this.status,
    });

    factory UserGlucose.fromJson(Map<String, dynamic> json) => new UserGlucose(
        id: json["id"],
        userId: json["user_id"],
        hba1C: json["hba1c"],
        gdp: json["gdp"],
        gds: json["gds"],
        ttgo: json["ttgo"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "hba1c": hba1C,
        "gdp": gdp,
        "gds": gds,
        "ttgo": ttgo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "status": status,
    };
}
