//mixing and with. mixing ile sınıf hiyearşisine girmeden kod paylaşımı yapıcaz

mixin ucmaYetisi{
  int ucusIrtifasiMetre=100;

  void gogeYuksel(){
    print("Uçuş yetisi : Kanatlarını açtı ve $ucusIrtifasiMetre metreye yükseldi");
  }
}

mixin gorunmezlikYetisi{
  void pelerinOrt(){
    print("Görünmezlik: Düşmanların gözünden tamamen kayboldu!");
  }
}

mixin AtesGucuYetisi{
  void alevSaldirisi(){
    print("Ateş gücü: Kılıcını alevlendirdi ve alanı yaktı.");
  }
}

class TemelKarakter{
  final String ad;
  TemelKarakter({required this.ad});
}

class EfsaneviEjderBinicisi extends TemelKarakter with ucmaYetisi, AtesGucuYetisi{
  final String ejderAdi;
  EfsaneviEjderBinicisi({required this.ejderAdi,required super.ad});

  void hucumEt(){
    print("$ad ve ejderhası $ejderAdi savaşa atılıyor.");
    gogeYuksel();
    alevSaldirisi();
  }
}

class GolgeSuikastcisi extends TemelKarakter with gorunmezlikYetisi{
  GolgeSuikastcisi({required super.ad});

  void suikastYap(){
    print("$ad hedefe sessizce yaklaşıyor");
    pelerinOrt();
    print("kritik darbe vurdu.");
  }
}

void main(){
  print("Süper güçler başlatılıyor...");
  final birinci=EfsaneviEjderBinicisi(ejderAdi: "aslıhan", ad: "Gencer");
  birinci.hucumEt();

  final ikinci=GolgeSuikastcisi(ad: "Adil Murat");
  ikinci.suikastYap();
}