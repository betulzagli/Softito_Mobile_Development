void main(){
  //spread ... ...?(null mu değil mi). collection if ve collection for kullanımı

  print("Pipline Konfigürasyonu");

  final bool prodcutionMu =true;
  final bool debugLoggInAktif=false;
  final List<String>? cloudWatchEklentileri = ["datadog-agent: v7","prometheus-experter"];
  final List<String>? gecisTestYamalari=null;

  final List<String> aktifPiplineAdimlari=[
    "git-checkout",
    "security-sast-scan",

    if(prodcutionMu) "production-kms-check",
    if(debugLoggInAktif) "verbose-debug-logger" else "minified-json-logger",


    ...["docker-build","helm-chart-package"], // ... ile içine veri gömüyoruz. yani verdiğim listedeki elemanları tek tek ekle demek.

    ...?cloudWatchEklentileri, //içinde veri var ekler
    ...?gecisTestYamalari, //null olduğu için hiçbir işlem yapmaz, çökmez de. soru işareti ile zorunlu olmadığını belirttik.

  ];


  for (int i=0; i<aktifPiplineAdimlari.length; i++){
    print("Adım ${i+1} : ${aktifPiplineAdimlari[i]}");
  }

  final List<int> izinliPortlar=[8080,8443,9090];
  final List<String> firewallGuvenlikKurallari =[
    "INGRESS-DEFAULT-DROP",
    for (var port in izinliPortlar) "ALLOW-TCP_PORT-$port (VPC_INTERVAL)", //port arka planda normalde sunucu içinde çalışacak ve portlar otomatik çalışır. yani burada portu kullanmama sebebimiz bunu dosya bazında değil sunucu bazında çalıştırmak istememiz
    "EGRESS_ALL_ALLOW"
  ];

  print("Dinamik Güvenlik Kuralları (collection for ): ----");
  firewallGuvenlikKurallari.forEach((kural)=>print(" * $kural"));









}