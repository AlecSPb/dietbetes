import 'package:dietbetes/util/bloc.dart';
import 'package:dietbetes/util/validator.dart';
import 'package:dietbetes/view/glucose/glucose_controller.dart';
import 'package:dietbetes/wigdet/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GlucosePage extends StatefulWidget {
  @override
  _GlucosePageState createState() => _GlucosePageState();
}

class _GlucosePageState extends State<GlucosePage> with ValidationMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  GlucoseCtrl glucoseCtrl;

  @override
  void initState() {
    glucoseCtrl = new GlucoseCtrl();
    super.initState();
  }

  @override
  void dispose() {
    glucoseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Kadar Gula Darah"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, "/glucose-graph"),
            tooltip: "Lihat Riwayat Saya",
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  StreamBuilder(
                    stream: glucoseCtrl.getDate,
                    builder: (ctx, snapshoot) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.7)
                          )
                        ),
                        height: 50.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 11.0),
                                child: snapshoot.data != null ? Text(snapshoot.data) : Text('Tanggal Pemeriksaan', style: TextStyle(color: Colors.black54, fontSize: 16.0)),
                              )
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: InkWell(
                                child: Icon(FontAwesomeIcons.calendar, size: 30.0, color: Colors.green),
                                onTap: () => glucoseCtrl.datePicker(context),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: glucoseCtrl.getGDP,
                    builder: (context, snapshot) {
                      return TextFormField(
                        validator: validateRequired,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Kadar Gula Darah Puasa (GDP)",
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          suffixText: "mmHg"
                        ),
                        onSaved: glucoseCtrl.updateGDP,
                      );
                    }
                  ),
                  StreamBuilder(
                    stream: glucoseCtrl.getGDS,
                    builder: (context, snapshot) {
                      return TextFormField(
                        validator: validateRequired,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Kadar Gula Darah Sewaktu (GDS)",
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          suffixText: "mmHg"
                        ),
                        onSaved: glucoseCtrl.updateGDS,
                      );
                    }
                  ),
                  StreamBuilder(
                    stream: glucoseCtrl.getHbA1C,
                    builder: (context, snapshot) {
                      return TextFormField(
                        validator: validateRequired,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "HbA1c",
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          suffixText: "%"
                        ),
                        onSaved: glucoseCtrl.updateHbA1C,
                      );
                    }
                  ),
                  StreamBuilder(
                    stream: glucoseCtrl.getTTGO,
                    builder: (context, snapshot) {
                      return TextFormField(
                        validator: validateRequired,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Toleransi Glukosa Oral (TTGO)",
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          suffixText: "mmHg"
                        ),
                        onSaved: glucoseCtrl.updateTTGO,
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: glucoseCtrl.getLoading,
            builder: (context, snapshot) {
              return Loading(snapshot.data == true);
            }
          )
        ],
      ),
      floatingActionButton: StreamBuilder(
        stream: glucoseCtrl.getLoading,
        builder: (context, snapshot) {
          if (snapshot.data != true) {
            return FloatingActionButton.extended(
              onPressed: () => glucoseCtrl.saveGlucose(formKey),
              icon: Icon(Icons.save, color: Colors.white,),
              label: new Text('SIMPAN DATA'),
            );
          }return Container();
        }
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
    );
  }
}