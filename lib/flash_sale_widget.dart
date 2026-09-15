import 'dart:async';
import 'package:flutter/material.dart';

class FlashSaleWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>> products;
  final Duration initialDuration;

  final Color primaryColor;
  final Color accentColor;
  final Color flashIconColor;
  final Color timerColor;
  final Color discountBadgeColor;

  final Function(Map<String, dynamic> product)? onProductTap;
  final Function(Map<String, dynamic> product)? onFavoriteToggle;
  final Function(Map<String, dynamic> product)? onAddToCart;

  const FlashSaleWidget({
    Key? key,
    this.title = "Flash Sales",
    this.subtitle = "Limited time special taste discounts",
    required this.products,
    this.initialDuration = const Duration(hours: 2, minutes: 59, seconds: 19),
    this.primaryColor = const Color(0xFF6B4E3D),
    this.accentColor = Colors.amber,
    this.flashIconColor = Colors.pink,
    this.timerColor = Colors.deepOrange,
    this.discountBadgeColor = Colors.pink,
    this.onProductTap,
    this.onFavoriteToggle,
    this.onAddToCart,
  }) : super(key: key);

  @override
  State<FlashSaleWidget> createState() => _FlashSaleWidgetState();
}

class _FlashSaleWidgetState extends State<FlashSaleWidget> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.initialDuration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        setState(() {
          _duration = _duration - const Duration(seconds: 1);
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.accentColor.withOpacity(0.4), width: 1.5),
        ),
        child: Column(
          children: [
            // Üst Başlık ve Geri Sayım Sayacı
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: widget.flashIconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.local_fire_department, color: widget.flashIconColor, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(widget.subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: widget.accentColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: widget.timerColor, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(_duration),
                          style: TextStyle(color: widget.timerColor, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Yatay Ürün Listesi
            SizedBox(
              height: 190,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final data = widget.products[index];

                  final String title = data['name'] ?? '';
                  final double oldPrice = (data['oldPrice'] ?? 0).toDouble();
                  final double newPrice = (data['price'] ?? 0).toDouble();
                  final double discount = (data['discountPercentage'] ?? 0).toDouble();
                  final String image = data['imageUrl'] ?? '';
                  final bool isFavorite = data['isFavorite'] == true;

                  return GestureDetector(
                    onTap: () {
                      if (widget.onProductTap != null) widget.onProductTap!(data);
                    },
                    child: Container(
                      width: 130,
                      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))
                        ],
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Görsel ve Rozetler
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: image.isNotEmpty
                                    ? Image.network(
                                        image, 
                                        width: double.infinity, 
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade200, child: const Center(child: Icon(Icons.image, color: Colors.grey))),
                                      )
                                    : Container(color: Colors.grey.shade200, child: const Center(child: Icon(Icons.image, color: Colors.grey))),
                                ),
                                if (discount > 0)
                                  Positioned(
                                    top: 6,
                                    left: 6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: widget.discountBadgeColor, borderRadius: BorderRadius.circular(4)),
                                      child: Text("${discount.toInt()}% Off", style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (widget.onFavoriteToggle != null) widget.onFavoriteToggle!(data);
                                    },
                                    child: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorite ? widget.discountBadgeColor : Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Alt Detaylar (Fiyat ve Buton)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${oldPrice.toStringAsFixed(2)} TL", style: const TextStyle(color: Colors.grey, fontSize: 9, decoration: TextDecoration.lineThrough)),
                                        Text("${newPrice.toStringAsFixed(2)} TL", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                      ],
                                    ),
                                    // + BUTONUNA TIKLANINCA
                                    GestureDetector(
                                      onTap: () {
                                        if (widget.onAddToCart != null) widget.onAddToCart!(data);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(color: widget.primaryColor, borderRadius: BorderRadius.circular(8)),
                                        child: const Icon(Icons.add, color: Colors.white, size: 16),
                                      ),
                                    )
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
            )
          ],
        ),
      ),
    );
  }
}