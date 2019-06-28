import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ListFoodPage extends StatefulWidget {
  @override
  _ListFoodPageState createState() => _ListFoodPageState();
}

class _ListFoodPageState extends State<ListFoodPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final List foodType = ['Makan Pagi', 'Snack Pagi', 'Makan Siang', 'Snack Siang', 'Makan Malam', 'Snack Malam'];
  Future<void> _handleRefresh() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,	// refresh callback
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }
}