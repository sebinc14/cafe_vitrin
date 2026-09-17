# Cafe Widgets Kütüphanesi

Bu paket, kafe ve e-ticaret uygulamaları için özelleştirilebilir, modern arayüz bileşenleri sunar.

## Mevcut Widget'lar

Aşağıda projede yer alan temel widget'ların listesi ve ne işe yaradıklarına dair açıklamaları bulunmaktadır:

### 🌟 Temel Bileşenler
- **CustomHeader**: Uygulamanın üst kısmında yer alan; başlık, masa bilgisi, bildirim ve sepet ikonlarını barındıran özelleştirilmiş başlık çubuğudur.
- **CustomDrawerWidget**: Kullanıcı profili, moka puanları, menü sekmeleri, çıkış yapma ve garson çağırma gibi işlemleri içeren yan menü (drawer) bileşenidir.
- **FloatingCallWaiterWidget**: Kullanıcıların kolayca garson çağırabilmesi için ekranın sağ alt kısmında yüzen (floating) eylem düğmesidir.
- **SearchWidget**: Kullanıcıların kahve, tatlı veya atıştırmalık gibi ürünleri hızlıca arayabilmesini sağlayan arama çubuğu bileşenidir.

### 🛍️ Satış ve Ürün Gösterimi
- **StoryWidget**: Instagram benzeri hikaye (story) formatında kampanyaları, canlı yayınları veya duyuruları göstermeye yarar.
- **BannerCarouselWidget**: Öne çıkan kampanyaların ve duyuruların otomatik veya manuel kaydırılabilir (carousel) afişler şeklinde sunulduğu alandır.
- **FlashSaleWidget**: Sınırlı süreli indirimlerin (flash sale) bir geri sayım sayacı ile birlikte gösterildiği fırsat bileşenidir.
- **QualityAndProductsWidget**: Popüler tatlar ve öne çıkan ürünlerin listelendiği, sepete ekleme özellikli ürün sergileme widget'ıdır.
- **BaristaSuggestionWidget**: Baristanın özel tavsiyelerini veya günün favori ürünlerini şık bir şekilde sunan bileşendir.

### 🛒 Sepet ve Sipariş İşlemleri
- **CartModalWidget**: Kullanıcının sepete eklediği ürünleri, ara toplamı, indirimleri ve kazanılan Moka puanlarını gösteren özet/ödeme ekranıdır.
- **CustomizationDialogWidget**: Kullanıcıların sepete ürün eklerken (örneğin kahveye ekstra shot, süt seçimi vb.) siparişlerini özelleştirebildiği detaylı seçim penceresidir.

### 💬 Etkileşim ve Geri Bildirim
- **AnimatedRatingModal**: Sipariş sonrasında kullanıcıların deneyimlerini yıldızlarla puanlamalarını ve yorum yapmalarını sağlayan animasyonlu değerlendirme penceresidir.
- **ReviewsAndAnnouncementWidget**: Diğer müşterilerin yorumlarını listeleyen ve aynı zamanda kafenin güncel/haftalık duyurularını (örneğin canlı müzik etkinliği) gösteren bileşendir.
- **GamificationWidget**: Çarkıfelek (Wheel of Fortune) gibi oyunlaştırma ögeleri ile kullanıcılara sürpriz indirimler ve ücretsiz ürünler kazandıran interaktif etkileşim bileşenidir.

---

## Kurulum (Installation)

Paketi projenize dahil etmek için `pubspec.yaml` dosyanıza şu satırı ekleyin:

```yaml
dependencies:
  cafe_vitrin: ^1.0.0
```

Veya terminalden şu komutu çalıştırın:
```bash
flutter pub add cafe_vitrin
```

## Kullanım (Usage)

Kütüphaneyi içeri aktardıktan sonra widget'ları kolayca kullanabilirsiniz. Tüm widget'lara tek bir import üzerinden erişebilirsiniz:

```dart
import 'package:cafe_vitrin/cafe_vitrin.dart';
```

### Örnek 1: Değerlendirme Modalı (AnimatedRatingModal)
```dart
ElevatedButton(
  onPressed: () {
    AnimatedRatingModal.show(
      context, 
      "Siparis-123", 
      [{"name": "Filtre Kahve"}],
      primaryColor: Colors.brown,
      starColor: Colors.orange,
      onSubmit: (rating, comment) {
        print("Puan: $rating, Yorum: $comment");
      }
    );
  },
  child: Text("Siparişi Değerlendir"),
)
```

*(Detaylı kullanım örnekleri ve her bir widget'ın aldığı parametrelerin açıklamaları için projedeki `docs/` klasöründeki markdown (.md) belgelerine göz atabilirsiniz.)*