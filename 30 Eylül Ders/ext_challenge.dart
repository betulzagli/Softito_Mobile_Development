// yüzme yetisi mixi dalış yap su altına daldı
// denizci sınıfı oluştur ve mixi ekle

mixin dalisYapmaYetisi{
  void dal(){
    print("Su altına dalış yaptı.");
  }
}

class Denizci with dalisYapmaYetisi{
  final String ad;
  Denizci({required this.ad});
  void suAltinaDal(){
    print("$ad Gemiden atladı.");
    dal();
  }
}

void main(){
  final denizci = Denizci(ad: "betül");
  denizci.suAltinaDal();
}

