import 'package:flutter/material.dart';

class BaristaSuggestionWidget extends StatelessWidget {
  final String sectionTitle;
  final String productName;
  final String description;
  final String imageUrl;
  final double price;
  final String priceLabel;
  final String addButtonText;
  final bool isFavorite;

  final Color backgroundColor;
  final Color titleBadgeColor;
  final Color priceColor;
  final Color buttonColor;
  final Color favoriteIconColor;

  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onAddToCart;

  const BaristaSuggestionWidget({
    super.key,
    this.sectionTitle = "Barista's Pick of the Day",
    required this.productName,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.priceLabel = "SPECIAL PRICE",
    this.addButtonText = "Add",
    this.isFavorite = false,
    this.backgroundColor = const Color(0xFF5D4037),
    this.titleBadgeColor = Colors.amber,
    this.priceColor = Colors.amber,
    this.buttonColor = Colors.amber,
    this.favoriteIconColor = Colors.redAccent,
    this.onTap,
    this.onFavoriteToggle,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 160,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            // Sol Kısım: Görsel ve Favori Butonu
            SizedBox(
              width: 120,
              height: 136,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 120,
                          height: 136,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                        )
                      : Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                  ),
                  // Favori Butonu
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isFavorite ? favoriteIconColor : Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            
            // Sağ Kısım: Bilgiler ve Buton
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Günün Barista Önerisi Başlığı (Sarı Border)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: titleBadgeColor, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_border, color: titleBadgeColor, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          sectionTitle,
                          style: TextStyle(color: titleBadgeColor, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // Ürün Adı
                  Text(
                    productName,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Açıklama
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  
                  // Fiyat ve Ekle Butonu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Fiyat
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            priceLabel,
                            style: const TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${price.toStringAsFixed(2)} TL",
                            style: TextStyle(color: priceColor, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      
                      // Ekle Butonu
                      GestureDetector(
                        onTap: onAddToCart,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.add, color: Colors.black87, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                addButtonText,
                                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}