# 1. SQL CRUD Islemleri

Bir tablo olustururken, o tablonun tutacagi verilerin tiplerini ve kurallarini belirleriz. `id` alanini benzersiz bir kimlik (Primary Key) olarak ayarliyoruz. `INSERT INTO` komutu ise olusturdugumuz bu yapiya verileri yerlestirmemizi saglar.

```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO users (fullname, email)
VALUES 
    ('Ahmet Yilmaz', 'ahmet@example.com'),
    ('Ayse Demir', 'ayse@example.com'),
    ('Mehmet Can', 'mehmet@example.com');
```

Sonuc:Tabloya 3 adet kullanici eklendi.

SELECT 

`SELECT` komutu veritabanindan veri okumak icin kullanilir.

```sql
SELECT * FROM users;
```

Sonuc:Tablodaki tum kullanicilar listelendi.

UPDATE 

Var olan bir veriyi degistirmek icin `UPDATE` kullaniriz. `WHERE` kosulu ile sadece belirli bir kaydi guncelleriz.

```sql
UPDATE users
SET email = 'ahmet.yeni@example.com'
WHERE id = 1;
```

Sonuc: id degeri 1 olan kullanicinin e-posta adresi guncellendi.

DELETE 

`DELETE FROM` komutu tablodan satir silmemizi saglar. `WHERE` kosulu yazmak zorunludur.

```sql
DELETE FROM users
WHERE id = 3;
```

Sonuc:id degeri 3 olan kullanici silindi.



2. INNER JOIN

Farkli tablolardaki iliskili verileri birlestirmek icin `JOIN` komutlari kullanilir.

```sql
SELECT 
    users.fullname, 
    users.email, 
    orders.order_id
FROM users
INNER JOIN orders ON users.id = orders.user_id;
```

Nasil Calisir?
`ON users.id = orders.user_id` kosulu ile `users` tablosundaki kullanici id'si ile `orders` tablosundaki `user_id` degeri eslesen kayitlar yan yana getirilir. Boylece sadece siparisi olan kullanicilarin bilgileri ve siparis numaralari tek bir sonucta listelenir.

3. Mobil Uygulama Guvenligi

a) Ekran Goruntusu ve Ekran Kaydi
Neden onemlidir?

Kredi karti, CVV, hesap bakiyesi gibi kritik verilerin ekran kaydi veya ekran goruntusu ile sizmasini engellemek veri guvenligi icin sarttir.

Guvenlik Mekanizmasi:
Android isletim sisteminde bunu engellemek icin `FLAG_SECURE` bayragi kullanilir. 

b) Overlay Saldirilari
Nasil gerceklesir?

Kotu niyetli bir uygulama, isletim sistemindeki "Diger uygulamalarin uzerinde goster" yetkisini kullanarak gercek uygulamanin uzerine sahte bir arayuz cizer.
Ornek: Kullanici gercek bankacilik uygulamasini actigini zannederken, en ustte duran sahte bir login ekranina sifresini girer ve bilgiler dogrudan saldirgana gider.

c) Root / Jailbreak
Neden risklidir?

Bu islemler isletim sisteminin "Sandbox" (kum havuzu) guvenlik kalkanini kaldirir.
Ornek:Saldirgan, root yetkisi sayesinde normalde erisilemeyen gizli sistem klasorlerine girerek, uygulamanin yerel veritabani dosyalarini veya oturum bilgilerini kopyalayip okuyabilir.

d) SQLite ve Sifreleme
Duz metin riskleri:

Kullanici bilgileri standart bir SQLite veritabaninda duz metin olarak saklaniyorsa, cihaza erisen biri `.db` dosyasini disari aktarip tum verileri basit bir metin editorunde okuyabilir.
SQLCipher:
SQLCipher kullanildiginda veritabani dosyasi AES ile sifrelenir. Dosya calinsa bile dogru anahtar olmadan icerigi tamamen anlamsiz karakterlerden ibaret olur.

e) Access Token ve Refresh Token
Farklari:
Access Token, sunucuya yapilan isteklerde yetkilendirme saglayan kisa omurlu anahtardir. Refresh Token ise Access Token'in suresi doldugunda tekrar kullanici adi/sifre girmeden yeni bir Access Token almak icin kullanilan uzun omurlu anahtardir.

Access Token neden kisa sureli tutulabilir? Calinmasi durumunda saldirganin sistemi somurebilecegi sureyi minimuma indirmek icin.

Refresh Token neden daha guvenli bir yerde saklanmalidir? Cunku yeni Access Token'lar ureten asil kaynaktir, calinirsa saldirgan sisteme erisim saglar.

Kullanici cikis yaptiginda neden Refresh Token iptal edilebilir? Sadece cihazdan tokenlari silmek yeterli degildir. Sunucu tarafindan iptal (revoke) edilmezse, daha once bu tokeni calan bir hacker oturum kapatilsa bile sisteme girmeye devam edebilir.