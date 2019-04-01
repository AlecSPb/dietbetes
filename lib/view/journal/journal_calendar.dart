import 'package:date_format/date_format.dart';
import 'package:dietbetes/view/journal/journal_calendar_controller.dart';
import 'package:dietbetes/wigdet/error_page.dart';
import 'package:dietbetes/wigdet/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiver/iterables.dart';
import 'package:dietbetes/models/journal_calendar.dart';

class JournalCalendar extends StatelessWidget {
  List dayName = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
  DateTime _current = new DateTime.now();
  List<List> calendar = [];
  List<int> week = [];
  
  initCalendar() async {
    var date = new DateTime.now();
    var prevMonth = new DateTime(date.year, date.month + 1, 0).day;
    int index = 1;

    for (var i = 0; i < 35; i++) {
      if (i < getFirstDay()) {
        week.add(null);
      }else{
        if (index <= prevMonth) {
          week.add(index);
          index++;
        }else{
          week.add(null);
        }
      }
    }
    calendar.addAll(partition(week, 7));
    print(calendar);
  }

  int getFirstDay() {
    var day = DateFormat.E().format(_current);
    return dayName.indexOf(day);
  }
  
  @override
  Widget build(BuildContext context) {
    JournalCalendarCtrl journalCalendarCtrl = JournalCalendarCtrl();
    initCalendar();
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal Calendar"),
      ),
      body: StreamBuilder(
        stream: journalCalendarCtrl.getCalendars,
        builder: (context, AsyncSnapshot<List<JournalCalendars>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(formatDate(DateTime.now(), [MM, ' ',yyyy]), style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: ['Min','Sen','Sel','Rab','Kam','Jum','Sab'].map((r) => Expanded(child:Container(
                      child: Center(child: Text(r, style: TextStyle(fontWeight: FontWeight.w800),)),
                    ))).toList()
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .45,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Theme.of(context).primaryColor)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: calendar.map((List i) => 
                        Expanded(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: i.map((r) => 
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.5, color: Theme.of(context).primaryColor),
                                    color: r!=null ? (DateFormat.d().format(_current).toString() == r.toString() ? Colors.green.shade200:Colors.transparent):Colors.grey.shade300
                                  ),
                                  child: r!=null ? Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 3.0,
                                        left: 3.0,
                                        child: Text(r.toString()),
                                      ),
                                      Center(
                                        child: 
                                        // Text(snapshot.data.indexWhere((date) => date.day == r.toString()).toString())
                                        snapshot.data.indexWhere((date) => date.day == r.toString()) > -1 ? (snapshot.data.indexWhere((date) => date.day == r.toString() && date.sucess == true) == true ? Icon(Icons.check, color: Theme.of(context).primaryColor) : Icon(Icons.close, color: Colors.red)) : null,
                                      )
                                    ],
                                  ):Container(),
                                )
                              )
                            ).toList(),
                          )
                        )
                      ).toList(),
                    ),
                  ),
                  // SizedBox(height: 25.0),
                  // Container(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Row(
                  //           mainAxisSize: MainAxisSize.max,
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Text('Energi : 0 kkal', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color:Colors.green, fontWeight: FontWeight.w600)),
                  //             Text('Protein : 0 gram', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color: Colors.green, fontWeight: FontWeight.w600)),
                  //           ],
                  //         ),
                  //         SizedBox(height: 10.0),
                  //         Row(
                  //           mainAxisSize: MainAxisSize.max,
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Text('Karbohidrat : 0 gram', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color: Colors.green, fontWeight: FontWeight.w600)),
                  //             Text('Lemak : 0 gram', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color: Colors.green, fontWeight: FontWeight.w600)),
                  //           ],
                  //         ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorPage(
                message: snapshot.error.toString(),
                buttonText: "Ulangi Lagi",
                onPressed: journalCalendarCtrl.getDataCalendars,
              ),
            );
          } return LoadingBlock(Theme.of(context).primaryColor);
        }
      ),
    );
  }
}