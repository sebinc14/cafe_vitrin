import 'package:flutter/material.dart';

/// A widget that allows users to search through a list of products.
class SearchWidget extends StatefulWidget {
  /// The list of products to search through.
  final List<Map<String, dynamic>> products;

  /// The hint text shown in the search field.
  final String hintText;

  /// The primary color used for pricing text.
  final Color primaryColor;

  /// The accent color used for the add button.
  final Color accentColor;

  /// The dark color used for text on the add button.
  final Color darkColor;

  /// Callback triggered when a product is tapped.
  final Function(Map<String, dynamic> product)? onProductTap;

  /// Callback triggered when the add to cart button is tapped.
  final Function(Map<String, dynamic> product)? onAddToCart;

  /// Creates a new [SearchWidget].
  const SearchWidget({
    super.key,
    required this.products,
    this.hintText = "Search for coffee, dessert or snacks...",
    this.primaryColor = const Color(0xFF6B4E3D),
    this.accentColor = Colors.amber,
    this.darkColor = const Color(0xFF4E342E),
    this.onProductTap,
    this.onAddToCart,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String currentQuery = "";

  void _onSearchChanged(String query) {
    setState(() {
      currentQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Arama Çubuğu
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),

          // Arama Sonuçları Listesi
          if (currentQuery.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 280),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Builder(
                builder: (context) {
                  final docs = widget.products.where((data) {
                    final name = (data['name'] ?? '').toString().toLowerCase();
                    final category = (data['category'] ?? '')
                        .toString()
                        .toLowerCase();
                    return name.contains(currentQuery) ||
                        category.contains(currentQuery);
                  }).toList();

                  if (docs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "No results found.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: docs.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey.shade100, height: 1),
                    itemBuilder: (context, index) {
                      final data = docs[index];
                      final String imageUrl = data['imageUrl'] ?? '';
                      final String title = data['name'] ?? '';
                      final String price = "${data['price']} TL";

                      return ListTile(
                        onTap: () {
                          if (widget.onProductTap != null) {
                            widget.onProductTap!(data);
                          }
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.grey.shade200,
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      ),
                                )
                              : Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.coffee,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        title: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Text(
                          price,
                          style: TextStyle(
                            color: widget.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            if (widget.onAddToCart != null) {
                              widget.onAddToCart!(data);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: widget.accentColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: widget.darkColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
