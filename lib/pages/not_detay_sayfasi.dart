import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi_flutter/data/notlar_dao.dart';

import '../main.dart';
import '../models/notlar.dart';

class NotDetaySayfa extends StatefulWidget {
  final Notlar not;

  const NotDetaySayfa({required this.not});

  @override
  State<NotDetaySayfa> createState() => _NotDetaySayfaState();
}

class _NotDetaySayfaState extends State<NotDetaySayfa> {
  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  Future<void>? sil(int not_id) async {
    await NotlarDao().notSil(not_id);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnaSayfa(),
        ));
  }

  Future<void>? guncelle(
      int not_id, String ders_adi, int not1, int not2) async {
    await NotlarDao().notGuncelle(not_id, ders_adi, not1, not2);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnaSayfa(),
        ));
  }

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfDersAdi.text = not.ders_adi!;
    tfNot1.text = not.not1.toString();
    tfNot2.text = not.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Detay"),
        actions: [
          ElevatedButton(
            onPressed: () {
              var not = widget.not;
              guncelle(not.not_id!, tfDersAdi.text, int.parse(tfNot1.text),
                  int.parse(tfNot2.text));
            },
            child: Text("Güncelle"),
          ),
          ElevatedButton(
            onPressed: () {
              sil(widget.not.not_id!);
            },
            child: Text("Sil"),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(hintText: "Ders Adı"),
              ),
              TextField(
                controller: tfNot1,
                decoration: InputDecoration(hintText: "1. Not"),
              ),
              TextField(
                controller: tfNot2,
                decoration: InputDecoration(hintText: "2. Not"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
