import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi_flutter/data/notlar_dao.dart';
import 'package:notlar_uygulamasi_flutter/models/notlar.dart';
import 'package:notlar_uygulamasi_flutter/pages/not_detay_sayfasi.dart';
import 'package:notlar_uygulamasi_flutter/pages/not_kayit_sayfa.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final bool selected = false;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  var notlarListesi = <Notlar>[];

  Future<List<Notlar>> tumNotlariGoster() async {
    notlarListesi = await NotlarDao().tumNotlariGetir();

    return notlarListesi;
  }

  Future<bool> cikisYap() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              cikisYap();
            },
            icon: Icon(Icons.arrow_back)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notlar Uygulaması",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            FutureBuilder(
              future: tumNotlariGoster(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var notlarListesi = snapshot.data;

                  double ortalama = 0.0;

                  if (!notlarListesi!.isEmpty) {
                    double toplam = 0.0;

                    for (var not in notlarListesi) {
                      toplam += (not.not1! + not.not2!) / 2;
                    }

                    ortalama = toplam / notlarListesi.length;
                  }
                  return Text(
                    "Ortalama : ${ortalama.toInt()}",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  );
                } else {
                  return const Text(
                    "Ortalama : 0",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  );
                }
              },
            )
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: cikisYap,
        child: FutureBuilder<List<Notlar>>(
          future: tumNotlariGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var notlarListesi = snapshot.data;
              return ListView.builder(
                itemCount: notlarListesi!.length,
                itemBuilder: (context, index) {
                  var oAnkiNot = notlarListesi.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotDetaySayfa(not: oAnkiNot),
                          ));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              oAnkiNot.ders_adi!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(oAnkiNot.not1.toString()),
                            Text(oAnkiNot.not2.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Data Yok"),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotKayitSayfa(),
              ));
        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}
