import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:dietbetes/models/medicines.dart';
import 'package:dietbetes/models/user.dart';
import 'package:dietbetes/util/api.dart';
import 'package:dietbetes/util/session.dart';
import 'package:dietbetes/wigdet/dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';
import 'package:dietbetes/util/bloc.dart';
import 'package:flutter/material.dart';

class RegisterCtrl extends Object implements BlocBase {
  
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

  final _daftarObat = PublishSubject<List<Medicines>>();


  Stream<num> get getTinggi => _tinggi.stream;
  Stream<num> get getBerat => _berat.stream;
  Stream<DateTime> get getDate => _date.stream;
  Stream<TimeOfDay> get getTime => _time.stream;
  Stream<String> get getName => _name.stream;
  Stream<String> get getCallName => _callName.stream;
  Stream<String> get getEmail => _email.stream;
  Stream<String> get getPassword => _password.stream;
  Stream<String> get getConfPassword => _conf_password.stream;
  Stream<int> get getGender => _gender.stream;
  Stream<int> get getPhysical => _physical.stream;
  Stream<String> get getBirthdate => _birthdate.stream;
  Stream<num> get getIbm => _ibm.stream;
  Stream<int> get getHistory => _history.stream;
  Stream<num> get getIdealWeight => _ideal_weight.stream;
  Stream<String> get getGula_puasa => _gula_puasa.stream;
  Stream<String> get getGula_sewaktu => _gula_sewaktu.stream;
  Stream<String> get getGula_makan => _gula_makan.stream;
  Stream<String> get getHba1c => _hba1c.stream;
  Stream<String> get getTotalChol => _chol_total.stream;
  Stream<String> get getLdl => _ldl.stream;
  Stream<String> get getHdl => _hdl.stream;
  Stream<String> get getTrigliserida => _trigliserida.stream;
  Stream<String> get getlast_tensi => _last_tensi.stream;
  Stream<String> get getGejala_klinis => _gejala_klinis.stream;
  Stream<String> get getObat => _obat.stream;
  Stream<bool> get getLoading => _isLoading.stream;
  Stream<String> get getStatusGizi => _statusGizi.stream;

  Observable<List<Medicines>> get getDaftarObat => _daftarObat.stream;

  Function(num) get updateTinggi => _tinggi.sink.add;
  Function(num) get updateBerat => _berat.sink.add;
  Function(DateTime) get updateDate => _date.sink.add;
  Function(TimeOfDay) get updateTime => _time.sink.add;
  Function(String) get updateName => _name.sink.add;
  Function(String) get updateCallName => _callName.sink.add;
  Function(String) get updateEmail => _email.sink.add;
  Function(String) get updatePassword => _password.sink.add;
  Function(String) get updateConfPassword => _conf_password.sink.add;
  Function(int) get updateGender => _gender.sink.add;
  Function(int) get updatePhysical => _physical.sink.add;
  Function(String) get updateBirthdate => _birthdate.sink.add;
  Function(num) get updateIbm => _ibm.sink.add;
  Function(int) get updatehistory => _history.sink.add;
  Function(String) get updateGula_puasa => _gula_puasa.sink.add;
  Function(String) get updateGula_sewaktu => _gula_sewaktu.sink.add;
  Function(String) get updateGula_makan => _gula_makan.sink.add;
  Function(String) get updateHba1c => _hba1c.sink.add;
  Function(String) get updateCholTotal => _chol_total.sink.add;
  Function(String) get updateLdl => _ldl.sink.add;
  Function(String) get updateHdl => _hdl.sink.add;
  Function(String) get updateTrigliserida => _trigliserida.sink.add;
  Function(String) get updatelast_tensi => _last_tensi.sink.add;
  Function(String) get updateGejala_klinis => _gejala_klinis.sink.add;
  Function(String) get updateObat => _obat.sink.add;

  RegisterCtrl() {
    _isLoading.sink.add(false);
  }


  @override
  void dispose() {
    _tinggi.close();
    _berat.close();
    _date.close();
    _time.close();
    _name.close();
    _name.close();
    _callName.close();
    _email.close();
    _password.close();
    _conf_password.close();
    _gender.close();
    _physical.close();
    _birthdate.close();
    _ibm.close();
    _history.close();
    _ideal_weight.close();
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
    _daftarObat.close();
  }

  Future fetchMadicines() async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get('/user/medicines');
      List<Medicines> obatList = await compute(medicinesFromJson, json.encode(response.data));
      _daftarObat.sink.add(obatList);
    } on DioError catch (e) {
      if (e.response != null) {
        var message = "Something when wrong!";
        if (e.response.data.containsKey('validators')) {
          message = e.response.data['validators'].toString();
        }else if (e.response.data.containsKey('message')) {
          message = e.response.data['message'];
        }
        // Scaffold.of(key.currentContext).showSnackBar(SnackBar(content: Text(message)));
        _daftarObat.sink.add(throw Exception(message));
      }else{
        _daftarObat.sink.add(throw Exception(e.message));
        // Scaffold.of(key.currentContext).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  Future onChange({TextEditingController tinggi, TextEditingController berat}) {
    print('Tinggi Badan : ${tinggi.text}');
    print('Berat Badan : ${berat.text}');

    if (berat.text == '' || tinggi.text == '') {
      _ibm.sink.add(0);
    }else{
      _tinggi.sink.add(num.parse(tinggi.text));
      _berat.sink.add(num.parse(berat.text));
      _tinggi.sink.add(_tinggi.value * 0.01);
      _ibm.sink.add(_berat.value ~/ (_tinggi.value * _tinggi.value));      
      _ibm.sink.add((_berat.value != null || _berat.value != '') || (_tinggi.value != null || _tinggi.value != '') ? _ibm.value : 0); 
      print('ibm : ${_ibm.value}');

      if (_ibm.value < 18.5) {
        _statusGizi.sink.add('BB Kurang');
      }else if(_ibm.value >= 18.5 && _ibm.value < 25) {
        _statusGizi.sink.add('BB Normal');          
      }else if(_ibm.value == 25) {
        _statusGizi.sink.add('BB Lebih');        
      }else if(_ibm.value > 25 && _ibm.value < 30) {
        _statusGizi.sink.add('Pre-Obesitas');        
      }else if(_ibm.value >= 30 && _ibm.value < 35) {
        _statusGizi.sink.add('Obes I');        
      }else if(_ibm.value >= 35 && _ibm.value < 40) {
        _statusGizi.sink.add('Obes II');        
      }else{
        _statusGizi.sink.add('Obes III');        
      }

      if (_gender.value != null && (num.parse(tinggi.text) != null && num.parse(tinggi.text) != '')) {
        if ((_gender.value == 1 && num.parse(tinggi.text) < 160) || (_gender.value == 0 && num.parse(tinggi.text) < 150)) {
          _ideal_weight.sink.add(num.parse(tinggi.text) - 100);
        }else{
          _ideal_weight.sink.add(0.9 * (num.parse(tinggi.text) - 100));
        }
      }
    }
  }

  Future datePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now()
    );

    if (picked != null && picked != _date) {
      _date.sink.add(picked);
      _birthdate.sink.add(formatDate(_date.value, [yyyy,'-',mm,'-',dd]));
    }
  }

  Future dialogKlinis(BuildContext context) {
    var data = [
      {
        "name": "Polidipsi (Sering merasa haus)",
        "value": 1,
      },
      {
        "name": "Poliuri (Sering buang air kecil)",
        "value": 2,
      },
      {
        "name": "Penurunan Berat tubuh yang tidak direncanakan",
        "value": 3,
      },
      {
        "name": "Sering merasa lemas",
        "value": 4,
      },
    ];
    dialogs.popup(context, title: "Gelaja Klinis yang dirasakan?", onTap: () {}, items: 
      Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * .3,
        child: Material(
          child: StreamBuilder(
            stream: _gejala_klinis.stream,
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, int i) {
                  String string = snapshot.data;
                  return CheckboxListTile(
                    title: Text(data[i]['name']),
                    value: string != null && string.contains(data[i]['value'].toString()),
                    onChanged: (val) {
                      if (string == null || string == '') {
                        _gejala_klinis.sink.add(data[i]['value'].toString());
                      }else {
                        if (_gejala_klinis.value.contains(data[i]['value'].toString())) {
                          if (string.indexOf(",${data[i]['value']}") != -1) {
                            _gejala_klinis.sink.add(string.replaceAll(",${data[i]['value']}", ''));
                          } else if (string.indexOf("${data[i]['value']},") != -1) {
                            _gejala_klinis.sink.add(string.replaceAll("${data[i]['value']},", ''));
                          } else {
                            _gejala_klinis.sink.add(string.replaceAll("${data[i]['value']}", ''));
                          }
                        }else{
                          _gejala_klinis.sink.add("${string},${data[i]['value']}");
                        }
                      }
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

  Future dialogObat(BuildContext context) {
    fetchMadicines();
    dialogs.popup(context, title: "Obat yang sedang dikonsumsi?", onTap: () {}, items: 
      Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * .3,
        child: Material(
          child: StreamBuilder(
            stream: _daftarObat.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Medicines> listObat = snapshot.data;
                return StreamBuilder(
                  stream: _obat.stream,
                  builder: (ctx, data) {
                    return ListView.builder(
                      itemCount: listObat.length,
                      itemBuilder: (ctx, int i) {
                        String string = data.data;
                        return CheckboxListTile(
                          title: Text(listObat[i].name),
                          value: string != null && string.contains(listObat[i].id.toString()),
                          onChanged: (val) {
                            if (string == null || string == '') {
                              _obat.sink.add(listObat[i].id.toString());
                            }else {
                              if (_obat.value.contains(listObat[i].id.toString())) {
                                if (string.indexOf(",${listObat[i].id}") != -1) {
                                  _obat.sink.add(string.replaceAll(",${listObat[i].id}", ''));
                                } else if (string.indexOf("${listObat[i].id},") != -1) {
                                  _obat.sink.add(string.replaceAll("${listObat[i].id},", ''));
                                } else {
                                  _obat.sink.add(string.replaceAll("${listObat[i].id}", ''));
                                }
                              }else{
                                _obat.sink.add("${string},${listObat[i].id}");
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                );
              }else if(snapshot.hasError) {
                return Center(child: Text("Error get Data"));
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }
          ),
        ),
      )
    );
  }

  Future submitData(GlobalKey key) async {
    _isLoading.sink.add(true);
    var api  = Api.access();
    Response response;

    try {
      response = await api.post('/auth/register', data:  {
        "full_name": _name.value,
        "call_name": _callName.value,
        "email": _email.value,
        "password": _password.value,
        "password_confirmation": _conf_password.value,
        "dob": _birthdate.value,
        "gender": _gender.value,
        "onsignal_token": "xxx",
        "physical_activity": _physical.value,
        "height": _tinggi.value,
        "weight": _berat.value,
        "ideal_weight": _ideal_weight.value,
        "mass_index": _ibm.value,
        "history_family": _history.value,
        "gdp": _gula_puasa.value,
        "gds": _gula_sewaktu.value,
        "hba1c": _hba1c.value,
        "ttgo": _gula_makan.value,
        "chol_total": _chol_total.value,
        "chol_ldl": _ldl.value,
        "chol_hdl": _hdl.value,
        "triglesida": _trigliserida.value,
        "blood_pressure": _last_tensi.value,
        "clinical_symptoms": "[${_gejala_klinis.value}]",
        "medicine": "[${_obat.value}]"
      });
      _isLoading.sink.add(false);

      Scaffold.of(key.currentContext).showSnackBar(SnackBar(content: Text("Register Success")));
      sessions.save("auth", userToJson(response.data['data']));
      var user = User.fromJson(response.data['data']);

      sessions.save("token", user.token);
      // print(await session.load('token'));
      // _loadingCtrl.sink.add(false);
      Navigator.of(key.currentContext).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } catch (e) {
      _isLoading.sink.add(false);
      if (e.response != null) {
        var message = "Something when wrong!";
        if (e.response.data.containsKey('validators')) {
          message = e.response.data['validators'].toString();
        }else if (e.response.data.containsKey('message')) {
          message = e.response.data['message'];
        }
        Scaffold.of(key.currentContext).showSnackBar(SnackBar(content: Text(message)));
      }else{
        Scaffold.of(key.currentContext).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

}

// final registerCtrl = RegisterCtrl();