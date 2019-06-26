// Core
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dietbetes/util/data.dart';
import 'package:dietbetes/view/alarm/alarm_add_view.dart';
import 'package:dietbetes/view/alarm/alarm_view.dart';
import 'package:dietbetes/view/help/help_view.dart';
import 'package:dietbetes/view/menu.dart';
import 'package:dietbetes/view/sport.dart';

import 'package:flutter/material.dart';

// Plugin
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pigment/pigment.dart';

// Page
import 'package:dietbetes/view/journal/journal_view.dart';
import 'package:dietbetes/view/dashboard/dashboard_view.dart';
import 'package:dietbetes/view/home/home_controller.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();
class HomePage extends StatelessWidget {
  _getDrawerItemWidget(pos) {
    switch (pos) {
      case 0:
        return new DashboardPage();
      case 1:
        return new JournalFood();
      case 2:
        return new Sport();
      case 3:
        return new Menu();
      case 4:
        return new AlarmPage();
      case 5:
        return new HelpPage();
      default:
        return new DashboardPage();
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: StreamBuilder(
          stream: homeCtrl.title,
          builder: (ctx, snapshoot) => Text(snapshoot.data != null ? snapshoot.data:""),
        ),
        actions: <Widget>[
          StreamBuilder(
            stream: homeCtrl.selectedDrawerIndex,
            builder: (ctx, snapshoot) {
              if (snapshoot.hasData) {
                if (snapshoot.data == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.calendar),
                      tooltip: 'Liat Kalendar',
                      onPressed: () => Navigator.pushNamed(context, "/journal-calendar"),
                      // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarScreen()))
                    ),
                  );
                }
              }
              return Container();
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Pigment.fromString("#BFEB9E")
          ),
          padding: EdgeInsets.fromLTRB(10, 45, 10, 0),
          child: ListView(
            children: <Widget>[
              InkWell(
                onTap: () => homeCtrl.openProfile(context),
                child: DrawerHeader(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Semantics(
                        excludeSemantics: true,
                        child: SizedBox(
                          width: 72.0,
                          height: 72.0,
                          child: CircularProfileAvatar(
                            "http://i.pravatar.cc/300",
                            initialsText: Text("R", style: TextStyle(fontSize: 40, color: Colors.white)),
                            elevation: 5.0,
                            borderWidth: 0.5,
                            borderColor: Colors.green.shade800,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            StreamBuilder<String>(
                              stream: homeCtrl.name,
                              builder: (context, snapshot) {
                                return Text("Halo, ${snapshot.data}", style: TextStyle(fontSize: 22));
                              }
                            ),
                            StreamBuilder<String>(
                              stream: homeCtrl.status,
                              builder: (context, snapshot) {
                                return Text("Status Anda : ${snapshot.data}", style: TextStyle(color: homeCtrl.getColors(snapshot.data)));
                              }
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () => homeCtrl.onSelectItem(context, 0),
                selected: false,
                leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red,
                  ),
                  child: Icon(Icons.home, color: Colors.white, size: 25.0),
                ),
                title: Text("Dashboard"),
              ),
              Divider(height: 1),
              ListTile(
                onTap: () => homeCtrl.onSelectItem(context, 1),
                selected: false,
                leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red,
                  ),
                  child: Icon(FontAwesomeIcons.bookOpen, color: Colors.white, size: 20.0),
                ),
                title: Text("Jurnal Makanan"),
              ),
              Divider(height: 1),
              ListTile(
                onTap: () => homeCtrl.onSelectItem(context, 2),
                selected: false,
                leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red,
                  ),
                  child: Icon(FontAwesomeIcons.dumbbell, color: Colors.white, size: 20.0),
                ),
                title: Text("Aktifitas Fisik"),
              ),
              Divider(height: 1),
              ListTile(
                onTap: () => homeCtrl.onSelectItem(context, 3),
                selected: false,
                leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red,
                  ),
                  child: Icon(FontAwesomeIcons.utensils, color: Colors.white, size: 20.0),
                ),
                title: Text("Menu Hari ini"),
              ),
              Divider(height: 1),
              ListTile(
                onTap: () => homeCtrl.onSelectItem(context, 4),
                selected: false,
                leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red,
                  ),
                  child: Icon(FontAwesomeIcons.bell, color: Colors.white, size: 20.0),
                ),
                title: Text("Alarm"),
              ),
              Divider(height: 1),
              ListTile(
                onTap: () => homeCtrl.onSelectItem(context, 5),
                selected: false,
                leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red,
                  ),
                  child: Icon(FontAwesomeIcons.phone, color: Colors.white, size: 20.0),
                ),
                title: Text("Bantuan"),
              ),
              Divider(height: 1),
              ListTile(
                onTap: () => homeCtrl.logout(context),
                selected: false,
                leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red,
                  ),
                  child: Icon(Icons.exit_to_app, color: Colors.white, size: 20.0),
                ),
                title: Text("Keluar"),
              ),
              Divider(height: 1),
            ],
          ),
        )
      ),
      resizeToAvoidBottomPadding: false,
      // body: _getDrawerItemWidget(_selectedDrawerIndex),
      body: StreamBuilder(
        initialData: 0,
        stream: homeCtrl.selectedDrawerIndex,
        builder: (ctx, snapshoot) => _getDrawerItemWidget(snapshoot.data),
      ),
    );
  }
}