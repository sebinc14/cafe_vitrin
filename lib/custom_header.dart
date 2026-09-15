import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String activeTable;
  final int totalItemCount;

  final Color primaryColor;
  final Color accentColor;
  final Color badgeColor;

  final VoidCallback? onMenuTap;
  final VoidCallback? onQrTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCartTap;

  const CustomHeader({
    Key? key,
    this.title = "Moka Mola",
    this.subtitle = "CAFE",
    this.activeTable = "Table",
    this.totalItemCount = 0,
    this.primaryColor = const Color(0xFF6B4E3D),
    this.accentColor = Colors.amber,
    this.badgeColor = Colors.red,
    this.onMenuTap,
    this.onQrTap,
    this.onNotificationTap,
    this.onCartTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // HAMBURGER MENÜ IKONU (Drawer'ı açan Builder sarmalı)
            Builder(
              builder: (innerContext) {
                return GestureDetector(
                  onTap: () {
                    if (onMenuTap != null) {
                      onMenuTap!();
                    } else {
                      Scaffold.of(innerContext).openDrawer();
                    }
                  },
                  child: const Icon(Icons.menu, color: Colors.white, size: 28),
                );
              },
            ),
            const SizedBox(width: 12),
            Icon(Icons.local_cafe, color: accentColor, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, height: 1.1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: accentColor, width: 0.5),
                      ),
                      child: Text(subtitle, style: TextStyle(color: accentColor, fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(width: 8),
            
            // Masa QR Butonu
            GestureDetector(
              onTap: onQrTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.qr_code_scanner, color: accentColor, size: 14),
                    const SizedBox(width: 4),
                    Text(activeTable, style: const TextStyle(color: Colors.white, fontSize: 11)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            
            // Bildirim Zili
            GestureDetector(
              onTap: onNotificationTap,
              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 8),
            
            // Sepet Butonu 
            GestureDetector(
              onTap: onCartTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Badge(
                  isLabelVisible: totalItemCount > 0,
                  label: Text('$totalItemCount'),
                  backgroundColor: badgeColor,
                  child: Icon(Icons.shopping_bag_outlined, color: accentColor, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}