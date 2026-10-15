//dart record ve api durum kontrolü
({String nodeAdi, int statusCode, double latencyMs,bool baglantiBasarili})sunucuPingAt({ //pozisyonel record, classı oluşturmadan tüm recordaları verdik ve sonra class oluşturup içine bilgileri verdik
  required String hedefIp,
}){
  final double gecikme=24.8;
  final int kod=200;
  

  return(
    nodeAdi:"edge-router-ist-$hedefIp",
    statusCode:kod,
    latencyMs:gecikme,
    baglantiBasarili:kod==200, //burada atama yok yanlış anlaşılmasın, burada kod 200e eşit mi diye bakıyoruz. 200e eşitse true döndürüyoruz. zaten yukarıda baglantibasariliyi bool tanımlamıştık
  );

}

void main(){
  print("dart record kayıtları");

  final probeSunucu=sunucuPingAt(hedefIp: "10.0.1.50");
  print("Ip adı             : ${probeSunucu.nodeAdi}");
  print("Http Kodu          : ${probeSunucu.statusCode}");
  print("Gecikme Süresi     : ${probeSunucu.latencyMs}");
  print("Ağ durumu          : ${probeSunucu.baglantiBasarili ? "stabil" : "kopuk"}");

  //tek hamlede değişkenlere parçalama
  final(:nodeAdi,:statusCode,:latencyMs,:baglantiBasarili)= probeSunucu;
  print("değişkenler -> $nodeAdi [kod: $statusCode, gecikme: $latencyMs ms] ");


  //çoklu atama
  final (String podId, int cpuCores, double ramGb)=(
    "k8s-pod-77x",8,32.0,
  );
  print("pod özeti: $podId  |  çekirdek:  $cpuCores  |  ram:  ${ramGb}GB");

}