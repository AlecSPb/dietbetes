import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dietbetes/util/bloc.dart';
import 'package:dietbetes/util/api.dart';
import 'package:dietbetes/util/session.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dietbetes/models/journal_calendar.dart';

class JournalCalendarCtrl extends Object implements BlocBase {
  final _calendars = PublishSubject<List<JournalCalendars>>();

  Stream<List<JournalCalendars>> get getCalendars => _calendars.stream;

  JournalCalendarCtrl() {
    getDataCalendars();
  }

  @override
  void dispose() {
    _calendars.close();
  }

  Future getDataCalendars() async {
    print('call api');
    var api = Api.access();
    Response response;

    try {
      response = await api.get("/journal/calendar", options: Api.headers(await sessions.load('token')));
      _calendars.sink.add(await compute(journalCalendarsFromJson, json.encode(response.data['data'])));
      print(response.data['data']);
    } on DioError catch (e) {
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
        _calendars.sink.addError(message);
      }else{
        _calendars.sink.addError(e.message);
      }
    }
  }
}

final journalCalendarCtrl = JournalCalendarCtrl();