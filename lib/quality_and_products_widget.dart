import 'package:flutter/material.dart';

class QualityAndProductsWidget extends StatelessWidget {
  final String sectionTitle;
  final String viewAllText;
  final String categoryEmptyText;
  
  final List<Map<String, dynamic>> products;
  
  final Color titleColor;
  final Color viewAllColor;
  final Color priceColor;
  final Color buttonTextColor;
  final Color buttonBorderColor;
  final Color iconColor;
  final Color favoriteIconColor;

  final Function(Map<String, dynamic> product)? onProductTap;
  final Function(Map<String, dynamic> product)? onFavoriteToggle;
  final Function(Map<String, dynamic> product)? onAddToCart;
  final VoidCallback? onViewAllTap;

  const QualityAndProductsWidget({
    super.key,
    required this.products,
    this.sectionTitle = "Popular Tastes",
    this.viewAllText = "View All",
    this.categoryEmptyText = "No products found in category.",
    this.titleColor = Colors.black87,
    this.viewAllColor = Colors.brown,
    this.priceColor = Colors.brown,
    this.buttonTextColor = Colors.brown,
    this.buttonBorderColor = Colors.amber,
    this.iconColor = Colors.amber,
    this.favoriteIconColor = Colors.redAccent,
    this.onProductTap,
    this.onFavoriteToggle,
    this.onAddToCart,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: titleColor),
              ),
              GestureDetector(
                onTap: onViewAllTap,
                child: Text(
                  viewAllText,
                  style: TextStyle(color: viewAllColor, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (products.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.search_off, color: Colors.grey.shade400, size: 48),
                    const SizedBox(height: 12),
                    Text(categoryEmptyText, style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.78,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final title = product["name"] ?? "";
                final price = product["price"] != null ? "${product["price"]} TL" : "";
                final image = product["imageUrl"] ?? "";
                final description = product["description"] ?? "";
                final bool isFavorite = product["isFavorite"] == true;
                final String rating = product["rating"]?.toString() ?? "4.8";

                return GestureDetector(
                  onTap: () {
                    if (onProductTap != null) onProductTap!(product);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: image.isNotEmpty 
                                  ? Image.network(
                                      image, 
                                      width: double.infinity, 
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, _, _) => Container(color: Colors.grey.shade200, child: const Icon(Icons.image_not_supported, color: Colors.grey)),
                                    )
                                  : Container(color: Colors.grey.shade200, child: const Center(child: Icon(Icons.image, color: Colors.grey))),
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: iconColor, size: 12),
                                      const SizedBox(width: 4),
                                      Text(rating, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    if (onFavoriteToggle != null) onFavoriteToggle!(product);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)]),
                                    child: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorite ? favoriteIconColor : Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.2), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 2),
                              Text(description, style: const TextStyle(color: Colors.grey, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(price, style: TextStyle(color: priceColor, fontWeight: FontWeight.bold, fontSize: 14)),
                                  GestureDetector(
                                    onTap: () {
                                      if (onAddToCart != null) onAddToCart!(product);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(border: Border.all(color: buttonBorderColor), borderRadius: BorderRadius.circular(12)),
                                      child: Text("+ Add", style: TextStyle(color: buttonTextColor, fontWeight: FontWeight.bold, fontSize: 11)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}