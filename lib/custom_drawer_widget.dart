import 'package:flutter/material.dart';

class DrawerMenuItem {
  final IconData icon;
  final String title;
  final Color? iconColor;
  final Widget? trailingWidget;
  final VoidCallback onTap;

  const DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.trailingWidget,
  });
}

class CustomDrawerWidget extends StatelessWidget {
  final String activeTable;
  final String userName;
  final String userEmail;
  final String avatarLetter;
  final String userRoleBadge;
  
  final int loyaltyStamps;
  final int maxLoyaltyStamps;
  final int totalMokaPoints;
  final String rewardReadyText;
  final String rewardNotReadyText;
  
  final String callWaiterText;
  final String logoutText;
  final String networkName;
  final String appVersion;
  
  final Color backgroundColor;
  final Color primaryColor;
  final Color accentColor;
  final Color cardBackgroundColor;
  final Color badgeColor;

  final List<DrawerMenuItem> menuItems;

  final VoidCallback? onCallWaiterTap;
  final VoidCallback? onLogoutTap;
  final VoidCallback? onCloseTap;

  const CustomDrawerWidget({
    Key? key,
    required this.activeTable,
    required this.userName,
    required this.userEmail,
    required this.avatarLetter,
    required this.loyaltyStamps,
    required this.totalMokaPoints,
    required this.menuItems,
    this.maxLoyaltyStamps = 5,
    this.userRoleBadge = "Moka Gold",
    this.rewardReadyText = "6th Coffee is on Us!",
    this.rewardNotReadyText = "Buy 5 Coffees Get 1 Free",
    this.callWaiterText = "Call Waiter",
    this.logoutText = "Logout",
    this.networkName = "MokaMola_Guest",
    this.appVersion = "v1.4.2",
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.primaryColor = const Color(0xFF6B4E3D),
    this.accentColor = Colors.amber,
    this.cardBackgroundColor = Colors.white,
    this.badgeColor = Colors.amber,
    this.onCallWaiterTap,
    this.onLogoutTap,
    this.onCloseTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRewardReady = loyaltyStamps >= maxLoyaltyStamps;
    double progressValue = (loyaltyStamps / maxLoyaltyStamps).clamp(0.0, 1.0);

    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          // 1. ÜST BİLGİ ALANI
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16, bottom: 20),
            decoration: BoxDecoration(color: primaryColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: accentColor, width: 2), color: Colors.white24),
                  child: Text(
                    avatarLetter,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(userEmail, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(12)),
                            child: Text(userRoleBadge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                            child: Text(activeTable, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onCloseTap ?? () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.close, color: Colors.white, size: 16),
                  ),
                )
              ],
            ),
          ),

          // 2. KAYDIRILABİLİR İÇERİK ALANI
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Puan Kartı
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: cardBackgroundColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.card_giftcard, color: accentColor, size: 18),
                                const SizedBox(width: 8),
                                const Icon(Icons.local_cafe_outlined, color: Colors.grey, size: 18),
                                const SizedBox(width: 8),
                                Text(isRewardReady ? rewardReadyText : rewardNotReadyText, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isRewardReady ? Colors.green.shade700 : Colors.black87)),
                              ],
                            ),
                            Text("$loyaltyStamps / $maxLoyaltyStamps", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(value: progressValue, backgroundColor: Colors.grey.shade200, valueColor: AlwaysStoppedAnimation<Color>(isRewardReady ? Colors.green : primaryColor), minHeight: 6),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Progress: ${(progressValue * 100).toInt()}%", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("$totalMokaPoints Total Moka Points", style: TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ANA MENÜ ÖĞELERİ
                  ...menuItems.map((item) => _buildMenuItem(
                    icon: item.icon,
                    title: item.title,
                    iconColor: item.iconColor ?? Colors.grey,
                    trailingWidget: item.trailingWidget,
                    onTap: item.onTap,
                  )).toList(),
                ],
              ),
            ),
          ),

          // 3. ALT BÖLÜM
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBackgroundColor,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onCallWaiterTap,
                    icon: Icon(Icons.pan_tool_alt, color: accentColor, size: 18),
                    label: Text("$callWaiterText ($activeTable)", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                // Çıkış Yap Butonu 
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: onLogoutTap,
                      icon: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
                      label: Text(logoutText, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red.withOpacity(0.05),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.wifi, color: Colors.green, size: 16), 
                        const SizedBox(width: 6), 
                        Text(networkName, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold))
                      ]
                    ),
                    Text(appVersion, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // YARDIMCI WİDGETLAR
  Widget _buildMenuItem({required IconData icon, required String title, required Color iconColor, Widget? trailingWidget, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: cardBackgroundColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 22),
        title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
        trailing: trailingWidget ?? const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        dense: true,
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        onTap: onTap,
      ),
    );
  }
}