import 'package:dietbetes/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FoodDetail extends StatelessWidget {
  Menu data;
  FoodDetail(this.data);

  
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            HtmlWidget(data.ingredients),
            SizedBox(height: 5),
            HtmlWidget(data.tutorial),
          ]
        )
      ),
    );
  }
}