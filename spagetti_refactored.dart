class Constants{
  static const double kargoUcreti = 29.90;
  static const double kdvOrani = 0.20;
}

//////////////////////////////////////////////////////////// ÜRÜN TANIMLAMA
class Urun {
  String id;
  String ad;
  double fiyat;
  int stok;
  String tip;

  Urun(this.id, this.ad, this.fiyat, this.stok, this.tip);

}

double kargoUcretiHesapla(Urun urun) {
  if (urun.tip == "DIJITAL") {
    return 0;
  }
  return Constants.kargoUcreti;
}

class DijitalUrun extends Urun {
  DijitalUrun(String id, String ad, double fiyat, int stok)
      : super(id, ad, fiyat, stok, "DIJITAL");
  }

///////////////////////////////////////////////////////////////// SİPARİŞ İŞLEMLERİ
abstract class ISiparisKaydet{
  void siparisKaydet(String orderId, double tutar);
}

abstract class IMailGonder {
  void mailGonder(String email, String mesaj);
}

abstract class ISmsGonder {
  void smsGonder(String tel, String mesaj);
}
abstract class IKargoGonder {
  void kargoGonder(String orderId, String adres);
}
abstract class IFaturaYazdir {
  void faturaYazdir(String orderId);
}

abstract class OdemeYap{
  void odemeYap(String tip, double tutar);
}

////////////////////////////////////////////////////////// ÖDEME ÇEŞİTLERİ YÖNETİMİ
class KrediKartiOdeme implements OdemeYap{
  @override void odemeYap(String tip,double tutar) => print("$tutar TL Kredi kartindan POS ile cekildi.");
}

class HavaleOdeme implements OdemeYap{
  @override void odemeYap(String tip,double tutar) => print("$tutar TL Havale kontrol edildi.");
}

class KapidaOdeme implements OdemeYap{
  @override void odemeYap(String tip,double tutar) => print("$tutar TL Kapida odeme tahsil edilecek (Komisyon +15 TL).");
}

class CryptoOdeme implements OdemeYap{
  @override void odemeYap(String tip,double tutar) => print("$tutar TL USDT transferi onaylandi.");
}

class OdemeYontemleri {
  static OdemeYap turSec(String tip) {
    switch (tip) {
      case "KREDI_KARTI":
        return KrediKartiOdeme();
      case "HAVALE":
        return HavaleOdeme();
      case "KAPIDA_ODEME":
        return KapidaOdeme();
      case "CRYPTO":
        return CryptoOdeme();
      default:
        throw Exception("Gecersiz odeme yontemi secildi: $tip");
    }
  }
}
//////////////////////////////////////////////////////

class SqliteVeritabani {
  void kaydet(String sql) {
    print("DB calistirildi: " + sql);
  }
}

class SmtpMailServisi {
  void mailAt(String to, String body) {
    print("SMTP Mail gonderildi: " + to);
  }
}

class NetgsmSmsServisi {
  void smsYolla(String gsm, String text) {
    print("SMS iletildi: " + gsm);
  }
}
/////////////////////////////////////////////////////// STOK-SEPET KONTROLÜ
class Sepet {
  final List<Urun> urunler = [];
  double get toplamTutar {
    return urunler.fold(0, (toplam, urun) => toplam + urun.fiyat);
  }

  
  void stokKontrolunuYap() {
    for (var urun in urunler) {
      if (urun.stok <= 0) {
        throw UnimplementedError("${urun.ad} isimli ürün tükenmiş!");
      }
    }
  }

  void stokGuncelle() {
    for (var urun in urunler) {
      urun.stok--;
    }
  }
}

/////////////////////////////////////////////////////// İNDİRİM KONTROLÜ

enum Kupon {
  INDIRIM10(indirimYuzdesi: 10),
  YAZ20(indirimYuzdesi: 20),
  SEPETTE50(sabitIndirim: 50);

  final double indirimYuzdesi;
  final double sabitIndirim;

  const Kupon({this.indirimYuzdesi = 0, this.sabitIndirim = 0});

  double tutariHesapla(double tutar) {
    double dusulecekMiktar = (tutar * (indirimYuzdesi / 100)) + sabitIndirim;
    double yeniTutar = tutar - dusulecekMiktar;
    
    return yeniTutar < 0 ? 0 : yeniTutar;
  }
}

double indirimUygula(Kupon? kupon, double tutar) {
  if (kupon == null) return tutar;
  
  return kupon.tutariHesapla(tutar); 
}
///////////////////////////////////////////////////////
class SiparisYoneticisi implements ISiparisKaydet, IKargoGonder, IMailGonder, ISmsGonder, IFaturaYazdir {
  SqliteVeritabani db = SqliteVeritabani();
  SmtpMailServisi mailci = SmtpMailServisi();
  NetgsmSmsServisi smsci = NetgsmSmsServisi();

  @override
  void siparisKaydet(String orderId, double tutar) {
    db.kaydet("INSERT INTO siparisler VALUES ('$orderId', $tutar)");
  }

  void odemeYap(String tip, double tutar) {

    OdemeYap secilenOdeme = OdemeYontemleri.turSec(tip);
    secilenOdeme.odemeYap(tip, tutar);
  }

  @override
  void kargoGonder(String orderId, String adres) {
    print("MNG Kargo takip fis basildi: $adres");
  }

  @override
  void mailGonder(String email, String mesaj) {
    mailci.mailAt(email, mesaj);
  }

  @override
  void smsGonder(String tel, String mesaj) {
    smsci.smsYolla(tel, mesaj);
  }

  @override
  void faturaYazdir(String orderId) {
    print("Fatura PDF cikarildi: $orderId");
  }

  void siparisTamamla(
      String orderId,
      List<Urun> urunListesi, 
      String odemeTipi,
      String musteriAdi,
      String email,
      String tel,
      String adres,
      String kuponKodu) {
    
    
    Sepet sepet = Sepet();
    sepet.urunler.addAll(urunListesi);

    
    sepet.stokKontrolunuYap();

    
    double toplamTutar = sepet.toplamTutar;
    
    for (var urun in sepet.urunler) {
      toplamTutar += kargoUcretiHesapla(urun); 
    }

    Kupon? gecerliKupon;
    for (var kupon in Kupon.values) {
      if (kupon.name == kuponKodu) {
        gecerliKupon = kupon;
        break;
      }
    }
    toplamTutar = indirimUygula(gecerliKupon, toplamTutar);

   
    double kdv = toplamTutar * Constants.kdvOrani; 
    double sonTutar = toplamTutar + kdv;

    
    sepet.stokGuncelle();

    
    odemeYap(odemeTipi, sonTutar);
    siparisKaydet(orderId, sonTutar);
    faturaYazdir(orderId);
    mailGonder(email, "Sayin $musteriAdi, siparisiniz alindi. Tutar: $sonTutar TL");
    smsGonder(tel, "Siparisiniz onaylandi: $orderId");
    
    
    bool fizikselUrunVarMi = sepet.urunler.any((urun) => urun.tip != "DIJITAL");
    if (fizikselUrunVarMi) {
      kargoGonder(orderId, adres);
    }
  }
}

void main() {
  var siparisci = SiparisYoneticisi();

  var urun1 = Urun("1", "Kablosuz Mouse", 450.0, 5, "FIZIKSEL");
  var urun2 = DijitalUrun("2", "Flutter Kursu E-Kitap", 150.0, 100);

  var sepet = <Urun>[urun1, urun2];

  siparisci.siparisTamamla(
    "SP-9921",
    sepet,
    "KREDI_KARTI",
    "Selahaddin",
    "selahaddin@kodvance.com",
    "05551112233",
    "Kadikoy / Istanbul",
    "INDIRIM10",
  );
}