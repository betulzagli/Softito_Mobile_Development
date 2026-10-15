class SunucuMetrigi{
  final String hostAdi;
  final String bolge;
  final double cpuYuzdesi;
  final double ramGb;
  final int aktifBaglantiSayisi;
  final bool kritikMi;

  const SunucuMetrigi({
    required this.hostAdi,
    required this.bolge,
    required this.cpuYuzdesi,
    required this.ramGb,
    required this.aktifBaglantiSayisi,
    this.kritikMi=false,
  });

  @override //string olarak gelecek şeyi daha düzgün yazılması için override ettik
  String toString()=> "$hostAdi [$bolge] (CPU: %$cpuYuzdesi, ram: ${ramGb} GB, Conn: $aktifBaglantiSayisi)";
}

void main(){
  print("cloud temelleri");


  final List<SunucuMetrigi> sunucuKumesi =[
    SunucuMetrigi(hostAdi: "srv-eu-1", bolge: "eu-west", cpuYuzdesi: 45.2, ramGb: 16.0, aktifBaglantiSayisi: 1200,kritikMi: true),
    SunucuMetrigi(hostAdi: "srv-eu-2", bolge: "eu-west", cpuYuzdesi: 88.5, ramGb: 32.0, aktifBaglantiSayisi: 4500,kritikMi: true),
    SunucuMetrigi(hostAdi: "srv-us-1", bolge: "us-east", cpuYuzdesi: 22.0, ramGb: 8.0, aktifBaglantiSayisi: 450,kritikMi: false),
    SunucuMetrigi(hostAdi: "srv-us-2", bolge: "us-east", cpuYuzdesi: 94.6, ramGb: 64.0, aktifBaglantiSayisi: 8900,kritikMi: true),
    SunucuMetrigi(hostAdi: "srv-ap-1", bolge: "ap-south", cpuYuzdesi: 62.4, ramGb: 16.0, aktifBaglantiSayisi: 2000,kritikMi: false),
  ];


  //where ile filtreleme: cpu kullanımı %80 üzerinde olan sunucular
  final asiriYukluSunucular =sunucuKumesi.where((s)=>s.cpuYuzdesi >=80.0).toList();
  print("aşırı yüklü sunucular: (${asiriYukluSunucular.length})");
  asiriYukluSunucular.forEach((s)=>print("* $s"));

  //map ile dönüştürme. sunucu adları ve bağlantı sayılarını alarm etiketine çevirme
  final List<String> alarmEtiketleri = sunucuKumesi.map((s)=>"[Alert Monitor] ${s.hostAdi.toUpperCase()} -> Aktif Trafik ${s.aktifBaglantiSayisi}").toList();
  print("Alarm Çıktıları (ilk 3)");
  alarmEtiketleri.take(3).forEach((e)=>print(" $e"));

  //fold ile 
  final int toplamBaglantiSayisi= sunucuKumesi.fold(0, (toplam,sunucu) => toplam +sunucu.aktifBaglantiSayisi,);
  print("toplam bağlantı sayısı: $toplamBaglantiSayisi");

  //every ve any kullanımı. 
  final bool tumSunucularCalisiyorMu=sunucuKumesi.every((s)=>s.ramGb >= 8.0);
  final bool tehlikeliSunucuVarMi=sunucuKumesi.any((s)=>s.cpuYuzdesi >= 90.0);
  print("Tüm sunucuların tamami en az 8gb mı? : ${tumSunucularCalisiyorMu ? 'evet' : 'hayır'}");
  print("cpu kullanımı %90'ı aşan var mı? : ${tehlikeliSunucuVarMi ? 'evet' : 'hayır'} ");



  final euWestSunuculari = sunucuKumesi.where((s)=>s.bolge=="eu-west" && s.kritikMi).toList();
  final double euWestOrtalamaCpu =euWestSunuculari.map((s)=>s.cpuYuzdesi).fold(0.0, (acc,cpu)=>acc+cpu) / euWestSunuculari.length;
  print("eu west bölgesi kritik sunucu ortalama cpu: ${euWestOrtalamaCpu.toStringAsFixed(2)}",);

  





























}