import 'dart:async';
import 'package:dietbetes/view/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dietbetes/wigdet/loading.dart';
import 'package:dietbetes/util/validator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with ValidationMixin {
  final _formLogin = GlobalKey<FormState>();
  TextEditingController _tinggi = new TextEditingController();
  TextEditingController _berat = new TextEditingController();
  List<Widget> _registerForm = [];
  RegisterCtrl registerCtrl;

  @override
  void initState() {
    registerCtrl = new RegisterCtrl();
    _tinggi.addListener(() => registerCtrl.onChange(tinggi: _tinggi, berat: _berat));
    _berat.addListener(() => registerCtrl.onChange(tinggi: _tinggi, berat: _berat));
    super.initState();
  }

  @override
  void dispose() {
    registerCtrl.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    _registerForm = [
      StreamBuilder(
        stream: registerCtrl.getName,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequired,
            onSaved: registerCtrl.updateName,
            decoration: InputDecoration(
              labelText: "Nama Lengkap",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getCallName,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequired,
            onSaved: registerCtrl.updateCallName,
            decoration: InputDecoration(
              labelText: "Nama Panggilan",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getEmail,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateEmail,
            onSaved: registerCtrl.updateEmail,
            decoration: InputDecoration(
              labelText: "Email",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getPassword,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequired,
            onSaved: registerCtrl.updatePassword,
            decoration: InputDecoration(
              labelText: "Kata Sandi",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        }
      ),
      StreamBuilder(
        stream: registerCtrl.getConfPassword,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequired,
            onSaved: registerCtrl.updateConfPassword,
            decoration: InputDecoration(
              labelText: "Ulangi Kata Sandi",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        }
      ),
      StreamBuilder(
        stream: registerCtrl.getGender,
        builder: (ctx, snapshoot) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.7)
              )
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: RadioListTile(
                    value: 1,
                    title: Text('Laki-laki', style: TextStyle(fontSize: 14.0)),
                    groupValue: snapshoot.data,
                    onChanged: (v) {
                      registerCtrl.updateGender(v);

                    },
                  )
                ),
                Expanded(
                  child: RadioListTile(
                    value: 0,
                    title: Text('Perempuan', style: TextStyle(fontSize: 14.0)),
                    groupValue: snapshoot.data,
                    onChanged: (v) {
                      registerCtrl.updateGender(v);
                      registerCtrl.onChange(tinggi: _tinggi, berat: _berat);
                    },
                  )
                ),
              ],
            ),
          );
        }
      ),
      StreamBuilder(
        stream: registerCtrl.getBirthdate,
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
                    child: snapshoot.data != null ? Text(snapshoot.data) : Text('Tanggal Lahir', style: TextStyle(color: Colors.black54, fontSize: 16.0)),
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: InkWell(
                    child: Icon(FontAwesomeIcons.calendar, size: 30.0, color: Colors.green),
                    onTap: () => registerCtrl.datePicker(context),
                  ),
                )
              ],
            ),
          );
        },
      ),
      StreamBuilder(
        initialData: 0,
        stream: registerCtrl.getHistory,
        builder: (ctx, snapshoot) {
          return DropdownButtonFormField(
            validator: (v) => validateRequired(v.toString()),
            onChanged: (val) => registerCtrl.updatehistory(val),
            value: snapshoot.data,
            decoration: InputDecoration(
              labelText: "Aktifitas Fisik",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            ),
            items: [
              DropdownMenuItem(
                value: 0,
                child: Text("Kondisi Istirahat (Bed Rest)"),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text("Ringan"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("Sedang"),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("Berat"),
              ),
              DropdownMenuItem(
                value: 4,
                child: Text("Sangat Berat"),
              ),
            ],
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getTinggi,
        builder: (ctx, snapshoot) {
          return TextFormField(
            controller: _tinggi,
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: (val) => registerCtrl.updateTinggi(int.parse(val)),
            decoration: InputDecoration(
              labelText: "Tinggi Badan (Cm)",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getBerat,
        builder: (ctx, snapshoot) {
          return TextFormField(
            controller: _berat,
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: (val) => registerCtrl.updateBerat(int.parse(val)),
            decoration: InputDecoration(
              labelText: "Berat Badan (Kg)",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getIdealWeight,
        builder: (ctx, snapshoot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.7)
              )
            ),
            height: 55.0,
            child: snapshoot.data != null && snapshoot.data > 0 ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Berat Badan Ideal', style: TextStyle(color: Colors.black54, fontSize: 12.0)),
                Text(snapshoot.data.toString(), style: TextStyle(fontSize: 16.0))
              ],
            ) : Text('Berat Badan Ideal', style: TextStyle(color: Colors.black54, fontSize: 16.0))
          );    
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getIbm,
        builder: (ctx, snapshoot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.7)
              )
            ),
            height: 55.0,
            child: snapshoot.data != null && snapshoot.data > 0 ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Index Masa Tubuh', style: TextStyle(color: Colors.black54, fontSize: 12.0)),
                    Text(snapshoot.data.toString(), style: TextStyle(fontSize: 16.0))
                  ],
                ),
                StreamBuilder(
                  stream: registerCtrl.getStatusGizi,
                  builder: (ctx, snapshoot) => Text(snapshoot.hasData ? snapshoot.data : "", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                )
              ],
            ) : Text('Index Masa Tubuh', style: TextStyle(color: Colors.black54, fontSize: 16.0))
          );    
        },
      ),
      StreamBuilder(
        initialData: 0,
        stream: registerCtrl.getHistory,
        builder: (ctx, snapshoot) {
          return DropdownButtonFormField(
            validator: (v) => validateRequired(v.toString()),
            onChanged: (val) => registerCtrl.updatehistory(val),
            value: snapshoot.data,
            decoration: InputDecoration(
              labelText: "Riwayat Keluarga",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            ),
            items: [
              DropdownMenuItem(
                value: 0,
                child: Text("Tidak ada"),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text("Ayah"),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text("Ibu"),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text("Kakek"),
              ),
              DropdownMenuItem(
                value: 4,
                child: Text("Nenek"),
              ),
            ],
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getGula_puasa,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: registerCtrl.updateGula_puasa,
            decoration: InputDecoration(
              labelText: "Kadar gula darah puasa",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getGula_sewaktu,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: registerCtrl.updateGula_sewaktu,
            decoration: InputDecoration(
              labelText: "Kadar gula Darah sewaktu",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getGula_makan,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: registerCtrl.updateGula_makan,
            decoration: InputDecoration(
              labelText: "Kadar gula Darah 2 jam sesudah makan",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getHba1c,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: registerCtrl.updateHba1c,
            decoration: InputDecoration(
              labelText: "HbA1C",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getTotalChol,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: registerCtrl.updateCholTotal,
            decoration: InputDecoration(
              labelText: "Total Kadar Kolesterol",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getHdl,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: registerCtrl.updateHdl,
            decoration: InputDecoration(
              labelText: "Kadar Kolesterol HDL",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getLdl,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: registerCtrl.updateLdl,
            decoration: InputDecoration(
              labelText: "Kadar Kolesterol LDL",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getTrigliserida,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: registerCtrl.updateTrigliserida,
            decoration: InputDecoration(
              labelText: "Kadar Trigliserida",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getlast_tensi,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateRequiredNumber,
            keyboardType: TextInputType.number,
            onSaved: registerCtrl.updatelast_tensi,
            decoration: InputDecoration(
              labelText: "Tekanan Darah Terakhir",
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getGejala_klinis,
        builder: (ctx, snapshoot) {
          return InkWell(
            onTap: () => registerCtrl.dialogKlinis(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: snapshoot.hasData && snapshoot.data != "" ? 10.0:20.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.7)
                )
              ),
              height: 55.0,
              child: snapshoot.hasData && snapshoot.data != "" ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Gejala Klinis yang dirasakan', style: TextStyle(color: Colors.black54, fontSize: 12.0)),
                  Text(snapshoot.data, style: TextStyle(fontSize: 16.0))
                ],
              ) : Text('Gejala Klinis yang dirasakan', style: TextStyle(color: Colors.black54, fontSize: 16.0))
            ),
          );    
        },
      ),
      StreamBuilder(
        stream: registerCtrl.getObat,
        builder: (ctx, snapshoot) {
          return InkWell(
            onTap: () => registerCtrl.dialogObat(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: snapshoot.hasData && snapshoot.data != "" ? 10.0:20.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.7)
                )
              ),
              height: 55.0,
              child: snapshoot.hasData && snapshoot.data != "" ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Obat yang sedang di konsumsi', style: TextStyle(color: Colors.black54, fontSize: 12.0)),
                  Text(snapshoot.data, style: TextStyle(fontSize: 16.0))
                ],
              ) : Text('Obat yang sedang di konsumsi', style: TextStyle(color: Colors.black54, fontSize: 16.0))
            ),
          );    
        },
      ),
      
      SizedBox(height: 8.0),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          shadowColor: Colors.greenAccent.shade100,
          child: MaterialButton(
            elevation: 3.0,
            minWidth: 200.0,
            height: 45.0,
            onPressed: () => registerCtrl.submitData(_formLogin),
            color: Colors.green,
            child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dietbetes - Pendaftaran"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Stack(
        children: <Widget>[
            Center(
              child: ListView(
                children: <Widget>[
                  Form(
                    key: _formLogin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _registerForm,
                    )
                  )
                ],
              ),
            ),
            StreamBuilder(
              initialData: false,
              stream: registerCtrl.getLoading,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return Loading(snapshot.data);
              },
            )
          ],
        )
      ),
    );
  }
}