import 'package:dietbetes/models/fat_secret_foods.dart';
import 'package:dietbetes/view/journal/journal_add_controller.dart';
import 'package:dietbetes/wigdet/error_page.dart';
import 'package:dietbetes/wigdet/loading.dart';
import 'package:flutter/material.dart';

class JournalFoodData extends StatefulWidget {
  int schedule;
  JournalFoodData(@required this.schedule);

  @override
  _JournalFoodDataState createState() => _JournalFoodDataState();
}

class _JournalFoodDataState extends State<JournalFoodData> {
  final key = GlobalKey<ScaffoldState>();
  JournalAddCtrl journalAddCtrl;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    journalAddCtrl = JournalAddCtrl();
    super.initState();
  }

  @override
  void dispose() {
    journalAddCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Daftar Makanan"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Card(
                  child: ListTile(
                    title: StreamBuilder(
                      stream: journalAddCtrl.getSreach,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _controller,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: 'Search', border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: snapshot.hasData ? IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                journalAddCtrl.updateSearch(null);
                                _controller.clear();
                              }
                            ):null
                          ),
                          onChanged: journalAddCtrl.updateSearch,
                          onSubmitted: (v) => journalAddCtrl.searchFoods(context),
                        );
                      }
                    ),
                  ),
                ),

                Expanded(
                  child: StreamBuilder(
                    stream: journalAddCtrl.getFoodList,
                    builder: (context, AsyncSnapshot<FatSecretFoods> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => const Divider(height: 2.0),
                            itemCount: snapshot.data.food.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(snapshot.data.food[index].foodName),
                                subtitle: Text(snapshot.data.food[index].foodDescription),
                                trailing: IconButton(
                                  icon: Icon(Icons.add_circle_outline, color: Theme.of(context).primaryColor),
                                  onPressed: () => journalAddCtrl.onSelect(context, widget.schedule, snapshot.data.food[index])
                                ),
                              );
                            },
                          )
                        );
                      } else if (snapshot.hasError) {
                        return ErrorPage(
                          message: snapshot.error.toString(),
                          buttonText: "Ulangi Lagi",
                          onPressed: () => journalAddCtrl.searchFoods(context),
                        );
                      } return StreamBuilder(
                        stream: journalAddCtrl.getSearchData,
                        builder: (context, snapshot) {
                          if (snapshot.data == true) {
                            return LoadingBlock(Theme.of(context).primaryColor);
                          } else {
                            return Center(
                              child: Text("Silakan Cari Makanan Anda.", style: TextStyle(color: Colors.black38)),
                            );
                          }
                        }
                      );
                    }
                  ),
                )
                
              ],
            ),
          ),
          StreamBuilder(
            initialData: false,
            stream: journalAddCtrl.getLoading,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return Loading(snapshot.data);
            }
          )
        ],
      )
    );
  }
}