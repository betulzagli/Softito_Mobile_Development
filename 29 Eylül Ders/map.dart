//mapte veriler keyler ile eşleşecek şekilde tutulur. dictionary yapısına benzerdir. listede indekslerle tutulur. 

void main(){
print("map metriklerini görelim");


//dinamik map
final Map<String,Map<String,dynamic>> mikroservisRehberi={ //iç içe map yazdığımız için ve içteki mapi dynamic yazdığımız için iki parametreyi bu şekilde girdik
  "auth-api":{
    "port":8081,
    "saglik":"healty",
    "restartSayisi":0,
    "bellekKullanimiMB":384.5,
    "otonomOlcekleme":true,
  },

  "payment-gateway":{
    "port":8082,
    "saglik":"degraded",
    "restartSayisi":4,
    "bellekKullanimiMB":1280.0,
    "otonomOlcekleme":false,
  },
};

//mape yeni service ekleme . put if absent ile çakışmasız ekleme.
mikroservisRehberi.putIfAbsent("reporting-worker", ()=>{
  "port":9091,
  "saglik":"healty",
  "restartSayisi":1,
  "bellekKullanimiMB":512.0,
  "otonomOlcekleme":true,
},
);


//metrik güncelleme
if (mikroservisRehberi.containsKey("payment-gateway")){
  mikroservisRehberi["payment-gateway"]!["restartSayisi"] = (mikroservisRehberi["payment-gateway"]!["restartSayisi"] as int)+1; //! : bu veri null değilse demek için kullandık. null gelirse boş olarak tanımla null olarak alma demek için kullandık.
}


print("güncel servis durum raporu");
print("------------------------------");
for(var entry in mikroservisRehberi.entries){
  final String servis =entry.key;
  final Map<String,dynamic> ozet=entry.value;
  final String saglik = ozet["saglik"];
  final String durumRozet = saglik == "healty" ? "OK" : "Alert";
  print("$durumRozet ${servis.padRight(18)} | Port: ${ozet['port']} | Ram: ${ozet['bellekKullanimiMB']} MB | Restart: ${ozet['restartSayisi']}");
}



































}