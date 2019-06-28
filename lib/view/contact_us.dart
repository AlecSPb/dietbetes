import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

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
    return Container(
      child: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text("Hal-Hal yang perlu dipantau setiap harinya"),
            children: <Widget>[
              sportTile("Pantau kadar gula darah anda!\nGDP : 80-125\nGDS : 115-157\nGD2JPP: <170\nKolesterol : <200"),
              sportTile("Pastikan Kebutuhan Gizi mu terpenuhi!\nKarbohidrat : 45-65% (utamakan yang berserat tinggi)\nProtein : 10-20%\nLemak : 20-25% (hindari lemak jenuh)\nKonsumsi sayur setara dengan 2-3 porsi setara dengan 2-3 gelas sayur yang ditiriskan."),
              sportTile("Dari mana saja persentase kebutuhan giziku?\nMakan Pagi : 20%\nMakan Siang : 30%\nMakan Malam : 25%\nSnack siang dan sore : 10-15%"),
              sportTile("Jangan lupa hitung Target Heart Rate mu sesudah berolahraga (pastikan berolahraga minimal 3-5x per minggu 30 menit per hari)!\nRumus : 220-Usia\nCth : 220-20 tahun = 200 denyutan/1 menit\nJadi, denyut jantung maximal setelah berolahraga adalah 200x denyutan per 1 menit.")
            ],
          ),
          ExpansionTile(
            title: Text("Tips-Tips untuk mu"),
            children: <Widget>[
              sportTile("Pastikan memeriksa kadar gula darah minimal 1x per bulan"),
              sportTile("Walaupun sudah menyuntikkan insulin, tetap perhatikan asupan gula mu untuk menghindari terjadinya hiperglikemia!"),
              sportTile("Jangan menyuntikkan insulin diluar jam yang telah direkomendasikan dokter untuk mencegah terjadinya hipoglikemia"),
              sportTile("Pertahankan berat badan idealmu!"),
              sportTile("Makanlah tepat waktu secara berkelanjutan"),
              sportTile("Makanlah tepat waktu secara berkelanjutan"),
              sportTile("Selalu pantau kadar gula darah sebelum dan sesudah berolahraga"),
            ],
          )
        ],
      ),
    );
  }
}