import 'package:dietbetes/models/alarm.dart';
import 'package:dietbetes/view/alarm/alarm_add_view.dart';
import 'package:dietbetes/view/alarm/alarm_controller.dart';
import 'package:dietbetes/wigdet/error_page.dart';
import 'package:dietbetes/wigdet/loading.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  AlarmCtrl alarmCtrl;

  @override
  void initState() {
    alarmCtrl = new AlarmCtrl();
    super.initState();
  }

  @override
  void dispose() {
    alarmCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: alarmCtrl.fetchAlarm,
          builder: (context, AsyncSnapshot<List<Alarm>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Text('Jaga pola makan dan atur jam makan mu', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic))
                ]..addAll(snapshot.data.map((alarm) {
                  return ListTile(
                    onTap: () async {
                      var data = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => AlarmAdd(alarm)
                        )
                      );
                      if (data != null) {
                        alarmCtrl.getAlarms();
                      }
                    },
                    leading: alarm.status == 1 ? Icon(Icons.alarm_on, color: Colors.green):Icon(Icons.alarm_off, color: Colors.red),
                    title: Text(alarm.title),
                  );
                }).toList()),
              );
            }else if (snapshot.hasError) {
              return Center(
                child: ErrorPage(
                  message: snapshot.error.toString(),
                  buttonText: "Ulangi Lagi",
                  onPressed: alarmCtrl.getAlarms,
                )
              );
            } return Center(child: LoadingBlock(Theme.of(context).primaryColor));
          }
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          child: Icon(Icons.alarm_add),
          onPressed: () async {
            var data = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => AlarmAdd(null)
              )
            );
            if (data != null) {
              alarmCtrl.getAlarms();
            }
          },
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.black12
        ),
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.alarm_on, color: Colors.green),
                Text(' Alarm Aktif')
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.alarm_off, color: Colors.red),
                Text(' Alarm Tidak Aktif')
              ],
            )
          ],
        ),
      ),
    );
  }
}