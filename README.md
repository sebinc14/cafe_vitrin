# Cafe Widgets Kütüphanesi

Bu paket, kafe ve e-ticaret uygulamaları için özelleştirilebilir, modern arayüz bileşenleri sunar.

## Mevcut Widget'lar

---

### AnimatedRatingModal

```dart
AnimatedRatingModal.show(
  context,
  "ORDER-123", // orderId
  ["Espresso", "Croissant"], // orderItems
  primaryColor: Colors.deepOrange,
  title: "Rate your experience",
  onSubmit: (rating, comment) {
    print("User gave $rating stars and said:$comment");
  },
);