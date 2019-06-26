import 'dart:math';

import 'package:dietbetes/models/user.dart';
import 'package:dietbetes/util/session.dart';
import 'package:dietbetes/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Sport extends StatefulWidget {
  @override
  _SportState createState() => _SportState();
}

class _SportState extends State<Sport> with ValidationMixin{
  final TextEditingController _inputCtrl = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _agreement = false;
  bool _checkAgree = false;
  bool _process = false;
  bool _approved = false;
  num _data = 0;

  void calculate() async {
    User userData = await sessions.loadUser();
    DateTime now = new DateTime.now();
    
    if (_form.currentState.validate()) {
      _form.currentState.save();
      print('data : $_data & $_process');
      setState(() {
        if (_data > 1 && _process == false) {
          _approved = _data < (220 - (now.difference(DateTime.parse(userData.userDetail.dob)).inDays/360).floor()) ? true : false;
          _process = true;
        }else{
          _form.currentState.reset();
          _data = 0;
          _process = false;
        }
      });
    }
  }

  openYutube() async {
    int i;
    var rndnumber="";
    var rnd= new Random();
    for (var i = 1; i < 2; i++) {
    rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    
    if (int.parse(rndnumber) > 5) {
      rndnumber = (int.parse(rndnumber) / 2).round().toString();
      i = num.parse(rndnumber);
    }
    
    List<String> ulrs = [
      'https://youtu.be/r6xkOlyKogM',
      'https://youtu.be/03Ar9vo6VbM',
      'https://youtu.be/GanQwAZSiiw',
      'https://youtu.be/Sr8jxxI7oB8',
      'https://youtu.be/w52tejxITW4'
    ];
    // const url = 'https://youtu.be/03Ar9vo6VbM';
    if (await canLaunch(ulrs[i])) {
      await launch(ulrs[i]);
    } else {
      throw 'Could not open youtube!';
    }
  }

  Widget sportTile(String data) {
    return ListTile(
      leading: Container(
        height: 10.0,
        width: 10.0,
        decoration: new BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('render');
    if (this._agreement == false) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 140,
              child: ListView(
                children: <Widget>[
                  ExpansionTile(
                    title: Text("AYO MULAI!"),
                    children: <Widget>[
                      sportTile("Olahraga yang cocok untuk mu adalah olahraga yang kamu sukai. Jangan pernah lakukan olahraga yang tidak kamu sukai walaupun itu di rekomendasikan, karena olahraga yang baik adalah olahraga yang bersifat berkelanjutan."),
                      sportTile("Namun, jangan pilih olahraga yang beresiko tinggi atau beresiko tinggi mengalami cedera."),
                      sportTile("Jangan lupa untuk mengecek kadar gula darah mu sebelum memulai olahraga!"),
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Kapan waktu olahraga yang tepat?"),
                    children: <Widget>[
                      sportTile("Waktu yang tepat dapat disesuaikan dengan jadwal dan kondisi kesibukan sehari-hari."),
                      sportTile("Disesuaikan dengan dosis insulin dan jam makan agar tidak terjadi hipoglikemia/hiperglikemia saat berolahraga."),
                      sportTile("JAkan lebih baik untuk menjadwalkan jam yang sama untuk melakukan olahraga setiap harinya sehingga dapat mengatur jadwal dosis insulin dan makan agar sesuai dengan jadwal olahraga."),
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Bagaimana cara memulai olahraganya?"),
                    children: <Widget>[
                      sportTile("Mulailah secara perlahan dan dengan intensitas rendah terlebih dahulu dan secara bertahap.")
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Seberapa sering olahraga yang dianjurkan?"),
                    children: <Widget>[
                      sportTile("30 menit olahraga aerobic, 5x seminggu sudah sangat ideal!")
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 5.0, 10.0, 5.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: this._checkAgree,
                    onChanged: (v) => setState(() => this._checkAgree = v),
                  ),
                  Expanded(child: Text("Saya sudah tahu dan siap berolahraga!")),
                  RaisedButton(
                    child: Text("Selanjutnya", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                    onPressed: this._checkAgree ? () => setState(() => this._agreement = true):null,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            )
          ],
        )
      );   
    }else{
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.yellow
              ),
              child: Center(child: Text('PERHATIKAN !', style: TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold))),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.yellow
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: '1. Apabila kadar glukosa darah lebih dari 250 mg/dl'),
                        TextSpan(text: ' TIDAK DISARANKAN ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        TextSpan(text: 'UNTUK BEROLAHRAGA'),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text('2. Olahraga sebaiknya dilakukan secara teratur 3-5x per minggu'),
                  SizedBox(height: 3.0),
                  Text('3. Denyut jantung maksimal harus diperhatikan sesuai kategori usia'),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent
              ),
              child: Column(
                children: <Widget>[
                  Center(child: Text('Cek dulu sebelum mulai !', style: TextStyle(fontSize: 18.0))),
                  Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _inputCtrl,
                          validator: validateRequiredNumber,
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.number,
                          onSaved: (val) => setState(() => _data = num.parse(val)),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'Kadar gula darah sewaktu (mg/dl)',
                            // labelStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                          ),
                        ),
                        SizedBox(height: 15.0),
                        RaisedButton(
                          child: (!this._process) ? Text("Calculate !") : Text("Reset"),
                          onPressed: this.calculate,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
              this._process == true ? Container(
                width: double.infinity,
                height: 50.0,
                child: (this._approved) ?
                  Text('status anda adalah HIPERGLIKEMI. konsumsi insulin untuk mengatur kadar gula darah anda. Berolahraga dapat beresiko untuk anda jika kadar gula darah anda tinggi, jaga pola makan dan tetap jaga pola hidup sehat!', textAlign: TextAlign.center, style: TextStyle(color: Colors.red))
                  : RaisedButton(
                    child: Text("Open Youtube"),
                    onPressed: this.openYutube,
                  )
            ) : Container()
          ],
        )
      );
    }
  }
}