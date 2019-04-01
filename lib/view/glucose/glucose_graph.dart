import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:fcharts/fcharts.dart';

class GlucoseGraph extends StatefulWidget {
  @override
  _GlucoseGraphState createState() => _GlucoseGraphState();
}

class _GlucoseGraphState extends State<GlucoseGraph> {
  List<String> monthName = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Des'];
  

  legendChart(String s, MaterialColor color) {
    return Row(
      children: <Widget>[
        Text(s),
        SizedBox(width: 5.0),
        Container(
          height: 15.0,
          width: 35.0,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: color.shade700),
            color: color
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var hba1c = [7.0, 6.8, 3.1, 5.5, 8.0, 9.0, 8.7, 8.4, 7.9, 7.2, 7.0, 7.5];
    var hba1c = [7.0, 6.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    var gpd = [60.0, 65.0, 80.0, 78.0, 73.0, 90.0, 130.0, 125.0, 110.0, 99.0, 89.0, 79.0];
    var size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Gula Darah Saya"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("250"),
                      Text("200"),
                      Text("150"),
                      Text("100"),
                      Text("50"),
                      Text("25"),
                      Text("10"),
                      Text("0")
                    ],
                  ),
                  SizedBox(width: 5.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1.0), bottom: BorderSide(width: 1.0))
                      ),
                      child: 
                      LineChart(
                        chartPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                        lines: [
                          new Sparkline(
                            curve: LineCurves.monotone,
                            data: hba1c,
                            stroke: new PaintOptions.stroke(
                              color: Colors.red,
                              strokeWidth: 2.0,
                            ),
                            marker: new MarkerOptions(
                              paint: new PaintOptions.fill(color: Colors.red),
                            ),
                          ),
                          new Sparkline(
                            curve: LineCurves.monotone,
                            data: gpd,
                            stroke: new PaintOptions.stroke(
                              color: Colors.blue,
                              strokeWidth: 2.0,
                            ),
                            marker: new MarkerOptions(
                              paint: new PaintOptions.fill(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: monthName.map((name) => new Text(name)).toList(),
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                legendChart('HbA1C', Colors.red),
                legendChart('GPD', Colors.blue)
              ],
            )
          ],
        ),
      ),
    );
  }
}