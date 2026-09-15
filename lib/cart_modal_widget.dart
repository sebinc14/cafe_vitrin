import 'package:flutter/material.dart';

class CartModalWidget {
  static void showCartScreen(
    BuildContext context, {
    bool isHome = false,
    String activeTable = "Masa",
    String deliveryAddress = "Adres",
    List<Map<String, dynamic>> cartItems = const [],
    double totalMokaPoints = 0.0,
    bool isPointsApplied = false,
    bool isCouponApplied = false,
    int appliedDiscountPercentage = 0,
    String appliedCouponCode = "",
    double couponDiscountAmount = 0.0,
    double usedPointsAmount = 0.0,
    double subtotal = 0.0,
    double finalTotalPrice = 0.0,
    Color primaryColor = const Color(0xFF6B4E3D),
    Color accentColor = Colors.amber,
    Function(int index)? onRemoveFromCart,
    Function(int index)? onIncreaseQuantity,
    Function(int index)? onDecreaseQuantity,
    Function(int index)? onEditItem,
    Function(String code)? onApplyCoupon,
    VoidCallback? onRemoveCoupon,
    VoidCallback? onTogglePoints,
    VoidCallback? onClearCart,
    VoidCallback? onCheckout,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _CartBottomSheet(
          isHome: isHome,
          activeTable: activeTable,
          deliveryAddress: deliveryAddress,
          cartItems: cartItems,
          totalMokaPoints: totalMokaPoints,
          isPointsApplied: isPointsApplied,
          isCouponApplied: isCouponApplied,
          appliedDiscountPercentage: appliedDiscountPercentage,
          appliedCouponCode: appliedCouponCode,
          couponDiscountAmount: couponDiscountAmount,
          usedPointsAmount: usedPointsAmount,
          subtotal: subtotal,
          finalTotalPrice: finalTotalPrice,
          primaryColor: primaryColor,
          accentColor: accentColor,
          onRemoveFromCart: onRemoveFromCart,
          onIncreaseQuantity: onIncreaseQuantity,
          onDecreaseQuantity: onDecreaseQuantity,
          onEditItem: onEditItem,
          onApplyCoupon: onApplyCoupon,
          onRemoveCoupon: onRemoveCoupon,
          onTogglePoints: onTogglePoints,
          onClearCart: onClearCart,
          onCheckout: onCheckout,
        );
      },
    );
  }
}

class _CartBottomSheet extends StatefulWidget {
  final bool isHome;
  final String activeTable;
  final String deliveryAddress;
  final List<Map<String, dynamic>> cartItems;
  final double totalMokaPoints;
  final bool isPointsApplied;
  final bool isCouponApplied;
  final int appliedDiscountPercentage;
  final String appliedCouponCode;
  final double couponDiscountAmount;
  final double usedPointsAmount;
  final double subtotal;
  final double finalTotalPrice;
  final Color primaryColor;
  final Color accentColor;
  
  final Function(int index)? onRemoveFromCart;
  final Function(int index)? onIncreaseQuantity;
  final Function(int index)? onDecreaseQuantity;
  final Function(int index)? onEditItem;
  final Function(String code)? onApplyCoupon;
  final VoidCallback? onRemoveCoupon;
  final VoidCallback? onTogglePoints;
  final VoidCallback? onClearCart;
  final VoidCallback? onCheckout;

  const _CartBottomSheet({
    Key? key,
    required this.isHome,
    required this.activeTable,
    required this.deliveryAddress,
    required this.cartItems,
    required this.totalMokaPoints,
    required this.isPointsApplied,
    required this.isCouponApplied,
    required this.appliedDiscountPercentage,
    required this.appliedCouponCode,
    required this.couponDiscountAmount,
    required this.usedPointsAmount,
    required this.subtotal,
    required this.finalTotalPrice,
    required this.primaryColor,
    required this.accentColor,
    this.onRemoveFromCart,
    this.onIncreaseQuantity,
    this.onDecreaseQuantity,
    this.onEditItem,
    this.onApplyCoupon,
    this.onRemoveCoupon,
    this.onTogglePoints,
    this.onClearCart,
    this.onCheckout,
  }) : super(key: key);

  @override
  State<_CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<_CartBottomSheet> {
  final TextEditingController couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deliveryText = widget.isHome ? widget.deliveryAddress : "In Cafe (${widget.activeTable})";
    final badgeText = widget.isHome ? "Home Delivery" : "Cafe Delivery";
    final icon = widget.isHome ? Icons.delivery_dining : Icons.local_cafe_outlined;

    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: widget.primaryColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                Icon(Icons.shopping_bag_outlined, color: widget.accentColor, size: 24),
                const SizedBox(width: 8),
                const Text("My Order Cart", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: widget.accentColor, borderRadius: BorderRadius.circular(12)),
                  child: Text("${widget.cartItems.length} Items", style: TextStyle(color: widget.primaryColor, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (widget.onClearCart != null) widget.onClearCart!();
                  },
                  child: Text("Clear", style: TextStyle(color: widget.accentColor, fontSize: 13)),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.white, size: 22),
                ),
              ],
            ),
          ),

          Container(
            color: Colors.orange.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: widget.primaryColor, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black87, fontSize: 13),
                      children: [
                        const TextSpan(text: "Delivery: "),
                        TextSpan(text: deliveryText, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.brown.shade200)),
                  child: Text(badgeText, style: TextStyle(color: widget.primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.cartItems.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: Text("Your cart is currently empty.", style: TextStyle(color: Colors.grey, fontSize: 15))),
                    )
                  else
                    ...List.generate(widget.cartItems.length, (index) {
                      final item = widget.cartItems[index];
                      final int qty = item["quantity"] ?? 1;
                      final String imageUrl = item["imageUrl"] ?? "";

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl,
                                    width: 60, height: 60, fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(width: 60, height: 60, color: Colors.grey.shade200, child: const Icon(Icons.coffee, color: Colors.grey)),
                                  )
                                : Container(width: 60, height: 60, color: Colors.grey.shade200, child: const Icon(Icons.coffee, color: Colors.grey)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text(item["title"]?.toString() ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                                      GestureDetector(
                                        onTap: () {
                                          if (widget.onRemoveFromCart != null) widget.onRemoveFromCart!(index);
                                        },
                                        child: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  if (item["extras"] != null && item["extras"] is List && (item["extras"] as List).isNotEmpty)
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: 6,
                                      children: (item["extras"] as List).map((extra) => _buildTag(extra.toString())).toList(),
                                    )
                                  else
                                    const SizedBox.shrink(),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${item["price"]} TL", style: TextStyle(color: widget.primaryColor, fontWeight: FontWeight.bold, fontSize: 15)),
                                          if (item.containsKey("rawCustomization")) ...[
                                            const SizedBox(height: 6),
                                            GestureDetector(
                                              onTap: () {
                                                if (widget.onEditItem != null) widget.onEditItem!(index);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.amber.shade100,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.edit, size: 12, color: widget.primaryColor),
                                                    const SizedBox(width: 4),
                                                    Text("Edit", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: widget.primaryColor))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
                                        child: Row(
                                          children: [
                                            InkWell(onTap: () {
                                              if (widget.onDecreaseQuantity != null) widget.onDecreaseQuantity!(index);
                                            }, child: const Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6), child: Icon(Icons.remove, size: 16))),
                                            Text("$qty", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                            InkWell(onTap: () {
                                              if (widget.onIncreaseQuantity != null) widget.onIncreaseQuantity!(index);
                                            }, child: const Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6), child: Icon(Icons.add, size: 16))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),

                  const SizedBox(height: 12),

                  // İNDİRİM KUPONU ALANI
                  if (widget.isCouponApplied)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.shade400, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_offer, color: Colors.green, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.appliedDiscountPercentage}% Discount (-${widget.couponDiscountAmount.toStringAsFixed(2)} TL)", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14)),
                                Text("${widget.appliedCouponCode} coupon applied.", style: const TextStyle(color: Colors.green, fontSize: 11)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (widget.onRemoveCoupon != null) widget.onRemoveCoupon!();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red,
                              elevation: 0,
                              side: BorderSide(color: Colors.red.shade200),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              minimumSize: Size.zero,
                            ),
                            child: const Text("Remove", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          )
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.local_offer_outlined, color: Colors.amber, size: 18),
                              SizedBox(width: 8),
                              Text("Discount Coupon", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: couponController,
                                  decoration: InputDecoration(
                                    hintText: "Coupon Code",
                                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    isDense: true,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: widget.cartItems.isEmpty ? null : () {
                                  final code = couponController.text.trim();
                                  if (code.isNotEmpty && widget.onApplyCoupon != null) {
                                    widget.onApplyCoupon!(code);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.primaryColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text("Apply", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 16),

                  // MOKA SADAKAT PUANI KARTI (Sidebar ile senkronize)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDF8F0),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber.shade300, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.orange.shade100, shape: BoxShape.circle),
                          child: Icon(Icons.card_giftcard, color: Colors.orange.shade700, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Moka Loyalty Points", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: widget.primaryColor)),
                              Text("Available: ${widget.totalMokaPoints.toInt()} Points (=${widget.totalMokaPoints.toInt()} TL)", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: widget.cartItems.isEmpty ? null : () {
                            if (widget.onTogglePoints != null) widget.onTogglePoints!();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.isPointsApplied ? Colors.grey.shade200 : Colors.white,
                            foregroundColor: widget.isPointsApplied ? Colors.red : widget.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            minimumSize: Size.zero,
                          ),
                          child: Text(widget.isPointsApplied ? "Cancel" : "Use Points", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal", style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text("${widget.subtotal.toStringAsFixed(2)} TL", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
                if (widget.isCouponApplied)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount (${widget.appliedDiscountPercentage}%)", style: const TextStyle(color: Colors.green, fontSize: 13)),
                        Text("-${widget.couponDiscountAmount.toStringAsFixed(2)} TL", style: const TextStyle(color: Colors.green, fontSize: 13)),
                      ],
                    ),
                  ),
                if (widget.isPointsApplied)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Used Points", style: TextStyle(color: Colors.orange, fontSize: 13)),
                        Text("-${widget.usedPointsAmount.toStringAsFixed(2)} TL", style: const TextStyle(color: Colors.orange, fontSize: 13)),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("${widget.finalTotalPrice.toStringAsFixed(2)} TL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: widget.primaryColor)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.cartItems.isEmpty ? null : () {
                      if (widget.onCheckout != null) widget.onCheckout!();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.primaryColor,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Confirm Order", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(text, style: TextStyle(color: Colors.grey.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}