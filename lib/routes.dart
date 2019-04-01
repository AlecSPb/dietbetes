import 'package:dietbetes/view/glucose/glucose_graph.dart';
import 'package:dietbetes/view/glucose/glucose_view.dart';
import 'package:dietbetes/view/journal/journal_calendar.dart';
import 'package:flutter/material.dart';

import 'package:dietbetes/view/home/home_view.dart';
import 'package:dietbetes/view/login/login_view.dart';
import 'package:dietbetes/view/profile/profile_view.dart';
import 'package:dietbetes/view/register/register_view.dart';
import 'package:dietbetes/view/food_detail.dart';
import 'package:dietbetes/view/food_list.dart';
import 'package:dietbetes/view/menu.dart';


final routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/journal-calendar': (BuildContext context) => new JournalCalendar(),
  '/menu': (BuildContext context) => new Menu(),
  '/food-list': (BuildContext context) => new FoodList(),
  '/food-detail': (BuildContext context) => new DetailFood(),
  '/profile': (BuildContext context) => new ProfilePage(),
  '/glucose-update' : (BuildContext context) => new GlucosePage(),
  '/glucose-graph' : (BuildContext context) => new GlucoseGraph(),
  
};