import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appl/hesapIslemleri/gmail.dart';
import 'package:flutter_appl/hesapIslemleri/mail.dart';

class HesapOlustur extends StatefulWidget {
  @override
  _HesapOlusturState createState() => _HesapOlusturState();
}

class _HesapOlusturState extends State<HesapOlustur> {
  final _formKontrol = GlobalKey<FormState>();
  String kullaniciAdi, email, sifre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Hesap Oluştur",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/b4.png"),
                  fit: BoxFit.cover
              )
          ),
          child: Form(
            key: _formKontrol,
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Kullanmak istediğiniz Kullanıcı adını giriniz.",
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (GirilenDeger) {
                            if (GirilenDeger.isEmpty) {
                              return "Kullanıcı adı boş bırakılamaz.";
                            } else if (GirilenDeger.length < 3) {
                              return "Kullanıcı adı en az 4 değerden oluşmalıdır.";
                            }
                            return null;
                          },
                          onSaved: (GirilenDeger) => kullaniciAdi = GirilenDeger,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Hotmail veya Gmail Hesabınızı giriniz.",
                            prefixIcon: Icon(Icons.mail),
                          ),
                          autocorrect: true,
                          keyboardType: TextInputType.emailAddress,
                          validator: (GirilenDeger) {
                            if (GirilenDeger.isEmpty) {
                              return "Email veya Gmail Hesabı boş bırakılamaz.";
                            } else if (!GirilenDeger.contains("@hotmail")&&!GirilenDeger.contains("@gmail")) {
                              return "Girdiğiniz değer Hotmail veya Gmail formatı olmalıdır.";
                            }
                            return null;
                          },
                          onSaved: (GirilenDeger) => email = GirilenDeger,
                        ),
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
                          onSaved: (GirilenDeger) => sifre = GirilenDeger,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: _kullaniciOlustur,
                            child: Text(
                              "Hotmail Hesabımı oluştur.",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            )),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _kullaniciOlustur2,
                          child: Text(
                            "Gmail hesabımı oluştur.",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  /*_kullaniciOlustur() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: sifre);
  }*/

void _kullaniciOlustur() {
    var _formState = _formKontrol.currentState;
    if (_formState.validate()) {
      _formState.save();
      /*var data = [];
      data.add(kullaniciAdi);
      data.add(email);
      data.add(sifre);
      print(email);
      print(sifre);*/
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre).then((kullanici){
        FirebaseFirestore.instance.collection("Kullanicilar").doc(email).set({
          'KullaniciEposta' : email,
          'KullaniciSifre' : sifre,
          'KullaniciAdi' : kullaniciAdi,
          'Dersiniz' : "",
          'Netiniz' : "",
          'Süreniz' : "",
        }).whenComplete(() => print("Firestore'a eklenildi."));
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Mail(),
      ));

    }
  }

 Future<void> _kullaniciOlustur2() async{
    var _formState = _formKontrol.currentState;

    print(email);
    print(sifre);

    if (_formState.validate()) {
      _formState.save();
      var data = [];
      data.add(kullaniciAdi);
      data.add(email);
      data.add(sifre);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre).then((kullanici){
            FirebaseFirestore.instance.collection("Kullanicilar").doc(email).set({
              'KullaniciEposta' : email,
              'KullaniciSifre' : sifre,
              'KullaniciAdi' : kullaniciAdi,
              'Dersiniz' : "",
              'Netiniz' : "",
              'Süreniz' : "",
            }).whenComplete(() => print("Firestore'a eklenildi."));
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Gmail(),
              ));
    }
  }
}
