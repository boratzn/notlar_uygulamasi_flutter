import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi_flutter/data/notlar_dao.dart';
import 'package:notlar_uygulamasi_flutter/main.dart';

class NotKayitSayfa extends StatefulWidget {
  const NotKayitSayfa({super.key});

  @override
  State<NotKayitSayfa> createState() => _NotKayitSayfaState();
}

class _NotKayitSayfaState extends State<NotKayitSayfa> {
  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  Future<void>? kayit(String ders_adi, int not1, int not2) async {
    await NotlarDao().notEkle(ders_adi, not1, not2);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnaSayfa(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Kayıt Sayfası"),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          //kayit(tfDersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));
          await kayit(
              tfDersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));
        },
        tooltip: 'Not Kayıt',
        icon: const Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}
