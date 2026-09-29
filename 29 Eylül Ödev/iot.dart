enum CihazTipi {sensor,gateway,edgeServer,router}

class IotCihaz{
  final String seriNo;
  final String cihazAdi;
  final CihazTipi tip;
  final double cpuYukYuzdesi;
  final int bellekMb;
  final bool sslSertifikasiGecerliMi;
  final Set<String> acikPortlar;

  const IotCihaz({
    required this.seriNo,
    required this.cihazAdi,
    required this.tip,
    required this.cpuYukYuzdesi,
    required this.bellekMb,
    required this.acikPortlar,
    this.sslSertifikasiGecerliMi=false,
  });

  bool get guvenlikAcigiVarMi =>
    !sslSertifikasiGecerliMi ||
    acikPortlar.contains("23/TELNET");
}

final List<IotCihaz> cihazlar=[
  IotCihaz(seriNo: "S-001", cihazAdi: "Sıcaklıksensörü", tip: CihazTipi.sensor, cpuYukYuzdesi: 25.5, bellekMb: 256, acikPortlar: {"80/HTTP"},sslSertifikasiGecerliMi: true),
  IotCihaz(seriNo: "S-002", cihazAdi: "GuvenlikGateway", tip: CihazTipi.gateway, cpuYukYuzdesi: 62.3, bellekMb: 1024, acikPortlar: {"443/HTTPS"," 22/SSH"}),
  IotCihaz(seriNo: "S-003", cihazAdi: "UretimEdge01", tip: CihazTipi.edgeServer, cpuYukYuzdesi: 98.9, bellekMb: 4096, acikPortlar: {"80/HTTP"," 443/HTTPS"}),
  IotCihaz(seriNo: "S-004", cihazAdi: "AnaRouter", tip: CihazTipi.router, cpuYukYuzdesi: 45.0, bellekMb: 2048, acikPortlar: {"80/HTTP", "23/TELNET"},sslSertifikasiGecerliMi: true),
  IotCihaz(seriNo: "S-005", cihazAdi: "NemSensoru", tip: CihazTipi.sensor, cpuYukYuzdesi: 75.5, bellekMb: 128, acikPortlar: {"23/TELNET"},sslSertifikasiGecerliMi: true),
  IotCihaz(seriNo: "S-006", cihazAdi: "KameraGateway", tip: CihazTipi.gateway, cpuYukYuzdesi: 91.4, bellekMb: 2048, acikPortlar: {"443/HTTPS"}),

];

final riskliCihazBul= cihazlar.where((s)=> s.guvenlikAcigiVarMi ==true || s.cpuYukYuzdesi >=85).toList();
final double toplamBelleKullanimi = cihazlar.fold(0, (toplam,cihaz)=> toplam +cihaz.bellekMb,);

({String cihazAdi, CihazTipi tip, bool alarmDurumu})? cihazGetir({ //record dönüş tipini direkt nullable yaptım seri no bulunamazsa diye
  required String seriNo,
  required bool cihazAcikMi,
}){
  final nesne=cihazlar.firstWhere((s)=>s.seriNo== seriNo); //tek nesne döndürülmesi gerektiği için where kullanılamazmış, where kullanırsak aşağıdaki .cihazAdi gibi özelliklere erişemezmişiz

   if (!cihazAcikMi) {
    throw CihazErisilemezException(
      "Cihaz kapalı olduğu için erişilemiyor.",
    );
  }

  return(
    cihazAdi:nesne.cihazAdi,
    tip:nesne.tip,
    alarmDurumu:nesne.guvenlikAcigiVarMi == true || nesne.cpuYukYuzdesi >= 85,
  );

}

String izolasyonKoduBelirle(CihazTipi tip){
    return switch (tip) {
    CihazTipi.sensor => "ZONE-S",
    CihazTipi.gateway => "ZONE-G",
    CihazTipi.edgeServer => "ZONE-E",
    CihazTipi.router => "ZONE-R",
  };
}

class CihazErisilemezException implements Exception {
  final String mesaj;

  CihazErisilemezException(this.mesaj);

  @override
  String toString() => mesaj;
}

void main() {
  
  print("------------Riskli cihazlar--------------");

  for (var cihaz in riskliCihazBul) {
    print(
      "${cihaz.seriNo} - ${cihaz.cihazAdi} - "
      "CPU: ${cihaz.cpuYukYuzdesi}% - "
      "Güvenlik açığı: ${cihaz.guvenlikAcigiVarMi}",
    );
  }

  
  print("---------------toplam bellek kullanımı----------------");

  print("Toplam bellek kullanımı: $toplamBelleKullanimi MB");

  
  print("--------------cihaz bilgisi getirme------------------");
  

  try {
    final sonuc = cihazGetir(
      seriNo: "S-003",
      cihazAcikMi: true,
    );

    print("Cihaz adı: ${sonuc?.cihazAdi}");
    print("Cihaz tipi: ${sonuc?.tip}");
    print("Alarm durumu: ${sonuc?.alarmDurumu}");
  } catch (e) {
    print("Hata: $e");
  }

  
  print("---------------kapalı cihaz bilgisi test------------");

  try {
    final sonuc = cihazGetir(
      seriNo: "S-001",
      cihazAcikMi: false,
    );

    print("Cihaz bilgisi: $sonuc");
  } catch (e) {
    print("Yakalanan hata: $e");
  }

  
  print("-----------izolasyon testi-----------");

  for (var cihaz in cihazlar) {
    final kod = izolasyonKoduBelirle(cihaz.tip);

    print(
      "${cihaz.cihazAdi} (${cihaz.tip}) -> $kod",
    );
  }
}