extension oyunSayiUzantisi on int {
  String get toXpFormat {
    if(this < 1000) return "${this} XP";
    return "${(this/1000).toStringAsFixed(1)}K XP";
  }
}

extension metinSansurUzantisi on String{
  String get temizOyuncuAdi{
    if(this.toLowerCase().contains("hile")){
      return "[YASAKLI_OYUNCU]";
    }
    return "$this";
  }
}


void main(){
  print("Extension metotları (tip genişletmeleri)");

  //integer test ediliyo
  final int kazanilanXP1=450;
  final int kazanilanXP2 =12850;

  print("Görev 1 ödülü: ${kazanilanXP1.toXpFormat}");
  print("Boss savaşı : ${kazanilanXP2.toXpFormat}");

  final String oyuncu1="EjderKatili";
  final String oyuncu2="HileciAlaaddin";

  print("Kayıt 1: ${oyuncu1.temizOyuncuAdi}");
  print("Kayıt 2: ${oyuncu2.temizOyuncuAdi}");
}