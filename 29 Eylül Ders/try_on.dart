class Cloud implements Exception{
  final String hataKodu;
  final String mesaj;
  final DateTime zaman=DateTime.now();

  Cloud(this.hataKodu,this.mesaj);

  @override 
  String toString()=>"[$hataKodu] $mesaj ($zaman)";
}

class CpuOverload extends Cloud {
  final double mevcutCpu;
  final double limit;

  CpuOverload({
    required this.mevcutCpu,
    required this.limit,
  }):super("Err_cpu_overload","Cpu kullanımı eşik limitini ($limit) aştı: $mevcutCpu%");
}

class NodeUnavailable extends Cloud{
  final String nodeId;
  NodeUnavailable(this.nodeId):super("Err_node_offline","Yanıt vermiyor: $nodeId");
}

void podKaynagiTahsisEt(String podAdi, double talepEdilenCpu,double sistemKalanCpu){
  if(talepEdilenCpu <=0){
    throw Cloud("Err_invalid_param", "Talep edilen cpu pozitif bir değer olmalıdır.");
  }

  if(talepEdilenCpu >sistemKalanCpu){
    throw CpuOverload(mevcutCpu: 100-sistemKalanCpu +talepEdilenCpu, limit: 100);
  }


  print("Pod [$podAdi] başarıyla tahsis edildi. Kalan boş cpu : ${sistemKalanCpu-talepEdilenCpu}%");
}

void main(){
  print("Yönetim Paneli");
  //başarılı tahsis
  try{
    podKaynagiTahsisEt("ingress-controller", 15.0, 40.0);
  }catch(err){
    print("Hata: $err");
  }


  //cpu aşım hatası yakalama
  try{
    podKaynagiTahsisEt("ai-training-pod", 75.0, 20.0);
  }on CpuOverload catch(e){
    print("Cpu hatası yakalandı");
    print("hata kodu: ${e.hataKodu}");
    print("mesaj: ${e.mesaj}");
    print("aksiyon: Otomatik aws açma isteği gönderildi");

  }on Cloud catch(e){
    print("bulut hatası : ${e.mesaj}");
  }catch(e,stackTrace){
    print("bilinmedik sistem hatası $e");
  }finally{
    print("pod tahsis günlüğü kapatıldı");
  }

  







}