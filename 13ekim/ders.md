1- Widget tree
* iskelet
* immutable (değişmez)
* çok ucuz(hafif)
* saniyede 60-120 kez çöpe atılıp yeniden üretilir
* ekranda çizim yapmaz
* sadece şablon sunar.

2. Element Tree
* Yönetici $ Yaşayan Omurga
* Mutable (durumu ve referanslı hafızzada canlı tutar değişir)
* widget ile renderobject arasındaki koordinatördür.(organizasyonu sunar)


//canUpdate

static bool canUpdate(Widget oldWidget, ,Widget newWidget){

    return oldWidget.runTimeType = newWidget.runtimeType && oldWidget.key ==newWidget.key;
}

//State Yaşam Döngüsü

* StatefulWidget immutable (olarak değişmez) her rebuild'de yeniden oluşturulur.
* State mutable (durumu saklar) rebuild sırasında çöpe atılmaz. element tarafında devam eder.
* Eğer 2 sınıf birleşik olsaydı her rebuild esnasında kullanıcı girdileri sayaçlar controllerlar vb. sıfırlanırdı. 