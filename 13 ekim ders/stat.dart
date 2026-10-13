/* 

1. createState() state oluşturudk

2. mounted==true state ağacını başlattığımızı belirtiyoruz. true bu anlama geliyor

3. initState() state çalıştırdık, stream dinlenebilir controller başlatılabilir

4. didChangeDependencies() (widget değişimlerinde tetiklenir(Thema.of(context) bu adımda güvenli olarak çalıştırılır.)) widget komple değişmedi içindeki veriler değişti

5. build(BuildContext context) (UI burada döndürür. (ASLA İÇİNDE ASENKRON İŞLEM YAPILMAZ)) ekranın ilk tasarımı oluştu ve build edip ekranı boyuyoruz. asenkron çalışsaydı en ufak güncellemede tekrar tekrar fetch yapılırdı. burası son işlemdir ekrana basılacak yerdir. burasyı apk gibi düşünebiliriz

6.didUpdateWidget(oldWidget) (üst ebeveyn yeni bir parametre yolladığında çalışır) update yolladık bu da gitti buildi tekrar çalıştırdı 

7. deactivite() (ağaçtan geçici olarak kopma) ben herhangi bir değişikliği bir süreliğine göstermek istemiyorum

8.dispose() (kalıcı olarak kapatma ağacı (controller.dispose Stream.cancel) burada yapılır) bir şeyi kalıcı olarak kapatma, instagramı kapadık örneğin. 

9. mounted == false


//state bizim işlemsel verilerle çalıştığımız yerdir. 






















*/ 