import 'package:flutter/material.dart';

class DetailFood extends StatefulWidget {
  @override
  _DetailFoodState createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit Oatmeal"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text('Untuk 1 porsi. 10-15 menit', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic)),
            SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Bahan : '),
                        Text('3 sdm oatmeal'),
                        Text('granola secukupnya'),
                        Text('almond secukupnya'),
                        Text('100 gram strawberry'),
                        Text('50 ml susu low fat'),
                        Text('1 buah pisang'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    height: 110.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhm-kXEcsQHxwk1s8lg65e32u3Ef4SpdYzGGdwalIiihHkhcOP'),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25.0),
            Text('Cara membuat:'),
            Text('1. masak oatmeal dengan air panas secukupnya dan pastikan tidak teralu kental atau encer'),
            Text('2. campurkan susu low-fat'),
            Text('3. sajikan dengan granola, almond, buah strawberry dan pisang'),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Energi : 300 kkal ; Karbohidrat: 30 gram ; Protein: 15 gram ; Lemak: 5 gram', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic))
      ),
    );
  }
}