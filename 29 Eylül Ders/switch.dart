enum OlaySeviyesi{info,warning,error,critical}

String alarmKanaliniBelirle(OlaySeviyesi seviye,int tekrarSayisi){
  return switch(seviye){
    OlaySeviyesi.info=>"dev-logs",
    OlaySeviyesi.warning=>"dev-warning",
    OlaySeviyesi.error when tekrarSayisi >= 5 => "sms veya email (mükerrer hata)",
    OlaySeviyesi.error => "email: dev@site.com",
    OlaySeviyesi.critical => "ACİL DURUM : kriz odası otomatik node kapanışı",
  };
}


String httpKoduYorumla(int kod){
  return switch(kod){
    >= 200 && <300 =>"2xx Başarılı İstek",
    >= 400 && <500 =>"4xx istemci hatası (client error)",
    >= 500 && <600 =>"5xx sunucu hatası (internal server error)",
    _ => "tanımsız hata kodu",
  };
}

void main(){
  print("switch expressions ");
  print("warning kanalı      :${alarmKanaliniBelirle(OlaySeviyesi.warning, 1)}");
  print("tekil error kanalı      :${alarmKanaliniBelirle(OlaySeviyesi.error, 2)}");
  print("5 kez tekrarlanan error kanalı      :${alarmKanaliniBelirle(OlaySeviyesi.error, 5)}");
  print("kritik kanalı      :${alarmKanaliniBelirle(OlaySeviyesi.critical, 1)}");

  print("http 204: ${httpKoduYorumla(204)}");
  print("http 404: ${httpKoduYorumla(404)}");
  print("http 502: ${httpKoduYorumla(502)}");
}