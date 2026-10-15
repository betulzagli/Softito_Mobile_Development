//kod tekrarını engellemek ve kodları farklı yerlerde kullanmak
class TemelSavasci{
  final String ad;
  final double temelGuc;

  TemelSavasci({
    required this.ad,
    required this.temelGuc,
  });


  void saldir(){
    print("[$ad] temel fiziksel yumruk attı. Hasar: $temelGuc");
  }

}

class Buyucu extends TemelSavasci{
  int manaPuani;

  Buyucu({
    required this.manaPuani,
    required super.ad,
    required super.temelGuc,
  });

  @override 
    void saldir(){
      if(manaPuani>=10){
        manaPuani-=10;
        print("[$ad] alev topu fırlattı: Hasar-> ${temelGuc*2}. Kalan mana: $manaPuani");
      }else{
        print("Mana tükendi");
        super.saldir();
      }
      
    }
}

class Okcu extends TemelSavasci{
  int okSayisi;

  Okcu({
    required this.okSayisi,
    required super.ad,
    required super.temelGuc,
  });

  @override  
    void saldir(){
      if(okSayisi >0 ){
        okSayisi -=1;
        print("[$ad] hedefe zehirli ok fırlattı. Hasar-> ${temelGuc*1.5}. Kalan Ok Sayisi: $okSayisi");
      }else{
        print("Ok Bitti.");
        super.saldir();
      }
    }
}

void main(){
  print("Savaş Arenası");
  final asker = TemelSavasci(ad: "Ayberk", temelGuc: 20.0);
  //yumruk atar
  asker.saldir();

  print("------------------------------");
  
  final merlin = Buyucu(manaPuani: 20, ad: "Sümeyye", temelGuc: 40);
  merlin.saldir();

  print("-------------------------------");
  final legolas = Okcu(okSayisi: 5, ad: "Zelal", temelGuc: 35);
  legolas.saldir();
}