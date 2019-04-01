import 'package:dietbetes/view/food_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodDiary extends StatefulWidget {
  @override
  _FoodDiaryState createState() => _FoodDiaryState();
}

class _FoodDiaryState extends State<FoodDiary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Kebutuhan Hari ini', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                      Text('Energi : 1900 kkal', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Karbohidrat : 550 gram', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Protein : 50 gram', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Lemak : 25 gram', style: TextStyle(fontWeight: FontWeight.bold))
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
                      Text('Energi : 1600 kkal', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Karbohidrat : 450 gram', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Protein : 35 gram', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Lemak : 20 gram', style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ),
            ],
          ),
          MyListTile('Makan Pagi', ''),
          MyListTile('Snack Pagi', ''),
          MyListTile('Makan Siang', ''),
          MyListTile('Snack Siang', ''),
          MyListTile('Makan Malam', ''),
          MyListTile('Snack Malam', ''),
        ],
      ),
    );
  }
}


class MyListTile extends StatelessWidget {
  String title;
  String subTitle;

  MyListTile(@required this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.add_circle_outline, size: 30.0),
        onPressed: () async {
          String result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => FoodList()
            )
          );

          if (result != null) {
            title = result;
          }
        },
      ),
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }
}