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
                child: Text('Anasayfaya D??n'),
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
          "Asit s??z??nt??s?? meydana gelen bir b??lgede yerler kumla kapat??l??r ve havan??n tamamen temizlenmesi i??in ??al????ma ba??lat??l??r.Bunlara ilave olarak asitin g??zlere ve solunum yollar??na zarar verici ??zelli??inden dolay?? ??evresi de bo??alt??l??r.Verilen bilgilere g??re a??a????dakilerden hangisi s??ylenemez?",
      'cevap': [
        'A) S??z??nt??n??n meydana geldi??i b??lgede toprak yap??s?? zarar g??rebilir.',
        'B) S??z??nt??dan sonra asit ya??muruna y??nelik ??nlem al??nm????t??r.',
        'C)  Asitin g??ze zarar vermesi buharla??t??????n?? g??sterir.',
        'D) Kullan??lan kumun pH derecesi 0-7 aras??ndad??r.'
      ],
      'dogrucevap': 'A) '
    },
    {
      'soru': "Aziz Sancar ve arkada??lar??, bir ??al????mada ila??lar??n yan etkilerinden olan DNA hasar??n?? azaltmak i??in ilac??n hangi zaman diliminde kullan??lmas?? gerekti??ini ara??t??rm????lard??r. Bu ama??la farelerde ilac??n olu??turdu??u hasar??n onar??lmas??na y??nelik bir ara??t??rma yapm????lard??r. Ara??t??rma sonucunda canl??lar??n bedenlerinde ger??ekle??en olaylara ayr??lan s??re olan biyolojik" +
          "Bu deneydeki ba????ms??z de??i??ken a??a????dakilerden hangisidir?",
      'cevap': ['A) ??la??', 'B) Fare', 'C) Biyolojik saat', 'D) DNA???daki hasar miktar??'],
      'dogrucevap': 'A) '
    },
    {
      'soru':
          "I.	 Da??da yeti??en karahindiba bitkisi ile evinin bah??esinde yeti??en karahindiba bitkisindeki b??y??meye neden olan genlerin i??leyi??i farkl?? olabilir. II.	 Da??da yeti??en karahindiba bitkisinin tohumu, evinin bah??esine ekildikten sonra genlerinde yap??sal de??i??iklik meydana gelmi??tir. III.	Karahindiba bitkisinin de??i??ik ortamlardaki boylar??n??n farkl?? olmas?? modifikasyona ??rnek olarak verilir. ????kar??mlar??ndan hangileri do??rudur?",
      'cevap': ['A) I ve II', 'B) I ve III', 'C) I, II ve III', 'D) II ve III'],
      'dogrucevap': 'D) '
    },
    {
      'soru': "Ph ??l????mleri hangi  ama??la kullan??l??r?",
      'cevap': [
        'A) Asit Baz ??l????m??',
        'B) S??cakl??k ??l????m??',
        'C) Y??kseklik ??l????m??',
        'D) Mesafe ??l????m??'
      ],
      'dogrucevap': 'A) '
    },
    {
      'soru':
          "Ge??ti??imiz g??nlerde d??nyada ya??anan iki b??y??k f??rt??nadan biri ABD???de etkili olan Florance Kas??rgas?? di??eri ise Filipinler, ??in ve Hongkong???u etkisi alt??na alan Mangkhut Tayfunu???dur. Bu gibi f??rt??nalar??n daha s??k ve ??iddetli ya??anmas??na k??resel ??s??nman??n etkisi ile atmosfer ve deniz s??cakl??klar??ndaki art??????n neden oldu??u d??????n??lmektedir",
      'cevap': [
        'A) Kas??rga ve tayfunlar??n s??rekli olarak ayn?? yerlerde meydana gelmesi',
        'B) Su d??ng??s??n??n ger??ekle??mesinde hava s??cakl??????n??n etkili olmas??',
        'C) Deniz y??zeyi s??cakl??klar?? azald??????nda f??rt??nalar??n ??iddetinin de azalmas??',
        'D) K??resel ??s??nmaya ba??l?? olarak mevsim s??relerinin de??i??mesi'
      ],
      'dogrucevap':
          'C) '
    },
    {
      'soru':
          "D??nya???m??za en yak??n y??ld??z olup ????plak g??zle g??r??lebilir.Y??zey s??cakl?????? yakla????k olarak 6000??C???tur.B??y??kl?????? D??nya???m??z??n b??y??kl??????n??n yakla????k olarak 110 kat??d??r. Verilen bilgiler, a??a????daki g??k cisimlerinden hangisine aittir?",
      'cevap': ['A) Ven??s', 'B) G??ne??', 'C) Ay', 'D) Mars'],
      'dogrucevap': 'B) '
    },
    {
      'soru':
          "Gezegenler hangi g??k cisminin etraf??nda dolanma hareketi yaparlar?",
      'cevap': ['A) Y??ld??z', 'B) D??nya', 'C) Asteroit', 'D) Uydu'],
      'dogrucevap': 'D) '
    },
    {
      'soru':
          "G??ne?? sistemindeki gezegenlerden biri, kendi ekseni etraf??nda yatay olarak d??ner. Gezegenler, G??ne?????e yak??nl??k derecelerine g??re s??raland??????nda bu gezegen ka????nc?? s??rada yer al??r?",
      'cevap': ['A) 1.', 'B) 2.', 'C) 3.', 'D) 4.'],
      'dogrucevap': 'C) '
    },
    {
      'soru':
          " K??????k g??k cisimleri olarak da bilinen asteroitler, G??ne?????in ??evresinde dolan??rlar. Ancak asteroitlerin iki gezegenin y??r??ngeleri aras??nda yo??un olarak bulunduklar?? bir b??lge vard??r ki buraya ???Asteroit Ku??a??????? denir. Buna g??re bu gezegen ??ifti a??a????dakilerin hangisinde verilmi??tir?",
      'cevap': [
        'A) Mars - J??piter',
        'B) J??piter - Sat??rn',
        'C) Merk??r - Ven??s',
        'D) Uran??s - Nept??n'
      ],
      'dogrucevap': 'D) '
    },
    {
      'soru':
          "G??ne?? sisteminde bulunan gezegenler ile ilgili a??a????da verilen bilgilerden hangisi yanl????t??r?",
      'cevap': [
        'A) B??y??kl??kleri ve G??ne?????e olan uzakl??klar?? farkl??d??r',
        'B) G??ne?? etraf??nda bulunan y??r??ngelerinde, hepsi ayn?? y??nde dolan??r.',
        'C) Baz??lar?? i?? gezegen, baz??lar?? da d???? gezegen olarak grupland??r??l??r.',
        'D) Hepsinin kendi ekseni etraf??nda d??n?????? saatin d??nme y??n??ne terstir'
      ],
      'dogrucevap': 'A) '
    },
  ];
}
