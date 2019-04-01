import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:dietbetes/util/api.dart';
import 'package:dietbetes/util/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dietbetes/util/bloc.dart';

class GlucoseCtrl extends Object implements BlocBase {
  final _date = BehaviorSubject<String>();
  final _gdp = BehaviorSubject<String>();
  final _gds = BehaviorSubject<String>();
  final _hba1c = BehaviorSubject<String>();
  final _ttgo = BehaviorSubject<String>();
  final _isLoading = BehaviorSubject<bool>();

  Stream<String> get getDate => _date.stream;
  Stream<String> get getGDP => _gdp.stream;
  Stream<String> get getGDS => _gds.stream;
  Stream<String> get getHbA1C => _hba1c.stream;
  Stream<String> get getTTGO => _ttgo.stream;
  Stream<bool> get getLoading => _isLoading.stream;

  Function(String) get updateDate => _date.sink.add;
  Function(String) get updateGDP => _gdp.sink.add;
  Function(String) get updateGDS => _gds.sink.add;
  Function(String) get updateHbA1C => _hba1c.sink.add;
  Function(String) get updateTTGO => _ttgo.sink.add;

  GlucoseCtrl() {
    _isLoading.sink.add(false);
  }

  @override
  void dispose() {
    _date.close();
    _gdp.close();
    _gds.close();
    _hba1c.close();
    _ttgo.close();
  }

  Future datePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now()
    );

    if (picked != null && picked != _date) {
      print(picked);
      _date.sink.add(formatDate(picked, [yyyy,'/',mm,'/',dd]));
    }
  }

  Future saveGlucose(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      _isLoading.sink.add(true);
      var api = Api.access();
      Response response;

      try {
        print({
          "date": _date.value,
          "hba1c": _hba1c.value,
          "gdp": _gdp.value,
          "gds": _gds.value,
          "ttgo": _ttgo.value
        });
        response = await api.post("/glucose/add", data: {
          "date": _date.value,
          "hba1c": _hba1c.value,
          "gdp": _gdp.value,
          "gds": _gds.value,
          "ttgo": _ttgo.value
        }, options: Api.headers(await sessions.load('token')));
        _isLoading.sink.add(false);
        Scaffold.of(key.currentContext).showSnackBar(SnackBar(content: Text("Pembaruan Gula Darah Berhasil!")));
        Navigator.pop(key.currentContext);
        
      } on DioError catch (e) {
        print(e.message);
        print(e.response);
        _isLoading.sink.add(false);
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
          Scaffold.of(key.currentContext).showSnackBar(SnackBar(content: Text(message)));
        }else{
          Scaffold.of(key.currentContext).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
  }
}

// final glucoseCtrl = new GlucoseCtrl();