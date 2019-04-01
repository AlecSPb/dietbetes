

import 'dart:convert';

import 'package:dietbetes/models/fat_secret_foods.dart';
import 'package:dietbetes/util/api.dart';
import 'package:dietbetes/util/bloc.dart';
import 'package:dietbetes/util/session.dart';
import 'package:dietbetes/view/journal/journal_controller.dart';
import 'package:dietbetes/wigdet/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class JournalAddCtrl extends Object implements BlocBase {

  final _isLoading = BehaviorSubject<bool>(seedValue: false);
  final _searchData = BehaviorSubject<bool>(seedValue: false);
  final _search = BehaviorSubject<String>();
  final _foodList = PublishSubject<FatSecretFoods>();

  Observable<FatSecretFoods> get getFoodList => _foodList.stream;
  Stream<String> get getSreach => _search.stream;
  Stream<bool> get getLoading => _isLoading.stream;
  Stream<bool> get getSearchData => _searchData.stream;
  
  Function(String) get updateSearch => _search.sink.add;

  
  @override
  void dispose() {
    _isLoading.close();
    _searchData.close();
    _search.close();
    _foodList.close();
  }

  Future searchFoods(BuildContext context) async {
    _searchData.sink.add(true);
    _foodList.sink.add(null);
    var api = Api.access();
    Response response;

    try {
      response = await api.post("/fatsecret/search", data: {'keywords': _search.value},options: Api.headers(await sessions.load("token")));
      _foodList.sink.add(await compute(fatSecretFoodsFromJson, json.encode(response.data['data'])));
      _searchData.sink.add(false);
    } on DioError catch (e) {
      _searchData.sink.add(false);
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
        _foodList.sink.addError(message);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
      }else{
        _foodList.sink.addError(e.message);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  Future onSelect(BuildContext context, int schedule, Food food) {
    dialogs.prompt(context, "Yakin ${food.foodName} akan ditambahkan ke jurnal anda?", () async {
      _isLoading.sink.add(true);
      var api = Api.access();
      Response response;

      try {
        print({"schedule": schedule, "food_id": food.foodId});
        response = await api.post("/journal/add", data: {"schedule": schedule, "food_id": food.foodId}, options: Api.headers(await sessions.load("token")));
        journalCtrl.getJournal();
        Navigator.pop(context);
        _isLoading.sink.add(false);
      } on DioError catch (e) {
        _isLoading.sink.add(false);
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
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
        }else{
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    });
  }

}