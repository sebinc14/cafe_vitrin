import 'package:flutter/material.dart';

class BundleWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> products;
  final double totalPrice;
  final VoidCallback onAddBundle;
  final Color buttonColor;

  const BundleWidget({
    super.key,
    required this.title,
    required this.products,
    required this.totalPrice,
    required this.onAddBundle,
    this.buttonColor = Colors.deepOrange,
  });

  @override
  Widget build(BuildContext context) {
    if (products.length < 2) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var i = 0; i < products.length; i++) ...[
                    if (i > 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, color: Colors.black54, size: 16),
                          ),
                        ),
                      ),
                    _buildMiniProduct(products[i]),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Price", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        '₺${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: onAddBundle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text("Add to Cart", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniProduct(Map<String, dynamic> product) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 80,
              height: 80,
              child: product['image'] != null && product['image'].toString().isNotEmpty 
                  ? Image.network(product['image'] ?? '', fit: BoxFit.cover)
                  : Container(color: Colors.grey[300]),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product['name'] ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
