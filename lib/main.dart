import 'dart:io';
import 'package:dietbetes/routes.dart';
import 'package:dietbetes/util/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

 // for desktop embedder
// import 'package:flutter/foundation.dart'
// show debugDefaultTargetPlatformOverride;

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.green.shade800
  ));
  return runApp(new DietbetesApp());
}

class DietbetesApp extends StatelessWidget {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void firebaseCloudMessaging_Listeners() {
  if (Platform.isIOS) iOS_Permission();

  // _firebaseMessaging.getToken().then((token){
  //   print("token: $token");
  // });

  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
    },
    onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
    },
    onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
    },
  );
}

void iOS_Permission() {
  _firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true)
  );
  _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings)
  {
    print("Settings registered: $settings");
  });
}

  @override
  Widget build(BuildContext context) {
    firebaseCloudMessaging_Listeners();
    // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia; // for desktop embedder
    return new MaterialApp(
      title: Static.APP_NAME,
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: routes,
    );
  }
}