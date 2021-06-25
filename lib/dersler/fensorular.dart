import 'dart:async';

import 'package:flutter_appl/anasayfa.dart';
import 'package:flutter_appl/analizler/analiz.dart';
import 'package:flutter/material.dart';

class FenSorular extends StatefulWidget {
  @override
  _FenSorularState createState() => _FenSorularState();
}

String zaman(int milisaniye) {
  var saniye = milisaniye ~/ 1000;
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');

  return "$dakika:$saniyeler";
}

class _FenSorularState extends State<FenSorular> {
  String kullaniciAdi = '';
  String email = '';
  String sifre = '';
  int soru = 0;
  String cevap = '';
  double net = 0;

  Stopwatch _sayac;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _sayac = Stopwatch();
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void analizeGonder() {
    var data = [];
    String ders = "Fen Bilimleri";
    data.add(kullaniciAdi);
    data.add(email);
    data.add(ders);
    data.add(net);
    data.add(zaman(_sayac.elapsedMilliseconds));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Bitir(),
          settings: RouteSettings(
            arguments: data,
          ),
        ));
  }

  void cevapKontrol() {
    if (soru >= 9 &&cevap.contains(sorular[soru]['dogrucevap'])) {
      net = net+1;
      soru = 0;
      _timer.cancel();
      analizeGonder();
    }
      else if(soru >= 9 &&!cevap.contains(sorular[soru]['dogrucevap'])){
        net = net - 0.3;
        soru = 0;
        _timer.cancel();
        analizeGonder();
      }
    else {
      if (cevap.contains(sorular[soru]['dogrucevap'])) {
        net = net + 1;
        soru++;
      } else {
        net = net - 0.3;
        soru++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = [];
    data = ModalRoute.of(context).settings.arguments;
    kullaniciAdi = data[0];
    email = data[1];
    sifre = data[2];

    _sayac.start();
    if (soru <= 9 && _sayac.elapsedMilliseconds > 1200000) {
      Future.delayed(Duration.zero, () async {
        _timer.cancel();
        soru = 0;
        analizeGonder();
      });
    }

    List cevapdeposu = [];
    for (var u in sorular[soru]['cevap']) {
      cevapdeposu.add(u);
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: Text(
          "Fen Bilimleri Testi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                (soru + 1).toString() + '.Soru  ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 7,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green.shade200,
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.red[500],
                            Colors.red[100],
                            Colors.purple[500],
                          ])),
                  child: Text(
                    sorular[soru]['soru'],
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cevap = cevapdeposu[0].toString();
                    });
                    cevapKontrol();
                  },
                  child: Text(
                    cevapdeposu[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cevap = cevapdeposu[1].toString();
                    });
                    cevapKontrol();
                  },
                  child: Text(
                    cevapdeposu[1],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cevap = cevapdeposu[2].toString();
                    });
                    cevapKontrol();
                  },
                  child: Text(
                    cevapdeposu[2],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cevap = cevapdeposu[3].toString();
                    });
                    cevapKontrol();
                  },
                  child: Text(
                    cevapdeposu[3],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
                "Kalan Vaktiniz: " +
                    zaman(1200000 - _sayac.elapsedMilliseconds),
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Text(
              'Netiniz: ' + net.toString(),
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Anasayfa(),
                          settings: RouteSettings(
                            arguments: data,
                          )));
                },
                child: Text('Anasayfaya Dön'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final sorular = [
    {
      'soru':
          "Asit sızıntısı meydana gelen bir bölgede yerler kumla kapatılır ve havanın tamamen temizlenmesi için çalışma başlatılır.Bunlara ilave olarak asitin gözlere ve solunum yollarına zarar verici özelliğinden dolayı çevresi de boşaltılır.Verilen bilgilere göre aşağıdakilerden hangisi söylenemez?",
      'cevap': [
        'A) Sızıntının meydana geldiği bölgede toprak yapısı zarar görebilir.',
        'B) Sızıntıdan sonra asit yağmuruna yönelik önlem alınmıştır.',
        'C)  Asitin göze zarar vermesi buharlaştığını gösterir.',
        'D) Kullanılan kumun pH derecesi 0-7 arasındadır.'
      ],
      'dogrucevap': 'A) '
    },
    {
      'soru': "Aziz Sancar ve arkadaşları, bir çalışmada ilaçların yan etkilerinden olan DNA hasarını azaltmak için ilacın hangi zaman diliminde kullanılması gerektiğini araştırmışlardır. Bu amaçla farelerde ilacın oluşturduğu hasarın onarılmasına yönelik bir araştırma yapmışlardır. Araştırma sonucunda canlıların bedenlerinde gerçekleşen olaylara ayrılan süre olan biyolojik" +
          "Bu deneydeki bağımsız değişken aşağıdakilerden hangisidir?",
      'cevap': ['A) İlaç', 'B) Fare', 'C) Biyolojik saat', 'D) DNA’daki hasar miktarı'],
      'dogrucevap': 'A) '
    },
    {
      'soru':
          "I.	 Dağda yetişen karahindiba bitkisi ile evinin bahçesinde yetişen karahindiba bitkisindeki büyümeye neden olan genlerin işleyişi farklı olabilir. II.	 Dağda yetişen karahindiba bitkisinin tohumu, evinin bahçesine ekildikten sonra genlerinde yapısal değişiklik meydana gelmiştir. III.	Karahindiba bitkisinin değişik ortamlardaki boylarının farklı olması modifikasyona örnek olarak verilir. çıkarımlarından hangileri doğrudur?",
      'cevap': ['A) I ve II', 'B) I ve III', 'C) I, II ve III', 'D) II ve III'],
      'dogrucevap': 'D) '
    },
    {
      'soru': "Ph ölçümleri hangi  amaçla kullanılır?",
      'cevap': [
        'A) Asit Baz ölçümü',
        'B) Sıcaklık ölçümü',
        'C) Yükseklik ölçümü',
        'D) Mesafe ölçümü'
      ],
      'dogrucevap': 'A) '
    },
    {
      'soru':
          "Geçtiğimiz günlerde dünyada yaşanan iki büyük fırtınadan biri ABD’de etkili olan Florance Kasırgası diğeri ise Filipinler, Çin ve Hongkong’u etkisi altına alan Mangkhut Tayfunu’dur. Bu gibi fırtınaların daha sık ve şiddetli yaşanmasına küresel ısınmanın etkisi ile atmosfer ve deniz sıcaklıklarındaki artışın neden olduğu düşünülmektedir",
      'cevap': [
        'A) Kasırga ve tayfunların sürekli olarak aynı yerlerde meydana gelmesi',
        'B) Su döngüsünün gerçekleşmesinde hava sıcaklığının etkili olması',
        'C) Deniz yüzeyi sıcaklıkları azaldığında fırtınaların şiddetinin de azalması',
        'D) Küresel ısınmaya bağlı olarak mevsim sürelerinin değişmesi'
      ],
      'dogrucevap':
          'C) '
    },
    {
      'soru':
          "Dünya’mıza en yakın yıldız olup çıplak gözle görülebilir.Yüzey sıcaklığı yaklaşık olarak 6000°C’tur.Büyüklüğü Dünya’mızın büyüklüğünün yaklaşık olarak 110 katıdır. Verilen bilgiler, aşağıdaki gök cisimlerinden hangisine aittir?",
      'cevap': ['A) Venüs', 'B) Güneş', 'C) Ay', 'D) Mars'],
      'dogrucevap': 'B) '
    },
    {
      'soru':
          "Gezegenler hangi gök cisminin etrafında dolanma hareketi yaparlar?",
      'cevap': ['A) Yıldız', 'B) Dünya', 'C) Asteroit', 'D) Uydu'],
      'dogrucevap': 'D) '
    },
    {
      'soru':
          "Güneş sistemindeki gezegenlerden biri, kendi ekseni etrafında yatay olarak döner. Gezegenler, Güneş’e yakınlık derecelerine göre sıralandığında bu gezegen kaçıncı sırada yer alır?",
      'cevap': ['A) 1.', 'B) 2.', 'C) 3.', 'D) 4.'],
      'dogrucevap': 'C) '
    },
    {
      'soru':
          " Küçük gök cisimleri olarak da bilinen asteroitler, Güneş’in çevresinde dolanırlar. Ancak asteroitlerin iki gezegenin yörüngeleri arasında yoğun olarak bulundukları bir bölge vardır ki buraya “Asteroit Kuşağı” denir. Buna göre bu gezegen çifti aşağıdakilerin hangisinde verilmiştir?",
      'cevap': [
        'A) Mars - Jüpiter',
        'B) Jüpiter - Satürn',
        'C) Merkür - Venüs',
        'D) Uranüs - Neptün'
      ],
      'dogrucevap': 'D) '
    },
    {
      'soru':
          "Güneş sisteminde bulunan gezegenler ile ilgili aşağıda verilen bilgilerden hangisi yanlıştır?",
      'cevap': [
        'A) Büyüklükleri ve Güneş’e olan uzaklıkları farklıdır',
        'B) Güneş etrafında bulunan yörüngelerinde, hepsi aynı yönde dolanır.',
        'C) Bazıları iç gezegen, bazıları da dış gezegen olarak gruplandırılır.',
        'D) Hepsinin kendi ekseni etrafında dönüşü saatin dönme yönüne terstir'
      ],
      'dogrucevap': 'A) '
    },
  ];
}
