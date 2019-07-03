import 'dart:async';

import 'package:dietbetes/models/menu.dart';
import 'package:dietbetes/view/food_detail.dart';
import 'package:dietbetes/view/food_list/food_detail.dart';
import 'package:dietbetes/view/food_list/food_list_controller.dart';
import 'package:dietbetes/wigdet/error_page.dart';
import 'package:dietbetes/wigdet/loading.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ListFoodPage extends StatefulWidget {
  String title;
  ListFoodPage(this.title);

  @override
  _ListFoodPageState createState() => _ListFoodPageState();
}

class _ListFoodPageState extends State<ListFoodPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FoodListCtrl foodListCtrl;
  num space;
  

  // List foodList = ['1. Fruit Oatmeal', '2. Vegetables Sandwich', '3. Omelete Sayur'];

  @override
  void initState() {
    space = widget.title.indexOf(" ");
    foodListCtrl = new FoodListCtrl();
    foodListCtrl.getList("${widget.title.substring(0, 1)}${widget.title.substring(space+1, space+2)}");
    super.initState();
  }

  @override
  void dispose() {
    foodListCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: foodListCtrl.getListMenu,
        builder: (context, AsyncSnapshot<List<Menu>> snapshot) {
          if (snapshot.hasData) {
            return LiquidPullToRefresh(
              key: _refreshIndicatorKey,
              onRefresh: () => foodListCtrl.getList("${widget.title.substring(0, 1)}${widget.title.substring(space+1, space+2)}"),
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      child: Text(snapshot.data[index].title)
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => FoodDetail(snapshot.data[index])
                        )
                      );
                    },
                  );
                },
              ),
            );
          }else if(snapshot.hasError) {
            return ErrorPage(
              message: snapshot.error.toString(),
              buttonText: "Ulangi Lagi",
              onPressed: () {
                foodListCtrl.updateListMenu(null);
                foodListCtrl.getList("${widget.title.substring(0, 1)}${widget.title.substring(space+1, space+2)}");
              },
            );
          }return LoadingBlock(Theme.of(context).primaryColor);
        }
      )
    );
  }
}