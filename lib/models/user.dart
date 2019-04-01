// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) {
    final jsonData = json.decode(str);
    return User.fromJson(jsonData);
}

String userToJson(data) {
    return json.encode(data);
}

class User {
    int id;
    String email;
    String username;
    String token;
    dynamic googleToken;
    dynamic onesignalToken;
    String avatarUrl;
    String lastLogin;
    int status;
    UserDetail userDetail;

    User({
        this.id,
        this.email,
        this.username,
        this.token,
        this.googleToken,
        this.onesignalToken,
        this.avatarUrl,
        this.lastLogin,
        this.status,
        this.userDetail,
    });

    factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        token: json["token"],
        googleToken: json["google_token"],
        onesignalToken: json["onesignal_token"],
        avatarUrl: json["avatar_url"],
        lastLogin: json["last_login"],
        status: json["status"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "token": token,
        "google_token": googleToken,
        "onesignal_token": onesignalToken,
        "avatar_url": avatarUrl,
        "last_login": lastLogin,
        "status": status,
        "user_detail": userDetail.toJson(),
    };
}

class UserDetail {
    int id;
    int userId;
    String fullName;
    String callName;
    int gender;
    String dob;
    int physicalActivity;
    int height;
    int weight;
    int idealWeight;
    int massIndex;
    int historyFamily;
    int cholTotal;
    int cholLdl;
    int cholHdl;
    int triglesida;
    String bloodPressure;
    String clinicalSymptoms;

    UserDetail({
        this.id,
        this.userId,
        this.fullName,
        this.callName,
        this.gender,
        this.dob,
        this.physicalActivity,
        this.height,
        this.weight,
        this.idealWeight,
        this.massIndex,
        this.historyFamily,
        this.cholTotal,
        this.cholLdl,
        this.cholHdl,
        this.triglesida,
        this.bloodPressure,
        this.clinicalSymptoms,
    });

    factory UserDetail.fromJson(Map<String, dynamic> json) => new UserDetail(
        id: json["id"],
        userId: json["user_id"],
        fullName: json["full_name"],
        callName: json["call_name"],
        gender: json["gender"],
        dob: json["dob"],
        physicalActivity: json["physical_activity"],
        height: json["height"],
        weight: json["weight"],
        idealWeight: json["ideal_weight"],
        massIndex: json["mass_index"],
        historyFamily: json["history_family"],
        cholTotal: json["chol_total"],
        cholLdl: json["chol_ldl"],
        cholHdl: json["chol_hdl"],
        triglesida: json["triglesida"],
        bloodPressure: json["blood_pressure"],
        clinicalSymptoms: json["clinical_symptoms"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "full_name": fullName,
        "call_name": callName,
        "gender": gender,
        "dob": dob,
        "physical_activity": physicalActivity,
        "height": height,
        "weight": weight,
        "ideal_weight": idealWeight,
        "mass_index": massIndex,
        "history_family": historyFamily,
        "chol_total": cholTotal,
        "chol_ldl": cholLdl,
        "chol_hdl": cholHdl,
        "triglesida": triglesida,
        "blood_pressure": bloodPressure,
        "clinical_symptoms": clinicalSymptoms,
    };
}
