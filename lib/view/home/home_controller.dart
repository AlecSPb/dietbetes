import 'dart:async';

import 'package:dietbetes/util/session.dart';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:dietbetes/util/bloc.dart';

class HomeCtrl extends Object implements BlocBase {
  final session = new Sessions();
  final _pageIdxCtrl = BehaviorSubject<int>();
  final _titleCtrl = BehaviorSubject<String>();
  final _nameCtrl = BehaviorSubject<String>();
  final _statusCtrl = BehaviorSubject<String>();

  Stream<int> get selectedDrawerIndex => _pageIdxCtrl.stream;
  Stream<String> get title => _titleCtrl.stream;
  Stream<String> get name => _nameCtrl.stream;
  Stream<String> get status => _statusCtrl.stream;

  Function(int) get updateSelectedDrawerIndex => _pageIdxCtrl.sink.add;
  Function(String) get updateTitle => _titleCtrl.sink.add;

  @override
  void dispose() {
    _pageIdxCtrl.close();
    _titleCtrl.close();
  }

  HomeCtrl() {
    init();
  }

  init() {
    print('Init first');
    _pageIdxCtrl.sink.add(0);
    _titleCtrl.sink.add("DIETBETES");
  }

  fromHome(String name, String status) {
    _nameCtrl.sink.add(name);
    _statusCtrl.sink.add(status);
  }

  Future logout(BuildContext context) async {
    await session.clear();
    Navigator.of(context).pushReplacementNamed('/');
  }

  Future openProfile(BuildContext context) {
    Navigator.of(context).pushNamed('/profile');
  }

  Future onSelectItem(BuildContext context, int index) {
    _pageIdxCtrl.sink.add(index);
    switch (index) {
      case 1:
        _titleCtrl.sink.add('Jurnal Makanan');
        break;
      case 2:
        _titleCtrl.sink.add('Aktifitas Fisik');
        break;
      case 3:
        _titleCtrl.sink.add('Menu Hari Ini');
        break;
      case 4:
        _titleCtrl.sink.add('Pengingat');
        break;
      case 5:
        _titleCtrl.sink.add('Bantuan');
        break;
      default:
        _titleCtrl.sink.add('DIETBETES');
    }
    Navigator.of(context).pop(); // close the drawer
  }

  Color getColors(String status) {
    if (status == "Hiperglikemia") {
      return Colors.red;
    }else if (status == "Hipoglikemia") {
      return Colors.yellow.shade700;
    }else{
      return Colors.green;
    }
  }
}

final homeCtrl = HomeCtrl();