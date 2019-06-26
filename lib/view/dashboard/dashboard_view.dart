import 'package:date_format/date_format.dart';
import 'package:dietbetes/models/journal_diet.dart';
import 'package:dietbetes/models/user_glucose.dart';
import 'package:dietbetes/view/dashboard/dashboard_controller.dart';
import 'package:dietbetes/wigdet/error_page.dart';
import 'package:dietbetes/wigdet/load_animation.dart';
import 'package:dietbetes/wigdet/loading.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardCtrl dashboardCtrl;

  @override
  void initState() {
    dashboardCtrl = new DashboardCtrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: StreamBuilder(
        stream: dashboardCtrl.userGlucose,
        builder: (ctx, AsyncSnapshot<UserGlucose> snapshoot) {
          if (snapshoot.hasData) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                      stream: dashboardCtrl.getName,
                      builder: (ctx, snapshoot) => (snapshoot.hasData) ? Text('Selamat Datang, ${snapshoot.data}', style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold)):Skeleton(height: 7.0, width: MediaQuery.of(context).size.width / 0.5),
                    ),
                    SizedBox(height: 10.0),
                    InkWell(onTap: () {
                      Navigator.pushNamed(context, '/glucose-update');
                    },child: Text('Kadar gula darah terakhir anda (${formatDate(DateTime.parse(snapshoot.data.createdAt), [dd, ' ', MM, ' ', yyyy])})', style: TextStyle(fontSize: 14.0, color: Colors.blueAccent))),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        BloodyChild('${snapshoot.data.hba1C.toString()}%','HbA1C','6.5%-8%'),
                        BloodyChild(snapshoot.data.gdp.toString(),'GDP','110-120 mmHg'),
                        BloodyChild(snapshoot.data.gds.toString(),'GDS','150-170 mmHg'),
                        BloodyChild(snapshoot.data.ttgo.toString(),'TTGO','160-180 mmHg')
                      ]
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text('Status Anda :', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                            InkWell(onTap: () => dashboardCtrl.getInfoStatus(context, snapshoot.data.status),child: Padding(padding: EdgeInsets.symmetric(vertical: 5.0),child: Text(snapshoot.data.status != null ? snapshoot.data.status:"", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: snapshoot.data.status == 'Hiperglikemia' ? Colors.red:(snapshoot.data.status == 'Hipoglikemia' ? Colors.yellow.shade700:Colors.green))))),
                            Text('Kontrol asupan gula anda hari ini', style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }else if (snapshoot.hasError) {
            return Center(
              child: ErrorPage(
                message: "Terjadi Kesalahan, silakan ulangi kembali",
                buttonText: "Ulangi Kembali",
                onPressed: () => dashboardCtrl.getUserGlucose(),
              ),
            );
          }
          return LoadingBlock(Theme.of(context).primaryColor);
        },
      ),
      bottomSheet: StreamBuilder(
        stream: dashboardCtrl.journalDiet,
        builder: (ctx, AsyncSnapshot<JournalDiet> snapshoot) {
          if (snapshoot.hasData) {
            return Container(
              width: double.infinity,
              height: 150.0,
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Pigment.fromString('#bceb9b')
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text('Status Gizi Anda : ${snapshoot.data.requirement.giziStatus}', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color: Colors.green, fontWeight: FontWeight.w600)),
                    ),
                    Text('Jenis Diet : Diet DM ${snapshoot.data.requirement.type} (${snapshoot.data.requirement.calories} kkal)', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color: Colors.green, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Energi : ${snapshoot.data.requirement.calories} kkal', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color:Colors.green, fontWeight: FontWeight.w600)),
                        Text('Protein : ${snapshoot.data.requirement.protein} gram', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color: Colors.green, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Karbohidrat : ${snapshoot.data.requirement.carbo} gram', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color: Colors.green, fontWeight: FontWeight.w600)),
                        Text('Lemak : ${snapshoot.data.requirement.fat} gram', textAlign: TextAlign.left, style: TextStyle(fontSize: 17.0, color: Colors.green, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }else if (snapshoot.hasError) {
            return Center(
              child: ErrorPage(
                message: "Terjadi Kesalahan, silakan ulangi kembali",
                buttonText: "Ulangi Kembali",
                onPressed: () => dashboardCtrl.getJournalDiet(),
              ),
            );
          }
          return LoadingBlock(Theme.of(context).primaryColor);
        }
      )
    );
  }
}

class BloodyChild extends StatelessWidget {
  String value;
  String title;
  String normal;
  BloodyChild(this.value, this.title, this.normal);
  
  dynamicBlood() {
    switch (title) {
      case 'GDP':
      if (num.parse(value) < 80) {
          return new AssetImage('assets/images/low_blood.png');
        }else if (num.parse(value) > 125) {
         return new AssetImage('assets/images/high_blood.png'); 
        }return new AssetImage('assets/images/normal_blood.png');
      case 'GDS':
        if (num.parse(value) <= 70) {
          return new AssetImage('assets/images/low_blood.png');
        }else if (num.parse(value) > 125) {
         return new AssetImage('assets/images/high_blood.png'); 
        }return new AssetImage('assets/images/normal_blood.png');
      case 'TTGO':
        if (num.parse(value) < 140) {
          return new AssetImage('assets/images/low_blood.png');
        }else if (num.parse(value) >= 200) {
         return new AssetImage('assets/images/high_blood.png'); 
        }return new AssetImage('assets/images/normal_blood.png');
      default:
        if (num.parse(value.replaceAll("%", "")) < 7) {
          return new AssetImage('assets/images/low_blood.png');
        }else if (num.parse(value.replaceAll("%", "")) > 7) {
         return new AssetImage('assets/images/high_blood.png'); 
        }return new AssetImage('assets/images/normal_blood.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 55.0,
          height: 75.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: dynamicBlood(),
              fit: BoxFit.cover
            )
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(value)
            )
          ),
        ),
        Container(
          width: 55.0,
          padding: EdgeInsets.only(top: 10.0),
          child: Center(
            child: Text(title),
          ),
        ),
        Container(
          width: 70.0,
          child: Center(
            child: Text(normal, style: TextStyle(fontSize: 10, color: Colors.indigo, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
          ),
        )
      ],
    );
  }
}