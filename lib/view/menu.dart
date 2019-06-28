import 'package:dietbetes/view/food_list/food_list_page.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final List foodType = ['Makan Pagi', 'Snack Pagi', 'Makan Siang', 'Snack Siang', 'Makan Malam', 'Snack Malam'];

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: foodType.length,
        itemBuilder: (BuildContext context, int index) {
          return RaisedButton(
            child: Text(foodType[index]),
            color: foodType[index].toString().contains('Snack') ? Colors.greenAccent.shade400 : Colors.green.shade400,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ListFoodPage(foodType[index])
                )
              );
            },
          );
        },
      ),
    );
  }
}