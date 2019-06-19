import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:dietbetes/models/alarm.dart';
import 'package:dietbetes/util/validator.dart';
import 'package:dietbetes/view/alarm/alarm_add_controller.dart';
import 'package:dietbetes/wigdet/dialog.dart';
import 'package:dietbetes/wigdet/loading.dart';
import 'package:flutter/material.dart';

class AlarmAdd extends StatefulWidget {
  Alarm data;
  AlarmAdd(this.data);

  @override
  _AlarmAddState createState() => _AlarmAddState();
}

class _AlarmAddState extends State<AlarmAdd> with ValidationMixin{
  AlarmAddCtrl alarmAddCtrl;
  final key = GlobalKey<ScaffoldState>();
  final _formAlarm = GlobalKey<FormState>();
  final _note = TextEditingController();
  final _title = TextEditingController();
  final List<String> jenisList = ['Setiap Hari', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
  // _
  List<Widget> topButton = [];

  @override
  void initState() {
    alarmAddCtrl = new AlarmAddCtrl();
    super.initState();
    if (widget.data != null) {
      alarmAddCtrl.updateActivated(widget.data.status);
      alarmAddCtrl.updateId(widget.data.id);
      alarmAddCtrl.updateName(widget.data.title);
      alarmAddCtrl.updateHour(widget.data.remindAt);
      alarmAddCtrl.updateNote(widget.data.note);
      if (widget.data.remindOn == 0) {
        alarmAddCtrl.updateType('Setiap Hari');
        alarmAddCtrl.updateTypeList([0]);
      } else {
        List lists = json.decode("[${widget.data.remindOn}]");
        String result = lists.map((i) => jenisList[i]).toList().toString();
        alarmAddCtrl.updateType(result.replaceFirst("[", "").replaceFirst("]", ""));
        alarmAddCtrl.updateTypeList(lists.cast<int>());
      }
      _title.text = widget.data.title;
      _note.text = widget.data.note;
      topButton.add(Padding(
        child: IconButton(
          icon: Icon(Icons.delete),
          tooltip: 'Hapus Pengingat',
          onPressed: () => alarmAddCtrl.scheduleDelete(_formAlarm),
        ),
        padding: const EdgeInsets.only(right: 5.0),
      ));
    }

    topButton.add(Padding(
      child: IconButton(
        icon: Icon(Icons.save),
        tooltip: 'Simpan Pengingat',
        onPressed: () => alarmAddCtrl.scheduleSave(_formAlarm),
      ),
      padding: const EdgeInsets.only(right: 5.0),
    ));
  }

  @override
  void dispose() { 
    alarmAddCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: key,
          appBar: AppBar(
            title: Text(widget.data != null ? 'Ubah Pengingat':'Tambah Pengingat'),
            actions: topButton 
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formAlarm,
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.7)
                      )
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: StreamBuilder(
                            stream: alarmAddCtrl.getActivated,
                            builder: (context, AsyncSnapshot<int> snapshot) {
                              return RadioListTile(
                                value: 1,
                                title: Text('Aktif', style: TextStyle(fontSize: 14.0)),
                                groupValue: snapshot.data,
                                onChanged: alarmAddCtrl.updateActivated,
                              );
                            }
                          )
                        ),
                        Expanded(
                          child: 
                          StreamBuilder(
                            stream: alarmAddCtrl.getActivated,
                            builder: (context, AsyncSnapshot<int> snapshot) {
                              return RadioListTile(
                                value: 0,
                                title: Text('Tidak Aktif', style: TextStyle(fontSize: 14.0)),
                                groupValue: snapshot.data,
                                onChanged: alarmAddCtrl.updateActivated,
                              );
                            }
                          )
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: alarmAddCtrl.getName,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _title,
                        validator: validateRequired,
                        onSaved: alarmAddCtrl.updateName,
                        decoration: InputDecoration(
                          labelText: 'Nama Pengingat',
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                        ),
                      );
                    }
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.7)
                      )
                    ),
                    height: 50.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 11.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Text('Jam', style: TextStyle(color: Colors.black54, fontSize: 16.0))
                                ),
                                Expanded(
                                  flex: 5,
                                  child: StreamBuilder(
                                    stream: alarmAddCtrl.getHour,
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(snapshot.data, style: TextStyle(fontSize: 16.0));
                                      } return Text("");
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: InkWell(
                            child: Icon(Icons.access_alarm, size: 30.0, color: Colors.green),
                            onTap: () => alarmAddCtrl.selectTime(context),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text("Aktif pada : ",style: TextStyle(fontSize: 17.0, color: Colors.black54)),
                        Expanded(
                          child: 
                          InkWell(
                            onTap: () => alarmAddCtrl.selectType(context),
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              padding: EdgeInsets.only(left: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: StreamBuilder(
                                      initialData: "",
                                      stream: alarmAddCtrl.getType,
                                      builder: (context, AsyncSnapshot<String> snapshot) {
                                        return Text(snapshot.data, style: TextStyle(fontSize: 17.0));
                                      }
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            )
                          )
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.0))
                    ),
                  ),
                  StreamBuilder(
                    stream: alarmAddCtrl.getNote,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return TextFormField(
                        controller: _note,
                        validator: validateRequired,
                        onSaved: alarmAddCtrl.updateNote,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Catatan',
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                        ),
                      );
                    }
                  ),
                ],
              ),
            )
          ),
        ),
        StreamBuilder(
          stream: alarmAddCtrl.getLoading,
          builder: (context, snapshot) {
            return Loading(snapshot.data == true);
          }
        )
      ],
    );
  }
}