import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact US"),
      ),
      body: Container(
        child: Center(
          child: Text("TOLONG BUATKAN DESIGN UNTUK HALAMAN INI"),
        ),
      ),
    );
  }
}