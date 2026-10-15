class CanSistemi {
  final String karakterAdi;
  double _canPuani = 100.0; //_ burada bu değişkeni GİZLİ olarak kodlar. dışarıya açıklık kapanır.

  CanSistemi({required this.karakterAdi});

  //getter ile can puanı güvenli dışarıya okutma
  double get canPuani {
    //gizli olan can puanını güvenli şekilde dışarı döndürdü
    return _canPuani;
  }

  //setter ile can değeri değişirken oyun kurallarını denetleyelim
  set canPuani(double yenican) {
    if (yenican <= 0.0) {
      _canPuani = 0.0;
      print("$karakterAdi canı tükendi ve yere yığıldı");
    } else if (yenican > 100.0) {
      _canPuani = 100.0;
      print("Can tamamen dolu(Maksimum 100 HP)");
    } else {
      _canPuani = yenican;
    }
  }

  bool get hayattaMi {
    return _canPuani > 0.0;
  }
}

void main() {
  print("Can barı güvenlik sistemi");

  final savasciCani = CanSistemi(karakterAdi: "Meltem");
  print("Başlangıç canı: HP ${savasciCani.canPuani}");

  print("35 Hasar alındı.");
  savasciCani.canPuani = 65.0;
  print("Kalan Can: HP ${savasciCani.canPuani}");

  print("200 can veren iksir içildi");
  savasciCani.canPuani = 200.0;
  print("Sabitlenen can: HP ${savasciCani.canPuani}");

  print("Ölümcül darbe aldı ");
  savasciCani.canPuani = -50.0;
  print("Nihai can: ${savasciCani.canPuani}");
  print(
    "Savaşçı hayatta mı? : ${savasciCani.hayattaMi ? "evet" : "hayır(öldü)"}",
  );
}
