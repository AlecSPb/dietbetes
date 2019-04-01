import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  TextEditingController controller = new TextEditingController();
  String filter;
  List<Widget> foodItem;
  List food;
  bool useRefresh = false;


  Future<void> getFood() async {

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      // setState(() {
      //   filter = controller.text;
      // });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food List"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
        child: Column(
          children: <Widget>[

            Card(
              child: ListTile(
                title: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      hintText: 'Search', border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: controller.text != '' ? IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          controller.clear();
                        }
                      ) : null
                  ),
                  onChanged: (val) => print(val),
                ),
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: getFood,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: RaisedButton(
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Text("Makanan $index", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context, 'Nutrisi Makanan $index');
                          },
                        ),
                      );
                    },
                  ),
                )
              )
            )
            
          ],
        ),
      ),
    );
  }
}