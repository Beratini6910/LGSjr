import 'package:flutter/material.dart';
import 'package:flutter_appl/analizler/grafik.dart';
import 'package:flutter_appl/dersler/fensorular.dart';
import 'package:flutter_appl/dersler/genel.dart';
import 'package:flutter_appl/dersler/matematiksorular.dart';
import 'package:flutter_appl/dersler/sosyalsorular.dart';
import 'package:flutter_appl/dersler/turkcesorular.dart';
import 'package:flutter_appl/hesapIslemleri/gmail.dart';
import 'package:flutter_appl/hesapIslemleri/mail.dart';
import 'package:flutter_appl/main.dart';

import 'hesapIslemleri/hesap_olustur.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  //final _formKontrol = GlobalKey<FormState>();
  String kullaniciAdi, email, sifre;

  @override
  Widget build(BuildContext context) {

    var data = [];
    data = (ModalRoute.of(context).settings.arguments);
    var kullaniciAdi = data[0];
    var email = data[1];
    var sifre = data[2];

      return Scaffold(
        backgroundColor: Colors.purple.shade100,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Test Listesi",
            style: TextStyle(
                color: Colors.white
            ),),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/c1.jpg"),
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 50,
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueGrey
                        ),
                        child: Text("Testler:",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w100,
                              color: Colors.white
                          ),),
                      ),
                      Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green.shade200.withOpacity(0.7)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GenelSorular(),
                                        settings: RouteSettings(
                                          arguments: data,)
                                    ),
                                  );
                                },
                                child: Text("Genel Sınav Denemesi",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow.shade400
                                  ),),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TurkceSorular(),
                                        settings: RouteSettings(
                                          arguments: data,)
                                        ),
                                  );
                                },
                                child: Text("Türkçe",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MatematikSorular(),
                                        settings: RouteSettings(
                                          arguments: data,)
                                        ),
                                  );
                                },
                                child: Text("Matematik",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FenSorular(),
                                        settings: RouteSettings(
                                          arguments: data,)
                                        ),
                                  );
                                },
                                child: Text("Fen Bilimleri",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  print(kullaniciAdi);
                                  print(email);
                                  print(sifre);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SosyalSorular(),
                                        settings: RouteSettings(
                                          arguments: data,)
                                        ),
                                  );
                                },
                                child: Text("Sosyal Bilgiler",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),),

                              ),
                            ),

                          ],
                        ),
                      ),

                      /*ElevatedButton(onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => GirisSayfasi(),
                        settings: RouteSettings(
                        arguments: data,)
                        ),
                        );
                          },
                        child: Text("Çıkış Yap",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),

                      ),*/
                      SizedBox(height: 10),
                    Center(child: GestureDetector(
                      onDoubleTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GirisSayfasi()));
                      },

                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Çıkış Yapmak için iki kere tıklayın",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          width: double.infinity,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                    ),
                    ),/*ElevatedButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GenelSorular(),
                          settings: RouteSettings(
                            arguments: data,)));
                })*/
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }


