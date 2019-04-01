import 'package:dietbetes/util/validator.dart';
import 'package:dietbetes/view/sport/sport_controller.dart';
import 'package:flutter/material.dart';
class Sport extends StatefulWidget {
  @override
  _SportState createState() => _SportState();
}

class _SportState extends State<Sport> with ValidationMixin{
  final _form = GlobalKey<FormState>();
  SportCtrl sportCtrl;

  @override
  void initState() {
    sportCtrl = new SportCtrl();
    super.initState();
  }

  @override
  void dispose() {
    sportCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: false,
      stream: sportCtrl.getAgreement,
      builder: (ctx, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == false) {
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
                          ListSport("Olahraga yang cocok untuk mu adalah olahraga yang kamu sukai. Jangan pernah lakukan olahraga yang tidak kamu sukai walaupun itu di rekomendasikan, karena olahraga yang baik adalah olahraga yang bersifat berkelanjutan."),
                          ListSport("Namun, jangan pilih olahraga yang beresiko tinggi atau beresiko tinggi mengalami cedera."),
                          ListSport("Jangan lupa untuk mengecek kadar gula darah mu sebelum memulai olahraga!"),
                        ],
                      ),
                      ExpansionTile(
                        title: Text("Kapan waktu olahraga yang tepat?"),
                        children: <Widget>[
                          ListSport("Waktu yang tepat dapat disesuaikan dengan jadwal dan kondisi kesibukan sehari-hari."),
                          ListSport("Disesuaikan dengan dosis insulin dan jam makan agar tidak terjadi hipoglikemia/hiperglikemia saat berolahraga."),
                          ListSport("JAkan lebih baik untuk menjadwalkan jam yang sama untuk melakukan olahraga setiap harinya sehingga dapat mengatur jadwal dosis insulin dan makan agar sesuai dengan jadwal olahraga."),
                        ],
                      ),
                      ExpansionTile(
                        title: Text("Bagaimana cara memulai olahraganya?"),
                        children: <Widget>[
                          ListSport("Mulailah secara perlahan dan dengan intensitas rendah terlebih dahulu dan secara bertahap.")
                        ],
                      ),
                      ExpansionTile(
                        title: Text("Seberapa sering olahraga yang dianjurkan?"),
                        children: <Widget>[
                          ListSport("30 menit olahraga aerobic, 5x seminggu sudah sangat ideal!")
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5.0, 10.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      StreamBuilder(
                        initialData: false,
                        stream: sportCtrl.getChecked,
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          return Checkbox(
                            value: snapshot.data,
                            onChanged: sportCtrl.updateChecked,
                          );
                        }
                      ),
                      Expanded(child: Text("Saya sudah tahu dan siap berolahraga!")),
                      StreamBuilder(
                        initialData: false,
                        stream: sportCtrl.getChecked,
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          return RaisedButton(
                            child: Text("Selanjutnya", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                            onPressed: snapshot.data ? () => sportCtrl.updateAgreement(true):null,
                            color: Theme.of(context).primaryColor,
                          );
                        }
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
                            StreamBuilder(
                              stream: sportCtrl.getData,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  validator: validateRequiredNumber,
                                  textInputAction: TextInputAction.go,
                                  keyboardType: TextInputType.number,
                                  onSaved: (val) => sportCtrl.updateData(num.parse(val)),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    labelText: 'Kadar gula darah sewaktu (mg/dl)',
                                    // labelStyle: TextStyle(color: Colors.white),
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                                  ),
                                );
                              }
                            ),
                            SizedBox(height: 15.0),
                            StreamBuilder(
                              initialData: false,
                              stream: sportCtrl.getProcessed,
                              builder: (context, AsyncSnapshot<bool> snapshot) {
                                return RaisedButton(
                                  child: !snapshot.data ? Text("Calculate !") : Text("Reset"),
                                  onPressed: () => sportCtrl.calculate(this._form),
                                );
                              }
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                StreamBuilder(
                  initialData: false,
                  stream: sportCtrl.getProcessed,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.data) {
                      return Container(
                        width: double.infinity,
                        height: 50.0,
                        child: StreamBuilder(
                          initialData: false,
                          stream: sportCtrl.getApproved,
                          builder: (context, AsyncSnapshot<bool> snapshoot) {
                            if (snapshoot.data) {
                              return Text('status anda adalah HIPERGLIKEMI. konsumsi insulin untuk mengatur kadar gula darah anda. Berolahraga dapat beresiko untuk anda jika kadar gula darah anda tinggi, jaga pola makan dan tetap jaga pola hidup sehat!', textAlign: TextAlign.center, style: TextStyle(color: Colors.red));
                            }else{
                              return RaisedButton(
                                child: Text("Open Youtube"),
                                onPressed: sportCtrl.openYutube,
                              );
                            }
                          }
                        )
                      );
                    } else {
                      return Container();
                    }
                  }
                )
              ],
            )
          );
        }
      }
    );
  }
}

class ListSport extends StatelessWidget {
  String title;
  ListSport(@required this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 20.0,
        width: 20.0,
        decoration: new BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(title),
    );
  }
}