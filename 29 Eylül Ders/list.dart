void main(){

  //dinamik büyüyebilir liste
  final List<String> aktifMikroservisler=[
    "auth-service:v2.1",
    "gateway-service:v1.9",
    "payment-processor:v3.o",
  ];

  aktifMikroservisler.add("telemetry-collector:v1.0");  //listeye yeni eleman ekleme 
  print("Aktif mikroservisler (${aktifMikroservisler.length} adet) : $aktifMikroservisler");


  //sabit uzunluktaki liste (fixed-lenght), ama içi değiştirilebilir.
  final List<String> cekirdekYukDengeleyiciler = List.filled(4, "Port-kapalı",growable: false);
  cekirdekYukDengeleyiciler[0] ="LB-NODE-01; 192.168.1.11 (online)";
  cekirdekYukDengeleyiciler[1] ="LB-NODE-02; 192.168.1.10 (online)";
 // cekirdekYukDengeleyiciler.add("LB-NODE-05");  //hata verir fixed length listeye eklenemez.
  print("Çekirdek yük dengeleyici portları $cekirdekYukDengeleyiciler ");


  //programatik liste üretici 
  final List<String> kubernetsPodlari=List.generate(3, 
    (index) => "pod-node-eu-west - ${index+1} [Ram:16gb, CPU: 4 cores] ",
  
  );
  print("oluşturulan K8s Podları : $kubernetsPodlari");


  //değiştirilemez liste. ilk oluşturulduktan sonra değiştirilemez
  final List<String> guvenlikDuvariPortlari =List.unmodifiable([
    "22/TCP (SSH)",
    "443/TCP (HTTPS)",
    "6443/TCP (K8S-API)",
  ]) ;
  //guvenlikDuvariPortlari[0]="80/TCP"; //hata: cannot modifiy an unmodifiable list
  print("Güvenlik duvarı korumalı portlar:  $guvenlikDuvariPortlari");



  
  










}