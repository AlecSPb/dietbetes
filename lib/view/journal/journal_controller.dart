import 'dart:async';
import 'dart:convert';

import 'package:dietbetes/models/fat_secret_foods.dart';
import 'package:dietbetes/models/journal_diet.dart';
import 'package:dietbetes/models/journal_list.dart';
import 'package:dietbetes/util/api.dart';
import 'package:dietbetes/wigdet/dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dietbetes/util/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dietbetes/util/session.dart';

class JournalCtrl extends Object implements BlocBase {
  final _journalData = BehaviorSubject<JournalDiet>();
  final _journalList = BehaviorSubject<List<JournalList>>();

  Observable<JournalDiet> get getJournalData => _journalData.stream;
  Observable<List<JournalList>> get getJournalList => _journalList.stream;

  JournalCtrl() {
    getJournal();
  }

  @override
  void dispose() {
    _journalData.close();
    _journalList.close();
  }

  Future getJournal() async {
    print('load Journal');
    var api = Api.access();
    Response resData;
    Response resList;

    try {
      resData = await api.get('/journal/criteria', options: Api.headers(await sessions.load('token')));
      resList = await api.get('/journal/list', options: Api.headers(await sessions.load('token')));

      _journalData.sink.add(await compute(journalDietFromJson, json.encode(resData.data['data'])));
      _journalList.sink.add(await compute(journalListFromJson, json.encode(resList.data['data'])));
    } on DioError catch (e) {

      print(e.response);
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
        _journalData.sink.addError(message);
        _journalList.sink.addError(message);
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
      }else{
        _journalData.sink.addError(e.message);
        _journalList.sink.addError(e.message);
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }
}

final journalCtrl = new JournalCtrl();