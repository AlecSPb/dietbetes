import 'dart:async';
import 'dart:convert';
import 'package:dietbetes/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sessions {
  SharedPreferences prefs;

  Future<bool> checkAuth() async {
    prefs = await SharedPreferences.getInstance();
    var res = prefs.getString("auth");
    print(res);
    if (res == null) return false;
    return true;
  }

  save(String key, String data) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
    prefs.commit();
  }

  clear() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("auth");
  }

  Future<String> load(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<User> loadUser() async {
    prefs = await SharedPreferences.getInstance();
    return compute(userFromJson, prefs.getString("auth"));
  }
}

final sessions = Sessions();