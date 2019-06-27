import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dietbetes/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dietbetes/util/bloc.dart';
import 'package:dietbetes/util/session.dart';
import 'package:dietbetes/util/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';

class ProfileCtrl extends Object implements BlocBase {
  final _userData = BehaviorSubject<User>();
  final _fullName = BehaviorSubject<String>();
  final _tinggi = BehaviorSubject<num>();
  final _berat = BehaviorSubject<num>();
  final _date = BehaviorSubject<DateTime>();
  final _time = BehaviorSubject<TimeOfDay>();
  final _name = BehaviorSubject<String>();
  final _callName = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _conf_password = BehaviorSubject<String>();
  final _gender = BehaviorSubject<int>();
  final _physical = BehaviorSubject<int>();
  final _birthdate = BehaviorSubject<String>();
  final _ideal_weight = BehaviorSubject<num>();
  final _ibm = BehaviorSubject<num>();
  final _history = BehaviorSubject<int>();
  final _gula_puasa = BehaviorSubject<String>();
  final _gula_sewaktu = BehaviorSubject<String>();
  final _gula_makan = BehaviorSubject<String>();
  final _hba1c = BehaviorSubject<String>();
  final _chol_total = BehaviorSubject<String>();
  final _ldl = BehaviorSubject<String>();
  final _hdl = BehaviorSubject<String>();
  final _trigliserida = BehaviorSubject<String>();
  final _last_tensi = BehaviorSubject<String>();
  final _gejala_klinis = BehaviorSubject<String>();
  final _obat = BehaviorSubject<String>();
  final _isLoading = BehaviorSubject<bool>();
  final _statusGizi = BehaviorSubject<String>();
  final _avatar = BehaviorSubject<File>();
  final _avatar_url = BehaviorSubject<String>();

  final _icon1 = BehaviorSubject<IconData>(seedValue: Icons.expand_more);
  final _icon2 = BehaviorSubject<IconData>(seedValue: Icons.expand_more);
  final _icon3 = BehaviorSubject<IconData>(seedValue: Icons.expand_more);

  Stream<User> get getUserData => _userData.stream;
  Stream<String> get getFullName => _fullName.stream;

  Stream<IconData> get getIcon1 => _icon1.stream;
  Stream<IconData> get getIcon2 => _icon2.stream;
  Stream<IconData> get getIcon3 => _icon3.stream;
  Stream<String> get getAvatarUrl => _avatar_url.stream;
  
  
  
  Function(IconData) get updateIcon1 => _icon1.sink.add;
  Function(IconData) get updateIcon2 => _icon2.sink.add;
  Function(IconData) get updateIcon3 => _icon3.sink.add;

  ProfileCtrl() {
    init();
  }

  @override
  void dispose() {
    _fullName.close();
    _tinggi.close();
    _berat.close();
    _date.close();
    _time.close();
    _name.close();
    _callName.close();
    _email.close();
    _password.close();
    _conf_password.close();
    _gender.close();
    _physical.close();
    _birthdate.close();
    _ideal_weight.close();
    _ibm.close();
    _history.close();
    _gula_puasa.close();
    _gula_sewaktu.close();
    _gula_makan.close();
    _hba1c.close();
    _chol_total.close();
    _ldl.close();
    _hdl.close();
    _trigliserida.close();
    _last_tensi.close();
    _gejala_klinis.close();
    _obat.close();
    _isLoading.close();
    _statusGizi.close();
    _avatar.close();
    _avatar_url.close();
  }

  init() async {
    User user = await sessions.loadUser();
    _userData.sink.add(user);
    _fullName.sink.add(user.userDetail.fullName);
    _email.sink.add(user.email);
    _avatar_url.sink.add(await sessions.load("avatar"));
  }

  TextEditingController initialValue(String val) {
    return TextEditingController(text: val);
  }

  void uploadAvatar(BuildContext context) async {
    containerForSheet<String>(
      context: context,
      child: CupertinoActionSheet(
          title: const Text('Ambil gambar dari?'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.camera_alt),
                  SizedBox(width: 10),
                  const Text('Camera'),
                ],
              ),
              onPressed: () async {
                _avatar.sink.add(await ImagePicker.pickImage(source: ImageSource.camera));
                doUpload(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.images),
                  SizedBox(width: 10),
                  const Text('Galery'),
                ],
              ),
              onPressed: () async {
                _avatar.sink.add(await ImagePicker.pickImage(source: ImageSource.gallery));
                doUpload(context);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          )),
    );
  } 

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('You clicked $value'),
        duration: Duration(milliseconds: 800),
      ));
    });
  }

  doUpload(BuildContext context) async {
    if (_avatar.value == null) return;
    String base64Image = "data:image/jpeg;base64,${base64Encode(_avatar.value.readAsBytesSync())}";
    String fileName = _avatar.value.path.split("/").last;
    
    var api = Api.access();
    Response response;

    try {
      response = await api.post("/user/update-avatar", data: {"avatar_file" : base64Image}, options: Api.headers(await sessions.load('token')));
      _avatar_url.sink.add(response.data['data']);
      sessions.save("avatar", response.data['data']);

      
    } on DioError catch (e) {
      var message = "Something when wrong!";
      if (e.response != null) {
        if (e.response.data.containsKey('validators')) {
          message = e.response.data['validators'].toString();
        }else if (e.response.data.containsKey('message')) {
          message = e.response.data['message'];
        }
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
      }else{
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }


  
}