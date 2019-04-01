import 'dart:async';
import 'dart:convert';

import 'package:dietbetes/models/alarm.dart';
import 'package:dietbetes/view/alarm/alarm_add_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

import 'package:dietbetes/util/bloc.dart';
import 'package:dietbetes/util/api.dart';
import 'package:dietbetes/util/session.dart';

class AlarmCtrl extends Object implements BlocBase {
  final _listAlarm = PublishSubject<List<Alarm>>();

  Observable<List<Alarm>> get fetchAlarm => _listAlarm.stream;

  AlarmCtrl() {
    getAlarms();
  }

  @override
  void dispose() {
    _listAlarm.close();
  }

  Future getAlarms() async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get('/alarm/list', options: Api.headers(await sessions.load('token')));
      _listAlarm.sink.add(await compute(alarmFromJson, json.encode(response.data['data'])));
    } on DioError catch (e) {
      print(e.response.data);
        print(e.message);
        if (e.response != null) {
          var message = "Something when wrong!";
          if (e.response.data.runtimeType != String) {
            if (e.response.data.containsKey('validators')) {
              message = e.response.data['validators'].toString();
            }else if (e.response.data.containsKey('message')) {
              message = e.response.data['message'];
            }
          }else{
            message = e.response.data;
          }
          _listAlarm.sink.addError(message);
        }else{
          _listAlarm.sink.addError(e.message);
        }
    }
  }

  editAlarm(BuildContext context, Alarm data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => AlarmAdd(data)
      )
    );
  }

}