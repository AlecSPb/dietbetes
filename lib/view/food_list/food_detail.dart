import 'package:flutter/material.dart';

class FoodDetail extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(),
    );
  }
}