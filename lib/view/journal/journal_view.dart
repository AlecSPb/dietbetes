import 'package:dietbetes/models/journal_diet.dart';
import 'package:dietbetes/models/journal_list.dart';
import 'package:dietbetes/view/food_list.dart';
import 'package:dietbetes/view/journal/journal_add.dart';
import 'package:dietbetes/view/journal/journal_controller.dart';
import 'package:dietbetes/wigdet/loading.dart';
import 'package:flutter/material.dart';

class JournalFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: journalCtrl.getJournalList,
      builder: (ctx, AsyncSnapshot<List<JournalList>> snapshoot) {
        if (snapshoot.hasData) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Column(
              children: <Widget>[
                StreamBuilder(
                  stream: journalCtrl.getJournalData,
                  builder: (context, AsyncSnapshot<JournalDiet> snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Kebutuhan Hari ini', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                  Text('Energi : ${snapshot.data.requirement.calories.toString()} kkal', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Karbohidrat : ${snapshot.data.requirement.carbo.toString()} gram', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Protein : ${snapshot.data.requirement.protein.toString()} gram', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Lemak : ${snapshot.data.requirement.fat.toString()} gram', style: TextStyle(fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('TERSISA!', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                  Text('Energi : ${snapshot.data.result.calories.toString()} kkal', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Karbohidrat : ${snapshot.data.result.carbo.toStringAsFixed(2)} gram', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Protein : ${snapshot.data.result.protein.toStringAsFixed(2)} gram', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Lemak : ${snapshot.data.result.fat.toStringAsFixed(2)} gram', style: TextStyle(fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }
                ),
                SizedBox(height: 20.0),
                MyListTile(journalCtrl, 'Makan Pagi', 1, snapshoot.data.firstWhere((list) => list.schedule == 1, orElse: () => null)),
                MyListTile(journalCtrl, 'Snack Pagi', 2, snapshoot.data.firstWhere((list) => list.schedule == 2, orElse: () => null)),
                MyListTile(journalCtrl, 'Makan Siang', 3, snapshoot.data.firstWhere((list) => list.schedule == 3, orElse: () => null)),
                MyListTile(journalCtrl, 'Snack Siang', 4, snapshoot.data.firstWhere((list) => list.schedule == 4, orElse: () => null)),
                MyListTile(journalCtrl, 'Makan Malam', 5, snapshoot.data.firstWhere((list) => list.schedule == 5, orElse: () => null)),
                MyListTile(journalCtrl, 'Snack Malam', 6, snapshoot.data.firstWhere((list) => list.schedule == 6, orElse: () => null)),
              ],
            ),
          );
        } else if (snapshoot.hasError) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(snapshoot.error.toString()),
                SizedBox(height: 5.0),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Ulangi Lagi!"),
                  onPressed: journalCtrl.getJournal,
                )
              ],
            ),
          );
        } return LoadingBlock(Theme.of(context).primaryColor);
      }
    );
  }
}


class MyListTile extends StatelessWidget {
  JournalCtrl journalCtrl;
  String title;
  int schedule;
  JournalList data;

  MyListTile(@required this.journalCtrl, @required this.title, @required this.schedule ,this.data);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        disabledColor: Colors.black12,
        icon: Icon(Icons.add_circle_outline, size: 30.0),
        // data == null ? Icon(Icons.add_circle_outline, size: 30.0):Container(
        //   height: 25.0,
        //   width: 25.0,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(50.0),
        //     border: Border.all(width: 2.5, color: Colors.black45)
        //   ),
        //   child: Icon(Icons.edit, size: 15.0),
        // ),
        onPressed: data == null ? () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => JournalFoodData(schedule))) : null,
      ),
      title: Text(title),
      subtitle: data != null ? Text("${data.cal} kkal; ${data.carbo} gram karbo; ${data.protein} gram protein; ${data.fat} gram lemak;"):null,
    );
  }
}

