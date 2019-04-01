import 'dart:async';
import 'package:dietbetes/util/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class SportCtrl extends Object implements BlocBase {
  final _data = BehaviorSubject<num>(seedValue: 0);
  final _agreement = BehaviorSubject<bool>(seedValue: false);
  final _approved = BehaviorSubject<bool>(seedValue: false);
  final _processed = BehaviorSubject<bool>(seedValue: false);
  final _checked = BehaviorSubject<bool>(seedValue: false);
  
  Stream<num> get getData => _data.stream;
  Stream<bool> get getAgreement => _agreement.stream;
  Stream<bool> get getApproved => _approved.stream;
  Stream<bool> get getProcessed => _processed.stream;
  Stream<bool> get getChecked => _checked.stream;

  Function(num) get updateData => _data.sink.add;
  Function(bool) get updateAgreement => _agreement.sink.add;
  Function(bool) get updateApproved => _approved.sink.add;
  Function(bool) get updateProcessed => _processed.sink.add;
  Function(bool) get updateChecked => _checked.sink.add;

  @override
  void dispose() {
    _data.close();
    _agreement.close();
    _approved.close();
    _processed.close();
    _checked.close();
  }

  calculate(GlobalKey<FormState> _form) {
    final form = _form.currentState;

    if (form.validate()) {
      form.save();
      if (_data.value < 1 && _processed.value != true) {
        _approved.sink.add(_data.value < 250 ? true : false);
        _processed.sink.add(true);
      }else{
        form.reset();
        _data.sink.add(0);
        _processed.sink.add(false);
      }
    }
  }

  openYutube() async {
    const url = 'https://youtu.be/03Ar9vo6VbM';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open youtube!';
    }
  }

}