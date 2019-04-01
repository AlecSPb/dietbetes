import 'package:dietbetes/view/food_detail.dart';
import 'package:flutter/material.dart';

class FoodListDetail extends StatefulWidget {
  String title;
  FoodListDetail(this.title);

  @override
  _FoodListDetailState createState() => _FoodListDetailState();
}

class _FoodListDetailState extends State<FoodListDetail> {
  @override
  Widget build(BuildContext context) {
    List foodList = ['1. Fruit Oatmeal', '2. Vegetables Sandwich', '3. Omelete Sayur'];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: foodList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Text(foodList[index])
              ),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => DetailFood()
                  )
                );
              },
            );
          },
        ),
      )
    );
  }
}