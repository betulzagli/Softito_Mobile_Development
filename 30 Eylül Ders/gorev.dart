// bir canavar sınfıı tanımla soyut olarak. içinde void kükre olacak boş. ondan türeyen kurt ejderha yaz. kükreme seslerini ekrana yazdır.

abstract class Canavar{
  final String canavarAdi;

  Canavar({required this.canavarAdi,});

  void kukre();

}

class AlacaKurt extends Canavar{
  AlacaKurt({required super.canavarAdi,});

  @override  
   void kukre(){
    print("$canavarAdi dolunayda bir taşın üzerinden vadiye uludu.");
   }
}

class GuneBakanEjderha extends Canavar{
  GuneBakanEjderha({required super.canavarAdi,});

  @override  
  void kukre(){
    print("$canavarAdi bulutları yarıp gelerek havaya alev püskürttü.");
  }
}

void main() {
  print("Canavarlar");

  AlacaKurt kurt = AlacaKurt(canavarAdi: "Bolt");
  GuneBakanEjderha ejderha = GuneBakanEjderha(canavarAdi: "Elise");

  print("Kurt:");
  kurt.kukre();

  print("Ejderha:");
  ejderha.kukre();
}