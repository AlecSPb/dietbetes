import 'dart:async';

import 'package:dietbetes/models/journal_diet.dart';
import 'package:dietbetes/models/user.dart';
import 'package:dietbetes/models/user_glucose.dart';
import 'package:dietbetes/util/api.dart';
import 'package:dietbetes/util/data.dart';
import 'package:dietbetes/util/session.dart';
import 'package:dietbetes/view/home/home_controller.dart';
import 'package:dietbetes/wigdet/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';
import 'package:dietbetes/util/bloc.dart';

class DashboardCtrl extends Object implements BlocBase {
  final session = Sessions();
  final _userData = BehaviorSubject<User>();
  final _userGlucose = BehaviorSubject<UserGlucose>();
  final _journalDiet = BehaviorSubject<JournalDiet>();
  final _name = BehaviorSubject<String>();

  Observable<User> get userData => _userData.stream;
  Observable<UserGlucose> get userGlucose => _userGlucose.stream;
  Observable<JournalDiet> get journalDiet => _journalDiet.stream;

  Stream<String> get getName => _name.stream;

  DashboardCtrl() {
    init();
  }

  @override
  void dispose() {
    _userData.close();
    _userGlucose.close();
    _journalDiet.close();
    _name.close();
  }

  init() async {
    getUserData();
  }

  Future getUserData() async {
    User user = await session.loadUser();
    _userData.sink.add(user);
    _name.sink.add(user.userDetail.callName);
    getUserGlucose();
    getJournalDiet();
  }

  Future getUserGlucose() async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get('/glucose/now', options: Api.headers(await session.load('token')));
      UserGlucose userGlucose = UserGlucose.fromJson(response.data['data']);
      _userGlucose.sink.add(userGlucose);

      homeCtrl.fromHome(_name.value, userGlucose.status);
      
    } on DioError catch (e) {
      if (e.response != null) {
        var message = "Something when wrong!";
        print(e.response.data.runtimeType);
        if (e.response.data.runtimeType != String) {
          if (e.response.data.containsKey('validators')) {
            message = e.response.data['validators'].toString();
          }else if (e.response.data.containsKey('message')) {
            message = e.response.data['message'];
          }
        }else{
          message = e.response.data;
        }
        _userGlucose.sink.addError(message);
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
      }else{
        _userGlucose.sink.addError(e.message);
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  Future getJournalDiet() async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get('/journal/criteria', options: Api.headers(await session.load('token')));
      JournalDiet userJournal = JournalDiet.fromJson(response.data['data']);
      _journalDiet.sink.add(userJournal);
      
    } on DioError catch (e) {
      if (e.response != null) {
        var message = "Something when wrong!";
        print(e.response.data.runtimeType);
        if (e.response.data.runtimeType != String) {
          if (e.response.data.containsKey('validators')) {
            message = e.response.data['validators'].toString();
          }else if (e.response.data.containsKey('message')) {
            message = e.response.data['message'];
          }
        }else{
          message = e.response.data;
        }
        _journalDiet.sink.addError(message);
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
      }else{
        _journalDiet.sink.addError(e.message);
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  getInfoStatus(BuildContext context,String status) {
    if (status != null) {
      if (status == "Hiperglikemia") {
        dialogs.information(context, title: status, child: Container(width: double.maxFinite,height: MediaQuery.of(context).size.height * .7,child: ListView(children: <Widget>[HtmlWidget(Static.HTML_HIPERGLIKEMIA)],)));
      }else if (status == "Hipoglikemia") {
        dialogs.information(context, title: status, child: Container(width: double.maxFinite,height: MediaQuery.of(context).size.height * .7,child: ListView(children: <Widget>[HtmlWidget(Static.HTML_HIPOGLIKEMIA)],)));
      }else if (status == "karbo") {
        dialogs.information(context, title: "Karbohidrat", child: Container(width: double.maxFinite,height: MediaQuery.of(context).size.height * .7,child: ListView(children: <Widget>[HtmlWidget(Static.KARBO)],)));
      }else if (status == "lemak") {
        dialogs.information(context, title: "Lemak", child: Container(width: double.maxFinite,height: MediaQuery.of(context).size.height * .7,child: ListView(children: <Widget>[HtmlWidget(Static.LEMAK)],)));
      }else if (status == "protein") {
        dialogs.information(context, title: "Protein", child: Container(width: double.maxFinite,height: MediaQuery.of(context).size.height * .7,child: ListView(children: <Widget>[HtmlWidget(Static.PROTEIN)],)));
      }
    }
  }
}

final dashboardCtrl = DashboardCtrl();