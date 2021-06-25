import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appl/anasayfa.dart';
import 'package:flutter_appl/hata.dart';
import 'package:flutter_appl/hesapIslemleri/hesap_olustur.dart';
import 'package:flutter_appl/main.dart';

class Mail extends StatefulWidget {
  @override
  _MailState createState() => _MailState();
}

class _MailState extends State<Mail> {
  final _formKontrolm = GlobalKey<FormState>();
  String email1, sifre1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Hotmail ile Giriş",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.purple.shade200,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/a1.jpg"),
                  fit: BoxFit.cover
              )
          ),
          child: Form(
            key: _formKontrolm,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.green.shade50.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Hotmail Hesabınızı giriniz.",
                          prefixIcon: Icon(Icons.mail),
                        ),
                        autocorrect: true,
                        keyboardType: TextInputType.emailAddress,
                        validator: (GirilenDeger) {
                          if (GirilenDeger.isEmpty) {
                            return "Hotmail Hesabı boş bırakılamaz.";
                          } else if (!GirilenDeger.contains("@hotmail")) {
                            return "Lütfen sadece Hotmail formatı giriniz.";
                          }
                          return null;
                        },
                        onSaved: (GirilenDeger) => email1 = GirilenDeger),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Şifrenizi giriniz.",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (GirilenDeger) {
                          if (GirilenDeger.isEmpty) {
                            return "Şifre boş bırakılamaz.";
                          } else if (GirilenDeger.length < 7) {
                            return "Şifre en az 8 değerden oluşmalıdır.";
                          }
                          return null;
                        },
                        onSaved: (GirilenDeger) => sifre1 = GirilenDeger),
                    SizedBox(height: 40),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade200,
                            padding: EdgeInsets.all(20)),
                        onPressed: _girisYap,
                        child: Text(
                          "Hotmail ile Giriş yap",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.blue),
                        )),
                    SizedBox(height: 10),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HesapOlustur()));
                        },
                        child: Text(
                          "Hesabınız yok mu? Hemen üye olun!",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.red),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void>_girisYap() async {


    var _formState = _formKontrolm.currentState;
    if (_formState.validate()) {
      _formState.save();
      print("email" + email1);
      print("sifre" + sifre1);
      /*var data = [];
      data = (ModalRoute.of(context).settings.arguments);
      var email = data[1];
      var sifre = data[2];
       if (email == email1 && sifre == sifre1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Anasayfa(),
                settings: RouteSettings(
                  arguments: data,
                )));*/
      } else {

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Hata()));
      }

      print(email1);
      print(sifre1);

      var kullaniciAdi = "";

      await FirebaseFirestore.instance
          .collection("Kullanicilar")
          .doc(email1)
          .get()
          .then((adi){
        setState((){
          kullaniciAdi = adi.data()['KullaniciAdi'];
        });
      });

      var data = [];
      data.add(kullaniciAdi);
      data.add(email1);
      data.add(sifre1);

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email1, password: sifre1)
          .then((kullanici){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Anasayfa(),settings: RouteSettings(
          arguments: data,
        )));
      });

      print(kullaniciAdi);

    }

    /* show() {
    /*Timer timer = Timer(Duration(milliseconds: 3000), (){
      Navigator.of(context, rootNavigator: true).pop();
    });*/
    return showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
                title: new Text("Hatalı Giriş Yaptınız"),
                content: new Text(
                    "Hatalı Hotmail veya şifre girdiniz. Lütfen tekrar deneyiniz."),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: new Text("Close"),
                    onPressed: () => Navigator.pop(context),
                  )
                ]));
  }*/
  }


