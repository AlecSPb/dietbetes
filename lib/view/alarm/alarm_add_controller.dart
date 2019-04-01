import 'dart:async';
import 'dart:convert';

import 'package:dietbetes/models/alarm.dart';
import 'package:dietbetes/view/alarm/alarm_add_view.dart';
import 'package:dietbetes/view/alarm/alarm_controller.dart';
import 'package:dietbetes/wigdet/dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

import 'package:dietbetes/util/bloc.dart';
import 'package:dietbetes/util/api.dart';
import 'package:dietbetes/util/session.dart';

class AlarmAddCtrl extends Object implements BlocBase {
  final _time = BehaviorSubject<TimeOfDay>(seedValue: new TimeOfDay.now());
  final _id = BehaviorSubject<int>();
  final _name = BehaviorSubject<String>();
  final _hour = BehaviorSubject<String>();
  final _type = BehaviorSubject<String>();
  final _typeList = BehaviorSubject<List<int>>(seedValue: []);
  final _note = BehaviorSubject<String>();
  final _activated = BehaviorSubject<int>(seedValue: 1);
  final _loading = BehaviorSubject<bool>();
  
  Stream<TimeOfDay> get getTime => _time.stream;
  Stream<String> get getName => _name.stream;
  Stream<String> get getHour => _hour.stream;
  Stream<String> get getType => _type.stream;
  Stream<List<int>> get getTypeList => _typeList.stream;
  Stream<String> get getNote => _note.stream;
  Stream<int> get getActivated => _activated.stream;
  Stream<bool> get getLoading => _loading.stream;

  Function(TimeOfDay) get updateTime => _time.sink.add;
  Function(int) get updateId => _id.sink.add;
  Function(String) get updateName => _name.sink.add;
  Function(String) get updateHour => _hour.sink.add;
  Function(String) get updateType => _type.sink.add;
  Function(List<int>) get updateTypeList => _typeList.sink.add;
  Function(String) get updateNote => _note.sink.add;
  Function(int) get updateActivated => _activated.sink.add;
  Function(bool) get updateLoading => _loading.sink.add;

  @override
  void dispose() {
    _id.close();
    _time.close();
    _name.close();
    _hour.close();
    _type.close();
    _note.close();
    _activated.close();
    _loading.close();
  }

  Future selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time.value
    );

    if (picked != null && picked != _time ) {
        _time.sink.add(picked);
        _hour.sink.add(picked.hour.toString() + ':' + picked.minute.toString());
    }
  }

  scheduleDelete(BuildContext context) {
    dialogs.prompt(context, "Apakah anda ingin menghapus pengingat ini?", () async {
      AlarmCtrl alarmCtrl = new AlarmCtrl();
      _loading.sink.add(true);
      var api = Api.access();
      Response response;

      try {
        response = await api.delete("/alarm/remove/${_id.value}", options: Api.headers(await sessions.load("token")));
        _loading.sink.add(false);
        alarmCtrl.getAlarms();
        Navigator.of(context).pop();
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Berhasil dihapus!")));
        
      } on DioError catch (e) {
        _loading.sink.add(false);
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
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
        }else{
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    });
  }

  scheduleSave(BuildContext context) async {
    var data;
    if (_id.value != null) {
      data = {
        "id": _id.value,
        "title": _name.value,
        "note": _note.value,
        "remind_at": _hour.value,
        "remind_on": _typeList.value.length > 6 ? "0":_typeList.value.toString().replaceFirst("[", "").replaceFirst("]", "").replaceAll(", ", ","),
        "type": _type.value,
        "status": _activated.value
      };
    } else {
      data = {
        "title": _name.value,
        "note": _note.value,
        "remind_at": _hour.value,
        "remind_on": _typeList.value.length > 6 ? "0":_typeList.value.toString().replaceFirst("[", "").replaceFirst("]", "").replaceAll(", ", ","),
        "type": _type.value,
        "status": _activated.value
      };
    }
    AlarmCtrl alarmCtrl = new AlarmCtrl();
    _loading.sink.add(true);
    // var api = Api.access();
    // Response response;

    // try {
    //   response = await api.post("/alarm/add", options: Api.headers(await sessions.load("token")), data: );
    //   _loading.sink.add(false);
    //   alarmCtrl.getAlarms();
    //   Navigator.of(context).pop();
    //   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Berhasil dihapus!")));
      
    // } on DioError catch (e) {
    //   _loading.sink.add(false);
    //   if (e.response != null) {
    //     var message = "Something when wrong!";
    //     print(e.response.data.runtimeType);
    //     if (e.response.data.runtimeType != String) {
    //       if (e.response.data.containsKey('validators')) {
    //         message = e.response.data['validators'].toString();
    //       }else if (e.response.data.containsKey('message')) {
    //         message = e.response.data['message'];
    //       }
    //     }else{
    //       message = e.response.data;
    //     }
    //     Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    //   }else{
    //     Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    //   }
    // }
    print(data);
    await Future.delayed(Duration(seconds: 4));
    _loading.sink.add(false);
    alarmCtrl.getAlarms();
    // Navigator.of(context).pop();
  }

  selectType(BuildContext context) {
    List<String> jenisList = ['Setiap Hari', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    List<int> dadangs = [];
    dialogs.popup(context,
      onTap: () {
        List<int> dadang = _typeList.value;
        _type.sink.add(dadang.length >= 7 ? "Setiap hari":dadang.map((x)=> jenisList[x]).toString().replaceFirst("(", "").replaceFirst(")", ""));
      },
      onCancel: () {
        if(_type.value == null) _typeList.sink.add([]);
      },
      title: "Aktif pada",
      items: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * .3,
        child: Material(
          child: StreamBuilder(
            initialData: dadangs,
            stream: getTypeList,
            builder: (context, AsyncSnapshot<List<int>> snapshot) {
              return ListView.builder(
                itemCount: 8,
                itemBuilder: (ctx, int i) {
                  return CheckboxListTile(
                    title: Text(jenisList[i]),
                    value: (snapshot.data.toString().contains(i.toString())) ? true:false,
                    onChanged: (val) {
                      List<int> dadang = snapshot.data;
                      if (i == 0) {
                        if (dadang.length >= 7) {
                          dadang.clear();
                        }else{
                          dadang.addAll([0,1,2,3,4,5,6,7]);
                        }
                      } else {
                        if (val == true && !dadang.toString().contains(i.toString())) {
                          dadang.add(i);
                          dadang.removeWhere((item) => item == 0);
                        }else{
                          dadang.removeWhere((item) => item == i);
                        }
                      }
                      _typeList.sink.add(dadang);
                    },
                  );
                },
              );
            }
          ),
        ),
      )
    );
  }



}

final alarmAddCtrl = AlarmAddCtrl();