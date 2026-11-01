# Spor Salonu Üye ve Antrenman Takip Uygulaması - Mimari Taslak

## 1. Enum Yapısı (`UyelikTipi`)
Üyelerin paket sürelerini tip güvenli (type-safe) yönetmek için kullanılacak enum değerleri:
- `aylik` (1 Aylık Paket)
- `ucAylik` (3 Aylık Paket)
- `yillik` (12 Aylık Paket)

---

## 2. Veri Modeli (`UyeKaydi`) Alanları
Her bir spor salonu üyesinin sistemde tutacağı **7 temel alan** (Görev 5'teki form ve detay ekranı ihtiyaçlarına göre kurgulandı):

1. **`id`** (`String`): Üyenin benzersiz kimliği (`Hero` animasyonu etiketi ve güncelleme işlemleri için).
2. **`adSoyad`** (`String`): Üyenin adı ve soyadı (Arama çubuğunda filtreleme yapmak ve formda doğrulamak için).
3. **`yas`** (`int`): Üyenin yaşı (Form ekranında sayısal validasyon kontrolü için).
4. **`telefon`** (`String`): İletişim numarası (Form doğrulaması için).
5. **`uyelikTipi`** (`UyelikTipi`): Seçilen üyelik paketi (`ChoiceChip` filtrelemesi ve rozet gösterimi için).
6. **`kayitTarihi`** (`DateTime`): Üyeliğin başladığı veya uzatıldığı tarih (`ModalBottomSheet` içinde `copyWith` ile güncellenecek).
7. **`aktifMi`** (`bool`): Üyeliğin şu an geçerli olup olmadığını belirten durum bayrağı (`UyelikRozeti` bileşeninde renk değişimi için).

---

## 3. Klasör ve Dosya Planı (`lib/`)

### `lib/models/` (Veri Katmanı)
- `uyelik_tipi.dart`: `UyelikTipi` enum tanımı ve ekranda görünecek başlık/gün sayısı özellikleri.
- `uye_kaydi.dart`: `UyeKaydi` immutable (değişmez) veri sınıfı, `fromJson` ve `copyWith` metotları.

### `lib/services/` (Servis ve Veri Kaynağı Katmanı)
- `i_uye_servisi.dart`: Servis katmanının soyut sözleşmesi (`abstract class IUyeServisi`).
- `mock_uye_servisi.dart`: 1.2 saniye gecikmeli 10 hazır üye döndüren ve yeni üye ekleyen (`uyeEkle`) somut servis sınıfı.

### `lib/widgets/` (Tekrar Kullanılabilir Küçük Bileşenler)
- `uye_karti.dart`: Liste ekranındaki her bir üyeyi temsil eden `StatelessWidget` satır kartı.
- `uyelik_rozeti.dart`: Üyenin paketini ve aktif/pasif durumunu renkli etiketle gösteren küçük bileşen.

### `lib/screens/` (Ekranlar / Sayfalar)
- `uye_listesi_ekrani.dart`: 4 durumu (Yükleniyor, Hata, Boş, Dolu), arama çubuğunu ve `ChoiceChip` filtrelerini barındıran ana ekran.
- `yeni_uye_form_ekrani.dart`: `Form`, `GlobalKey<FormState>` ve `TextEditingController` ile yeni üye kaydı yapılan ekran.
- `uye_detay_ekrani.dart`: `Hero` animasyonu ile geçiş yapılan ve `ModalBottomSheet` üzerinden üyelik süresi uzatılan detay ekranı.