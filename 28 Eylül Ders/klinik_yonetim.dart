//1. enumlar (derleme zamanı güvenliği)

//enumlar aşağıdaki kodlarımızda kullanacağımız değişkenlerin alabilecekleri farklı değerleri önceden tanımlamamızı sağlar. isim karışıklıklarını da önler.
enum HizmetKategorisi { ciltYenileme, medikalEstetik, lazerEpilasyon, Lipo }

enum SeansDurumu { bekliyor, odadaIslemde, tamamlandi, iptalEdildi }

enum OdemeYontemi { krediarti, havaleEft, nakit, klinikPaketKredisi }

//danışan (müşteri) modeli
//burası bizim müşterilerimizi simüle eden sınıftır. final ile tanımlanmış özelliklere sahip olabilir.
class Danisan {
  final String id;
  final String adSoyad;
  final String telefon;
  final bool vipUyeMi;
  final List<String> alerjiler; //boş olabilir ama null olamaz
  final String? ozelCiltNotu; //opsiyonel, null olabilir. ? bu nesnenin null olabileceğini belirtir ve hataları önlemiş olur.

  //constructor. burası ilk nesne oluşturulurken olması gereken değerlerin atanıdğı yerdir. required zorunlu alanları belirler. en başta vip özelliğine false ve alerjiye boş liste atanır. cilt notu opsiyonel bırakılır.
  const Danisan({
    required this.id,
    required this.adSoyad,
    required this.telefon,
    this.vipUyeMi = false,
    this.alerjiler = const [],
    this.ozelCiltNotu,
  });

  //burası kişinin alerjisi varsa hassas ciltli olduğunu söyler ve true döner
  bool get hassasCiltMi =>
      alerjiler.isNotEmpty; //boşsa false boş değilse true olacak

  //bilgi özet kartı
  String get bilgiOzeti {
    final String alerjiBilgisi = alerjiler.isEmpty //bu satır ve devamında alerji bilgisinin kontrolü yapılır. ? ile şu denir: eğer alerjisi yoksa(çünkü isempty ile kontrol yapıyoruz) ? devamındakini çalıştır, varsa boş değilse : devamındakini çalıştır.
        ? "kayıtlı alerji yok"
        : "Alerjiler: ${alerjiler.join(",")}"; //alerji varsa joinle aralarına virgül konarak yazılır.
    final String notBilgisi = ozelCiltNotu ?? "özel medikal not girilmemiş"; //null aware ile null kontrolü yapılır. eğer soldaki değer null ise sağdakini döndürür
    final String vipRozeti = vipUyeMi ? "VIP" : "Standart"; //ternary op. vipUyeMi fonksiynunun bool değeri kontrol edilir ve vipse ? sonraki değilse : sonraki çalışır
    return "$vipRozeti $adSoyad ($telefon) | $alerjiBilgisi | Not: $notBilgisi";
  }
} //kısaca bu sınıfta müşteri bilgilerini alıp alerji kontrolü yapıyoruz ve bir bilgi kartı geri döndürüyoruz.

//seans randevu model

class SeansKaydi {
  //aşağıda bu sınıfın alabileceği değerler, özellikler tanımlanmıştır.
  final String seansKodu;
  final Danisan danisan;
  final HizmetKategorisi kategori;
  final String islemAdi;
  final double birimFiyat;
  final int seansSayisi;
  final double indirimOrani; //örnek 10.0
  final String? sorumluUzman;
  SeansDurumu durum;
  OdemeYontemi? odemeTipi;

  //constructor ile zorunlu alanlar belirlenmiştir. seans sayısına 1 atanmış, uzman serbest bırakılmış, seans durumu default bekliyor yapılmış ve odeme tipi de opsiyonel bırakılmıştır.
  SeansKaydi({
    required this.seansKodu,
    required this.danisan,
    required this.kategori,
    required this.islemAdi,
    required this.birimFiyat,
    this.seansSayisi = 1,
    this.indirimOrani = 0.0,
    this.sorumluUzman,
    this.durum = SeansDurumu.bekliyor,
    this.odemeTipi,
  });

  //aşağıda bizim hizmetlerimiz için bazı hesaplamalar yapılmıştır. basitçe brüt tutar ve indirim tutarı hesaplanmıştır.
  double get brutTutar => birimFiyat * seansSayisi;
  double get indirimTutari {
    double toplamOran = indirimOrani;
    if (danisan.vipUyeMi) {
      toplamOran += 10.0;
    }
    return brutTutar * (toplamOran / 100.0);
  }

  //yukarıda hesaplanan değerler kullanılarak net tutar hesaplaması yapılmıştır
  double get netTutar => brutTutar - indirimTutari;
}

//yönetim servisi
//burası bizim asıl işi yapan sınıfımızdır
class KlinikYoneticisi {
  //aşağıda bu classta tanımlı değişkenler tanımlanmıştır. _ private olduklarını belirtir. yani sadece bu dosya içerisinden erişilebilirler.
  final String subeAdi;
  final List<SeansKaydi> _seanslar = [];
  final Map<String, Danisan> _danisanRehberi = {};

  //şube adını zorunlu kıldık constructor içerisinde. alınması zorunlu
  KlinikYoneticisi({required this.subeAdi});

  //danışan kaydetme
  
  void danisanKaydet(Danisan danisan) { //yeni gelen müşteriyi id'sini kullanarak danisanrehberi içerisine kaydeder
    _danisanRehberi[danisan.id] = danisan;
    print(
      "Rehbere eklendi: ${danisan.adSoyad} (${danisan.vipUyeMi ? 'VIP' : 'Standart'})",
    );
  }

  void randevuOlustur(SeansKaydi seans) { //add fonksiyonu ile başta boş bıraktığımız seanslar dizisine yeni seans ekler
    _seanslar.add(seans);
    print(
      "Randevu kaydedildi: [${seans.seansKodu}] : ${seans.danisan.adSoyad} --> ${seans.islemAdi}",
    );
  }

  //seanslar listesindeki seansları dolaşır tek tek. parametre olarak gelen seans koduna eşit olan seansı bulduğunda durur ve o seansın durumunu tamamlandı olarak değiştirir. ayrıca parametreden gelen odeme tipi bilgisini de ilgili seansın odemeTipi özelliğine atar.
  void seansTamamla({required String seansKodu, required OdemeYontemi odeme}) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.tamamlandi;
        seans.odemeTipi = odeme;
        print(
          "seans tamamlandı: [${seans.seansKodu}]: ${seans.netTutar.toStringAsFixed(2)} tahsil edildi (${odeme.name})",
        );
      }
    }
    print("hata [$seansKodu] kodlu seans bulunamadı."); //eğer eşit olan kodu bulamazsa seansı da bulamamış demektir. hata fırlatır.
  }


  //seanslar listesini dolaşır tek tek. seanskodu gelen seansı bulur ve durumunu iptal edildi olarak günceller. varsa iptal nedenini ekrana yazdırır.
  void seansiIptalEt(String seansKodu, {String? iptalNedeni}) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.iptalEdildi;
        print(
          "seans iptal edildi [${seans.seansKodu}]: ${iptalNedeni ?? "gerekçe belirtilmedi"}",
        );
        return;
      }
    }
  }

  //finansal rapor metotları (fonksyonel dart)

  //seanslar listesi içerisinde durumu tamamlandı olan seansları alır. fold fonksiyonu ile başlangıcı 0 olan toplam üzerine bu seansların net tutarları eklenerek hepsi toplanır ve böylece ciro bulunur.
  double get toplamTahsilEdilenCiro => _seanslar
      .where((s) => s.durum == SeansDurumu.tamamlandi)
      .fold(0.0, (toplam, s) => toplam + s.netTutar);


  //seanslar arasından durumu bekliyor ve odada işlemde olanları alır ve yine fold ile net tutarlarını toplayarak gelecek olan ciro hesaplanır.
  double get beklenenPotansiyelCiro => _seanslar
      .where(
        (s) =>
            s.durum == SeansDurumu.bekliyor ||
            s.durum == SeansDurumu.odadaIslemde,
      )
      .fold(0.0, (toplam, s) => toplam + s.netTutar);

  //kategori bazlı seans sayıları

  //bu fonksiyon hizmet çeşitlerinin hepsinde kaç seans olduğunu bulur. önce tek tek enum içindeki hizmetleri alır sonra seansları dolaşarak hizmete göre seans sayısını bulur.
  Map<HizmetKategorisi, int> kategoriBazliSeansDagilimi() {
    final Map<HizmetKategorisi, int> dagilim = {};
    for (var kat in HizmetKategorisi.values) {
      dagilim[kat] = 0;
    }
    for (var s in _seanslar) {
      dagilim[s.kategori] = (dagilim[s.kategori] ?? 0) + 1;
    }
    return dagilim;
  }


  // bu fonksiyon seansalr listesindeki uzman isimlerini tek tek alır, null olanlar whereType<string> ile elenir ve toset ile çekilen liste küme yapılır. böylece birden fazla ismi olanlar tek sefer yazılarak temiz bir çıktı elde edilir.
  Set<String> gorevliUzmanKadrosu() {
    return _seanslar.map((s) => s.sorumluUzman).whereType<String>().toSet();
  }

  //uzmansız kalan seanslar

  //bu fonksiyonda ise sorumluUzman değeri null olanlar tek tek seanslar gezilerek bulunur ve listeye dönüştürülür.
  List<SeansKaydi> uzmansizSeanslariGetir() {
    return _seanslar.where((s) => s.sorumluUzman == null).toList();
  }

  //bu fonksiyon bizim gün sonu raporumuzu yazdıran kısımdır. 
  void gunSonuRaporuYazdir() {
    print("Günlük seans ve işlem çizelgesi");
    print("---------------------------------");
    print(
      "${'kod'.padRight((10))} |" //uzunluğu 10 karaktere sabitleyip sağından boşluk bırakır. Böylece tablo görünümü verilmiş olur.
      "${'danışan'.padRight(16)} |"
      "${'İşlem'.padRight(20)} |"
      "${'Uzman'.padRight(18)} |"
      "${'Tutar'.padRight(10)} |"
      "${'Durum'} |",
    );
    print("----------------------------------");

    // seanslar dolaşılarak uzman ve durum bilgileri alınır. durumlara göre çıktı belirlenir switch ile.
    for (var s in _seanslar) {
      final String uzman = s.sorumluUzman ?? "nöbetçi bekliyor";
      final String durumRozet = switch (s.durum) {
        SeansDurumu.tamamlandi => "tamamlandı",
        SeansDurumu.odadaIslemde => "işlemde",
        SeansDurumu.bekliyor => "bekliyor",
        SeansDurumu.iptalEdildi => "iptal",
      };

      //burada yukarıda sütunlarını oluşturduğumuz ve durum ve uzman bilgisini belirlediğimiz bilgiler ekrana tablo şeklinde yazdırılır
      print(
        "${s.seansKodu.padRight(10)} |"
        "${s.danisan.adSoyad.padRight(10)} |"
        "${s.islemAdi.padRight(10)} |"
        "${uzman.padRight(10)} |"
        "${s.netTutar.toStringAsFixed(2).padRight(10)} |"
        "$durumRozet",
      );
    }

    print("-----------------------------------------------------");
    print("finansal özet:");
    print(
      "* Gerçekleşen (kasadaki net ciro)  : ${toplamTahsilEdilenCiro.toStringAsFixed(2)} tl ",
    );
    print(
      "* Bekleyen Potansiyel Alacak  : ${beklenenPotansiyelCiro.toStringAsFixed(2)} tl ",
    );
    print("* toplam seans :  ${_seanslar.length} randevu");
    print("-----------------------------------------------------");
    print("aktif uzmanlar");
    final uzmanlar = gorevliUzmanKadrosu(); //gorevli uzman kadrosu fonksiyonundan çekilen bilgiler uzmanlara atanır
    if (uzmanlar.isEmpty) { //uzmanlar boşsa aşağıdaki mesajı döndürür
      print("kayıtlı uzman bulunamadı");
    } else {
      print("${uzmanlar.join(",")}"); //boş değilse uzmanları aralarında virgül ile yazdırır
    } 
    final uzmansizlar = uzmansizSeanslariGetir(); //uzmanı olmayan seanslar getirilir
    if (uzmansizlar.isNotEmpty) { //bu liste boş değilse aşağıdaki gibi uzunluğu alınır yani kaç seansın uzmansız olduğu. sonra da alttaki mesaj basılır.
      print(
        "dikkat: ${uzmansizlar.length} adet seansa henüz uzman atanmamıştır",
      );
    }
    for (var u in uzmansizlar) {
      print("-> [${u.seansKodu}] ${u.danisan.adSoyad} (${u.islemAdi})"); //uzmansız seans bilgileri yazdırılır
    } 
    print("-----------------------------------------------------");
  }
}

void main() {
  print("klinik yönetim sistemi başlatılıyor...");
  final yonetici = KlinikYoneticisi(subeAdi: "softito - bağcılar şubesi"); //klinikyoneticisi üzerinden nesne oluşturup şube adını veriyoruz. required yapmıştık

  //danışanları oluşturma
  //danışan nesneleri oluşturuluyor ve bilgileri giriliyor.
  final d1 = Danisan(
    id: "DAN-101",
    adSoyad: "Ahmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["retinol,asprin"],
    ozelCiltNotu: "cilt bariyeri hassas",
  );

  final d2 = Danisan(
    id: "DAN-102",
    adSoyad: "Ahmet Yılan",
    telefon: "0555 555 55 55",
    vipUyeMi: false,
    alerjiler: [],
  );

  final d3 = Danisan(
    id: "DAN-103",
    adSoyad: "mehmet yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["retinol,asprin"],
  );

  final d4 = Danisan(
    id: "DAN-104",
    adSoyad: "Ahmet memet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: [],
    ozelCiltNotu: "cilt bariyeri hassas",
  );

  //oluşturduğumuz yonetici nesnesi üzerinden kayıt fonksiyonu çalıştırılıyor ve müşteriler kaydediliyor.
  yonetici.danisanKaydet(d1);
  yonetici.danisanKaydet(d2);
  yonetici.danisanKaydet(d3);
  yonetici.danisanKaydet(d4);

  print("danışan güvenlik kontrolü");
  print(d1.bilgiOzeti);
  print(d2.bilgiOzeti);
  print("---------------------------");

  //randevular oluşturuluyor
  //randevu bilgiileri seans seans giriliyor
  final seans1 = SeansKaydi(
    seansKodu: "SNS-2026-1",
    danisan: d1,
    kategori: HizmetKategorisi.Lipo,
    islemAdi: "lipo",
    birimFiyat: 6500.0,
    seansSayisi: 2,
    indirimOrani: 5.0,
    sorumluUzman: "sümeyye",
  );

  final seans2 = SeansKaydi(
    seansKodu: "SNS-2026-2",
    danisan: d2,
    kategori: HizmetKategorisi.ciltYenileme,
    islemAdi: "siverex ile yüz temizleme",
    birimFiyat: 2500.0,
    seansSayisi: 5,
    indirimOrani: 15.0,
  );

  final seans3 = SeansKaydi(
    seansKodu: "SNS-2026-3",
    danisan: d3,
    kategori: HizmetKategorisi.lazerEpilasyon,
    islemAdi: "tüm vücut",
    birimFiyat: 25500.0,
    seansSayisi: 15,
    indirimOrani: 0.0,
    sorumluUzman: "tuba",
  );

  final seans4 = SeansKaydi(
    seansKodu: "SNS-2026-4",
    danisan: d4,
    kategori: HizmetKategorisi.medikalEstetik,
    islemAdi: "burun estetiği",
    birimFiyat: 1500.0,
    seansSayisi: 3,
    sorumluUzman: "alaaddin",
  );

  //randevular kaydediliyor
  yonetici.randevuOlustur(seans1);
  yonetici.randevuOlustur(seans2);
  yonetici.randevuOlustur(seans3);
  yonetici.randevuOlustur(seans4);
  print("seanslar gönderiliyor...");


  //seans 1 başarıyla tamamlanıyor kredi kartı ile ödeme
  //tamamlanan kayıtlar üzerinden seans işlemleri gerçekleştiriliyor.
  yonetici.seansTamamla(seansKodu: "SNS-2026-1", odeme: OdemeYontemi.krediarti);
  yonetici.seansTamamla(seansKodu: "SNS-2026-2", odeme: OdemeYontemi.nakit);
  yonetici.seansiIptalEt("SNS-2026-04",iptalNedeni: "danışanın müsaitliği ypkmuş");

  //gün sonu özeti hazırlanıyor
  yonetici.gunSonuRaporuYazdir();

}
