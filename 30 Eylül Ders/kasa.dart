//eğer altına negatif değer gelirse sahte altın eklenemez poziif gelirse eklensin


class Kasa {
  final String karakterAdi;
  int _altinMiktari=0;

  Kasa({required this.karakterAdi});

  int get altinMiktari {
    
    return _altinMiktari;
  }

  set altinMiktari(int gelenAltin) {
    if (gelenAltin < 0) {
      print("Sahte altın eklenemez!");
    } else if (gelenAltin > 0) {
      _altinMiktari += gelenAltin;
      print("Yeni altınlar başarıyla kasaya eklendi.");
    }else{
      print("Kasaya eklenecek altın bulunamadı.");
    }
  }
}

void main() {
  Kasa kasa = Kasa(karakterAdi: "Arthur");

  kasa.altinMiktari = 50;
  print("Altın miktarı: ${kasa.altinMiktari}");

  kasa.altinMiktari = -20;
  print("Altın miktarı: ${kasa.altinMiktari}");

  kasa.altinMiktari = 0;
  print("Altın miktarı: ${kasa.altinMiktari}");
}