//set ve ağ güvenlik kümeleri

void main(){
  print("beyaz liste ve küme analizi");

  final Set<String> istanbulVeriMerkeziIpleri={
    "10.0.1.10",
    "10.0.1.11",
    "10.0.1.12",
    "10.0.1.13",
    "10.0.1.10", //çift kayıt olarak görünür. set burayı anında tek hale getirir. çift girdilere izin vermez. 
  };

  print("İstanbul ipleri: $istanbulVeriMerkeziIpleri");

  final Set<String> frankfurtVeriMerkeziIpleri ={
    "10.0.1.13",
    "10.0.1.30",
    "10.0.1.45",
  };

  print("Frankfurt Ipleri: $frankfurtVeriMerkeziIpleri");

  //ortak olanları alma intersection
  final ortakKopruIpler=istanbulVeriMerkeziIpleri.intersection(frankfurtVeriMerkeziIpleri);
  print("ortal ağ ipleri(kesişim): $ortakKopruIpler");

  //her iki tarafta da tekil olanları alma birleşim
  final tumGlobalIpler =istanbulVeriMerkeziIpleri.union(frankfurtVeriMerkeziIpleri);
  print("Toplam global ipler: $tumGlobalIpler");

  //farklı olanları alma
  final sadeceIstanbul =istanbulVeriMerkeziIpleri.difference(frankfurtVeriMerkeziIpleri);
  print("Sadece istanbul: $sadeceIstanbul");






















}