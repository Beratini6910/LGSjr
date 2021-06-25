import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appl/hesapIslemleri/gmail.dart';
import 'package:flutter_appl/hakkinda.dart';
import 'package:flutter_appl/hesapIslemleri/hesap_olustur.dart';
import 'package:flutter_appl/hesapIslemleri/mail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Giriş Sayfası',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.purple.shade600,
        accentColor: Colors.red,
      ),
      home: GirisSayfasi(),
    );
  }
}

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/b6.png"),
              fit: BoxFit.cover
            )
          ),
          child: Center(
            child: Column(children: <Widget>[
              SizedBox(height: 45),
              SizedBox(height: 30),
              Image.asset("assets/images/b1.png"),
              SizedBox(height: 25),
              /*Text(
                "LGS JR.",
                style: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    shadows: [Shadow(color: Colors.black, offset: Offset(3, 3))]),
              ),*/
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 30,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HesapOlustur()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Hesap Oluştur",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                /*onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mail()));*/
                                onHorizontalDragStart: (DragStartDetails details)
                                {
                                  },
                                onHorizontalDragUpdate: (DragUpdateDetails details)
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Mail()));
                                        },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Hotmail ile Giriş",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade600.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                /*onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Gmail()));
                                },*/
                                onVerticalDragStart: (DragStartDetails details)
                                {
                                },
                                onVerticalDragUpdate: (DragUpdateDetails details)
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Gmail()));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Gmail ile Giriş",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: Colors.red[600].withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/b5.jpg"),
                            fit: BoxFit.cover
                        ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.purple[500],
                            Colors.purple[100],
                            Colors.purple[500],
                          ])),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 70,
                  height: 180,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onLongPress : _hakkindayagit,
                //onPressed: _hakkindayagit,
                child: Text(
                  "     Hakkında"+'\n' "(Uzun Basınız)" ,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              ),
              SizedBox(height: 30),
              FlutterLogo(
                size: 80.0,
              ),

            ]),
          ),
        ));
  }

  void _hakkindayagit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Hakkinda(),
            settings: RouteSettings(
            )));

  }
}

