import 'package:flutter/material.dart';

import 'custom_header.dart';
import 'search_widget.dart';
import 'story_widget.dart';
import 'banner_carousel_widget.dart';
import 'flash_sale_widget.dart';
import 'barista_suggestion_widget.dart';
import 'quality_and_products_widget.dart';
import 'custom_drawer_widget.dart';
import 'floating_call_waiter_widget.dart';

void main() {
  runApp(const CafeBuilderApp());
}

class CafeBuilderApp extends StatelessWidget {
  const CafeBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Vitrin Builder',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFE5E5E5), // Koyu gri arka plan
        dividerTheme: const DividerThemeData(space: 1, thickness: 1, color: Color(0xFFE0E0E0)),
      ),
      home: const BuilderHomePage(),
    );
  }
}

class BuilderHomePage extends StatefulWidget {
  const BuilderHomePage({super.key});

  @override
  State<BuilderHomePage> createState() => _BuilderHomePageState();
}

class _BuilderHomePageState extends State<BuilderHomePage> {
  // --- STATE DEĞİŞKENLERİ ---
  String _headerTitle = "Moka Mola";
  String _headerSubtitle = "CAFE";
  String _searchHint = "Kahve, tatlı ara...";
  String _baristaProductName = "Barista's Special Coffee of the Week";
  double _baristaPrice = 85.0;
  String _bannerTitle = "Summer Deals";
  String _bannerSubtitle = "Tüm soğuk içeceklerde %20 indirim!";

  // Text Controller'lar (Kullanıcı yazarken imlecin kaybolmaması için)
  late TextEditingController _titleCtrl;
  late TextEditingController _subtitleCtrl;
  late TextEditingController _searchHintCtrl;
  late TextEditingController _baristaNameCtrl;
  late TextEditingController _baristaPriceCtrl;
  late TextEditingController _bannerTitleCtrl;
  late TextEditingController _bannerSubCtrl;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: _headerTitle);
    _subtitleCtrl = TextEditingController(text: _headerSubtitle);
    _searchHintCtrl = TextEditingController(text: _searchHint);
    _baristaNameCtrl = TextEditingController(text: _baristaProductName);
    _baristaPriceCtrl = TextEditingController(text: _baristaPrice.toString());
    _bannerTitleCtrl = TextEditingController(text: _bannerTitle);
    _bannerSubCtrl = TextEditingController(text: _bannerSubtitle);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _subtitleCtrl.dispose();
    _searchHintCtrl.dispose();
    _baristaNameCtrl.dispose();
    _baristaPriceCtrl.dispose();
    _bannerTitleCtrl.dispose();
    _bannerSubCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 1. SOL PANEL (INSPECTOR / BUILDER)
          Container(
            width: 320,
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7F7),
              border: Border(right: BorderSide(color: Color(0xFFDCDCDC))),
            ),
            child: Column(
              children: [
                // Mac Stili Üst Bar
                _buildMacHeader(),
                const Divider(height: 1),
                
                // Genişletilebilir Menüler (Accordion)
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildHeaderConfig(),
                      _buildSearchConfig(),
                      _buildBannerConfig(),
                      _buildBaristaConfig(),
                      // Tıklanamayan boş menüler (Görsellik için)
                      _buildEmptyTile("STORY"),
                      _buildEmptyTile("FLASH SALE"),
                      _buildEmptyTile("PRODUCTS"),
                      _buildEmptyTile("DIVIDER"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // 2. ORTA ALAN (CANLI ÖNİZLEME)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: MobileMockup(
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    drawer: CustomDrawerWidget(
                      activeTable: 'Table 5',
                      userName: "Misafir",
                      userEmail: "misafir@example.com",
                      avatarLetter: "M",
                      loyaltyStamps: 3,
                      totalMokaPoints: 120,
                      menuItems: [
                        DrawerMenuItem(icon: Icons.person_outline, title: "Profilim", onTap: () {}),
                      ],
                      onCallWaiterTap: () {},
                      onLogoutTap: () {},
                    ),
                    body: ListView(
                      children: [
                        CustomHeader(
                          title: _headerTitle,
                          subtitle: _headerSubtitle,
                          activeTable: 'Table 5',
                          totalItemCount: 3,
                        ),
                        SearchWidget(
                          hintText: _searchHint,
                          products: const [],
                          onProductTap: (p) {},
                        ),
                        const SizedBox(height: 16),
                        const StoryWidget(
                          stories: [
                            {"image": "https://images.unsplash.com/photo-1511920170033-f8396924c348?w=250&q=80", "title": "New", "isLive": true},
                          ],
                        ),
                        const SizedBox(height: 16),
                        BannerCarouselWidget(
                          banners: [
                            {
                              "imageUrl": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=800&q=80",
                              "tagText": "NEW",
                              "title": _bannerTitle,
                              "subtitle": _bannerSubtitle,
                            },
                          ],
                        ),
                        const SizedBox(height: 16),
                        BaristaSuggestionWidget(
                          productName: _baristaProductName,
                          description: "Özenle seçilmiş kahve çekirdekleri.",
                          imageUrl: "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=600&q=80",
                          price: _baristaPrice,
                          onTap: () {},
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                    floatingActionButton: FloatingCallWaiterWidget(
                      activeTable: 'Table 5',
                      onCallWaiter: () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- SOL PANEL BİLEŞENLERİ ---

  Widget _buildMacHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Row(
            spacing: 6,
            children: [
              CircleAvatar(radius: 5, backgroundColor: Colors.red[400]),
              CircleAvatar(radius: 5, backgroundColor: Colors.orange[400]),
              CircleAvatar(radius: 5, backgroundColor: Colors.green[400]),
            ],
          ),
          const SizedBox(width: 16),
          const Text("Widgets", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text("47", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildTileTitle(String title) {
    return Row(
      children: [
        const Icon(Icons.apps, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: 0.5)),
      ],
    );
  }

  Widget _buildEmptyTile(String title) {
    return ExpansionTile(
      title: _buildTileTitle(title),
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      children: const [Padding(padding: EdgeInsets.all(16.0), child: Text("Coming soon..."))],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(4)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHeaderConfig() {
    return ExpansionTile(
      title: _buildTileTitle("HEADER"),
      initiallyExpanded: true,
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("Cafe Title", _titleCtrl, (val) => setState(() => _headerTitle = val)),
        _buildTextField("Subtitle", _subtitleCtrl, (val) => setState(() => _headerSubtitle = val)),
      ],
    );
  }

  Widget _buildSearchConfig() {
    return ExpansionTile(
      title: _buildTileTitle("SEARCH"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("Hint text", _searchHintCtrl, (val) => setState(() => _searchHint = val)),
      ],
    );
  }

  Widget _buildBannerConfig() {
    return ExpansionTile(
      title: _buildTileTitle("BANNER CAROUSEL"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("Banner Title", _bannerTitleCtrl, (val) => setState(() => _bannerTitle = val)),
        _buildTextField("Banner Subtitle", _bannerSubCtrl, (val) => setState(() => _bannerSubtitle = val)),
      ],
    );
  }

  Widget _buildBaristaConfig() {
    return ExpansionTile(
      title: _buildTileTitle("BARISTA SUGGESTION"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("Product Name", _baristaNameCtrl, (val) => setState(() => _baristaProductName = val)),
        _buildTextField("Price", _baristaPriceCtrl, (val) {
          setState(() {
            _baristaPrice = double.tryParse(val) ?? 0.0;
          });
        }),
      ],
    );
  }
}

/// A container that visually simulates a mobile phone screen.
class MobileMockup extends StatelessWidget {
  final Widget child;
  const MobileMockup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 844, // iPhone 12/13 proportions
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 30, offset: Offset(0, 15)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: child,
      ),
    );
  }
}
