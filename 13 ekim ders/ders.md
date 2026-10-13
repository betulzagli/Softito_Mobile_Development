1. Widget Tree -- hafif ve ucuzdur
*İskelet
*immutable(değişmez)
*çok ucuz hafif ve maaliyetsizdir.
*saniyede 60-120 kez (120 fps) üretilir ve çöpe atılır.
*widgetlar ekranda çizim yapmaz.
*sadece şablon sunar.
*yeni bri ekran gönderildiğinde güncelleme yapılmaz, silinir tamamen sonra yenisi üretilir.


2. Element Tree
*yönetici bölümü yani yaşayan iskeletin omurgası
*mutable : durumu ve referansı değişebilir. durumu ve referansı hafızada canlı tutar.
*widget ile renderobject arasındaki koordinatördür. (organizasyonu sunar)
*widgeti alır içine veri gömer ekrana basar.


örnek: oyunda önümğze bakıyoruz saniyede 120 kere widget geliyor, sağa döndük önce element geldi widget doldurdu sonra o da saniyede 120 kez gelmeye başladı. önceden baktığımız yerdeki element duruyor ama widget çalışmıyor artık.

flutter sektörde daha çok şu alanlarda kullanılır: oyun sektörü 120 fps olduğu için flutterı çok fazla kullanır.


//canUpdate 
//aşağıdaki kod çok basit olduğu için ramden çok az yer. 
//eşitse saniyede 120 kez günceller, eşit değilse güncellemez.
//keyler eşitse widget çöpe atılır güncellenir, eşit değilse element güncellenir.
static bool canUpdate(Widget oldWidget, Widget newWidget){
    return oldWidget.runtimeType=newWidget.runtimeType && oldWidget.key ==newWidget.key;
}

