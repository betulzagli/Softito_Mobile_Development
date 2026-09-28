   print("ilk dersimiz - dart sdk aktif olmalı");
//jsdeki gibi let x = "ahmet" ; x=42; gibi değişimleri burada kabul etmez

//1. açık belirtilen veri tipleri
 int seansSureDk=45;
double seansUcretTl=2750.50;
 String uzmanAdi="Dr Betül Zağlı";
// bool aktifMi= true;

// //2. string interpolation
// //jsdeki `${}` bunun yerine sadece $değişken veya işlem varsa ${değişken*2} kullanırız.
// print("uzman : $uzmanAdi | süre: $seansSureDk dk |ücret: $seansUcretTl tl ");
// print("kdv dahil (%20) ${seansUcretTl * 1.20} tl");

// //3. var ile tip çıkarımı
// var tedaviAdi="kahve ile peeling"; //dart bunun var ile string girildiğini otomatik algıladı ve stringe kitledi onu
// //tedaviAdi =99; hata

// //4. dynamic : veri tipini bağımsız kullanabilrsiniz ancak flutterda önerilmez
// dynamic serbestKutu="lazer epilasyon";
// serbestKutu=1000; //bu sefer hata vermedi çünkü dinamik kullan dedik. izin verilir ama veri tipi güvenliğini yok eder.

// const String KLINIK_ADI="softito güzellik merkezi";
// const double KDV_ORANI=0.20;
// //const DateTime suankiZaman=Datetime.now(); hata verir. çünkü derleme anında bunu bilemeyiz.

// //final: çalışma anında hesaplanır. bir kere atadıktan sonra değiştirilemez.
// final DateTime randevuZamani=DateTime.now();
// final String takipKodu="SOFT-" + randevuZamani.microsecondsSinceEpoch.toString();
// print("klinik adı: $KLINIK_ADI");
// print("oluşturulma tarihi: $randevuZamani | kod: $takipKodu");

//Dartta bir değişken varsayılan olarak asla null olamaz. const klinikadi=null diyemeyiz. bunun yerine null safety operatörleri kullanılır (?,??,!)
// String zorunluDanisanAdi="Betül Zağlı";
// String? danisanAlerjiNotu=null;
// print("alerji notu: $danisanAlerjiNotu");

// //ifNull operatörü: null ise varsayılan değer atama
// String goruntulenecekNot=danisanAlerjiNotu ?? "Bilinen bir alerjisi yook";
// print("rapor: $goruntulenecekNot");

// //null aware
// print("alerji metin uzunluğu : ${danisanAlerjiNotu?.length}"); //buraya ? konmazsa hta verir der ki nullun uzunluğu olamaz. ama soru işareti koyduğumuzda hata vermez.

//klasik sıralı fonksiyon
// double topla(double a,double b)=>a+b;

//modern dart / flutter standartları: named parameters({})

void seansKaydiOlustur({
  required String danisan,
  required String tedavi,
  required double birimFiyat,
  int seansSayisi = 1, //default değer
  double indirimOrani = 0.0, //default değer
  String? uzmanHekim, //null olabilir
}) {
  final double brutTutar = birimFiyat * seansSayisi;
  final double indirimTutar = indirimOrani / 100 * brutTutar;
  final double netTutar = brutTutar - indirimTutar;

  print("""

  ==============================================
  SOFTITO SEANS SÖZLEŞMESİ
  ----------------------------------------------

  Danışan               : $danisan
  Tedavi                : $tedavi (x $seansSayisi seans)
  Uzman Hekim           : ${uzmanHekim ?? "Nöbetçi Estetisyen"}
  Brüt Tutar            : $brutTutar TL
  İndirim               : -$indirimTutar TL ($indirimOrani) 
  Ödenecek Tutar        : $netTutar TL

  ==============================================

""");
}

  void main() {
    seansKaydiOlustur(
      danisan: "Sümeyye",
      tedavi: "Medikal Cilt Yenileme",
      birimFiyat: 4500,
      seansSayisi: 3,
      indirimOrani: 15.0,
      uzmanHekim: "Dr.Shahd",
    );
  }

