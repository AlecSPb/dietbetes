import 'dart:async';
import 'dart:convert';

import 'package:dietbetes/models/menu.dart';
import 'package:dietbetes/util/api.dart';
import 'package:dietbetes/util/bloc.dart';
import 'package:dietbetes/util/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FoodListCtrl extends Object implements BlocBase {
  final _listMenu = BehaviorSubject<List<Menu>>();
  Stream<List<Menu>> get getListMenu => _listMenu.stream;
  Function(List<Menu>) get updateListMenu => _listMenu.sink.add;

  @override
  void dispose() {
    _listMenu.close();
  }

  Future<void> _handleRefresh(GlobalKey<ScaffoldState> _scaffoldKey) {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              // _refreshIndicatorKey.currentState.show();
            }
          )
        )
      );
    });
  }


  Future<void> getList(String code) async {
    var api = Api.access();
    Response response;
    try {
      response = await api.get("/food/receipt/$code", options: Api.headers(await sessions.load("token")));
      print(response.data['data']);
      List<Menu> _menus = await compute(menuFromJson, json.encode(response.data['data']));
      _listMenu.sink.add(_menus);
    }on DioError catch (e) {
      if (e.response != null) {
        var message = "Something when wrong!";
        if (e.response.data.containsKey('validators')) {
          message = e.response.data['validators'].toString();
        }else if (e.response.data.containsKey('message')) {
          message = e.response.data['message'];
        }
        _listMenu.sink.add(throw Exception(message));
      }else{
        _listMenu.sink.add(throw Exception(e.message));
      }
    }
  }

}