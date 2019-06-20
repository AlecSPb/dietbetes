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
      TextFormField(
        validator: validateRequired,
        onSaved: registerCtrl.updateName,
        decoration: InputDecoration(
          labelText: "Nama Lengkap",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
        ),
      ),
      TextFormField(
        validator: validateRequired,
        onSaved: registerCtrl.updateCallName,
        decoration: InputDecoration(
          labelText: "Nama Panggilan",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
        ),
      ),
      TextFormField(
        validator: validateEmail,
        onSaved: registerCtrl.updateEmail,
        decoration: InputDecoration(
          labelText: "Email",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
        ),
      ),
      TextFormField(
        validator: validatePassword,
        onSaved: registerCtrl.updatePassword,
        decoration: InputDecoration(
          labelText: "Kata Sandi",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
        ),
        obscureText: true,
      ),
      TextFormField(
        validator: validatePassword,
        onSaved: registerCtrl.updateConfPassword,
        decoration: InputDecoration(
          labelText: "Ulangi Kata Sandi",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
        ),
        obscureText: true,
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
        stream: registerCtrl.getPhysical,
        builder: (ctx, snapshoot) {
          return SizedBox(
            width: MediaQuery.of(context).size.width/2,
            child: DropdownButtonFormField(
              validator: (v) => validateRequired(v.toString()),
              onChanged: (val) => registerCtrl.updatePhysical(val),
              value: snapshoot.data,
              decoration: InputDecoration(
                labelText: "Aktifitas Fisik",
                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)
              ),
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text("Kondisi Istirahat (Bed Rest)"),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text("Ringan (Pegawai kantor, ibu rumah tangga)", overflow: TextOverflow.fade),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("Sedang (Pegawai industry, mahasiswa)", overflow: TextOverflow.fade),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("Berat (Petani, buruh, atlet, militer)", overflow: TextOverflow.fade),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text("Sangat Berat (Tukang gali, tukang becak)"),
                ),
              ],
            ),
          );
        },
      ),
      TextFormField(
        controller: _tinggi,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: (val) => registerCtrl.updateTinggi(int.parse(val)),
        decoration: InputDecoration(
          labelText: "Tinggi Badan (Cm)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
        ),
      ),
      TextFormField(
        controller: _berat,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: (val) => registerCtrl.updateBerat(int.parse(val)),
        decoration: InputDecoration(
          labelText: "Berat Badan (Kg)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
        ),
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
      TextFormField(
        controller: registerCtrl.gdp,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: registerCtrl.updateGula_puasa,
        decoration: InputDecoration(
          labelText: "Kadar gula darah puasa (mg/dL)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          suffix: StreamBuilder(
            stream: registerCtrl.get_gdp,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Text("");
              return Text(snapshot.data);
            }
          )
        ),
      ),
      TextFormField(
        controller: registerCtrl.gds,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: registerCtrl.updateGula_sewaktu,
        decoration: InputDecoration(
          labelText: "Kadar gula Darah sewaktu (mg/dL)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          suffix: StreamBuilder(
            stream: registerCtrl.get_gds,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Text("");
              return Text(snapshot.data);
            }
          )
        ),
      ),
      TextFormField(
        controller: registerCtrl.ttgo,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: registerCtrl.updateGula_makan,
        decoration: InputDecoration(
          labelText: "Kadar gula Darah 2 jam sesudah makan (mg/dL)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          suffix: StreamBuilder(
            stream: registerCtrl.get_ttgo,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Text("");
              return Text(snapshot.data);
            }
          )
        ),
      ),
      TextFormField(
        controller: registerCtrl.hb1ac,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: registerCtrl.updateHba1c,
        decoration: InputDecoration(
          labelText: "HbA1C (%)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          suffix: StreamBuilder(
            stream: registerCtrl.get_hb1ac,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Text("");
              return Text(snapshot.data);
            }
          )
        ),
      ),
      TextFormField(
        controller: registerCtrl.kol_total,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: registerCtrl.updateCholTotal,
        decoration: InputDecoration(
          labelText: "Total Kadar Kolesterol (mg/dL)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          suffix: StreamBuilder(
            stream: registerCtrl.get_kol_total,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Text("");
              return Text(snapshot.data);
            }
          )
        ),
      ),
      TextFormField(
        controller: registerCtrl.kol_hdl,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: registerCtrl.updateHdl,
        decoration: InputDecoration(
          labelText: "Kadar Kolesterol HDL (mg/dL)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          suffix: StreamBuilder(
            stream: registerCtrl.get_kol_hdl,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Text("");
              return Text(snapshot.data);
            }
          )
        ),
      ),
      TextFormField(
        controller: registerCtrl.kol_ldl,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: registerCtrl.updateLdl,
        decoration: InputDecoration(
          labelText: "Kadar Kolesterol LDL (mg/dL)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          suffix: StreamBuilder(
            stream: registerCtrl.get_kol_ldl,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Text("");
              return Text(snapshot.data);
            }
          )
        ),
      ),
      TextFormField(
        controller: registerCtrl.trigliserida,
        validator: validateRequiredNumber,
        keyboardType: TextInputType.number,
        onSaved: registerCtrl.updateTrigliserida,
        decoration: InputDecoration(
          labelText: "Kadar Trigliserida (mg/dL)",
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          suffix: StreamBuilder(
            stream: registerCtrl.get_trigliserida,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Text("");
              return Text(snapshot.data);
            }
          )
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: (MediaQuery.of(context).size.width/2),
            child: TextFormField(
              validator: validateRequiredNumber,
              keyboardType: TextInputType.number,
              onSaved: registerCtrl.update_tensi1,
              decoration: InputDecoration(
                labelText: "Tekanan Darah (mmHg)",
                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
              ),
            ),
          ),
          Text(" / ", style: TextStyle(fontSize: 30)),
          SizedBox(
            width: (MediaQuery.of(context).size.width/3),
            child: TextFormField(
              validator: validateRequiredNumber,
              keyboardType: TextInputType.number,
              onSaved: registerCtrl.update_tensi2,
              decoration: InputDecoration(
                labelText: "",
                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
              ),
            ),
          ),
        ],
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
              height: 60.0,
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
              height: 60.0,
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
            child: Text("Daftar", style: TextStyle(color: Colors.white, fontSize: 18.0)),
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