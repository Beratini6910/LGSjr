import 'package:flutter/material.dart';
import 'package:flutter_appl/anasayfa.dart';
import 'package:flutter_appl/main.dart';

class Hakkinda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text(
          "Hakkında",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 40, right: 40, top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.shade100,
              ),
              height: 120,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Bu uygulama Dr.ÖğretimÜyesi Ahmet Cevahir ÇINAR tarafından yürütülen 3311456 kodlu MOBİL PROGRAMLAMA dersi kapsamında 193311027 numaralı Berat Şenol tarafından 25 Haziran 2021 günü yapılmıştır.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GirisSayfasi()));
            },
            child: Text("Giriş Sayfasına Geri Dön"),
          ),
        ],
      ),
    );
  }
}
