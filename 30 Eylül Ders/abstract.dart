abstract class LoncaUyesi{
  final String rumuz;

  LoncaUyesi({required this.rumuz,});

  //soyut metot
  void ozelYetenekKullan();

  void loncayaSelamVer(){
    print("$rumuz Lonca bayrağını selamladı: 'Onur ve zafer için!'");
  }
}

class Sovalye extends LoncaUyesi{
  Sovalye({required super.rumuz,});

  @override  
    void ozelYetenekKullan(){
      print("$rumuz Demir Kalkanını kaldırdı ve savunma duvarı ördü.");
    }
}

class Sifaci extends LoncaUyesi{
  Sifaci({required super.rumuz,});

  @override  
    void ozelYetenekKullan(){
      print("$rumuz Kutsal ışık büyüsüyle tüm takımın canını tazeledi.");
    }
}

void savasAlanindaKomutVer(List<LoncaUyesi>takim){
  print("Liderin emri ile takım yetenekleri devreye girsin");

  for(var t in takim){
    t.loncayaSelamVer();
    //herkes kendi özel yeteneğini kullansın
    t.ozelYetenekKullan();
  }
}


void main(){
  print("Lonca Takımı");

  final List<LoncaUyesi>loncaBirligi=[
    Sovalye(rumuz: "Kızıl Şövalye Adil"),
    Sovalye(rumuz: "Gümüş Muhafız Eren"),
    Sifaci(rumuz: "Orman Perisi Shahd"),

  ];

  //hepsini tek bir emir ile çalıştır
  savasAlanindaKomutVer(loncaBirligi);
}

