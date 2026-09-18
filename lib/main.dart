import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'custom_header.dart';
import 'search_widget.dart';
import 'story_widget.dart';
import 'banner_carousel_widget.dart';
import 'flash_sale_widget.dart';
import 'barista_suggestion_widget.dart';
import 'quality_and_products_widget.dart';
import 'custom_drawer_widget.dart';
import 'floating_call_waiter_widget.dart';
import 'category_menu_widget.dart';
import 'bundle_widget.dart';
import 'coupon_widget.dart';

void main() {
  runApp(const CafeBuilderApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class CafeBuilderApp extends StatelessWidget {
  const CafeBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Vitrin Builder',
      scrollBehavior: MyCustomScrollBehavior(),
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
  String _searchHint = "Search coffee, desserts...";
  String _baristaProductName = "Barista's Special Coffee of the Week";
  double _baristaPrice = 85.0;
  String _bannerTitle = "Summer Deals";
  String _bannerSubtitle = "20% off all cold beverages!";

  // Yeni State Değişkenleri
  String _storyTitle = "New";
  bool _storyIsLive = true;
  
  String _flashSaleName = "Caramel Macchiato";
  String _flashSaleDesc = "Hot Drinks";
  double _flashSaleOldPrice = 120.0;
  double _flashSalePrice = 80.0;
  
  String _productName = "Latte";
  String _productDesc = "Espresso and milk";
  double _productPrice = 75.0;
  
  String _drawerUserName = "Guest";
  String _drawerUserEmail = "guest@example.com";
  int _drawerPoints = 120;
  String _drawerTable = "Table 5";
  
  String _bundleTitle = "Morning Bundle";
  String _couponCode = "MOKA10";
  String _couponDesc = "Use code for 10% off your first order!";

  String _storyImageUrl = "https://images.unsplash.com/photo-1511920170033-f8396924c348?w=250&q=80";
  String _bannerImageUrl = "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=800&q=80";
  String _baristaImageUrl = "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=600&q=80";
  String _flashSaleImageUrl = "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=250&q=80";
  String _productImageUrl = "https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?auto=format&fit=crop&w=250&q=80";

  List<Map<String, dynamic>> _categoryItems = [
    {"title": "Hot Drinks", "image": "https://images.unsplash.com/photo-1541167760496-1628856ab772?auto=format&fit=crop&w=150&q=80"},
    {"title": "Cold Drinks", "image": "https://images.unsplash.com/photo-1517701604599-bb29b565090c?auto=format&fit=crop&w=150&q=80"},
    {"title": "Bakery", "image": "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=150&q=80"},
    {"title": "Desserts", "image": "https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?auto=format&fit=crop&w=150&q=80"},
  ];

  List<Map<String, dynamic>> _bundleItems = [
    {"name": "Latte", "image": "https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?auto=format&fit=crop&w=150&q=80"},
    {"name": "Croissant", "image": "https://images.unsplash.com/photo-1555507036-ab1f40ce88cb?auto=format&fit=crop&w=150&q=80"},
  ];

  List<Map<String, dynamic>> _drawerItems = [
    {"icon": Icons.person_outline, "title": "My Profile"},
    {"icon": Icons.history, "title": "Order History"},
    {"icon": Icons.local_offer_outlined, "title": "Campaigns"},
    {"icon": Icons.favorite_border, "title": "Favorites"},
    {"icon": Icons.location_on_outlined, "title": "My Addresses"},
    {"icon": Icons.credit_card, "title": "Payment Methods"},
    {"icon": Icons.help_outline, "title": "Help & Support"},
    {"icon": Icons.settings, "title": "Settings"},
  ];

  // Text Controller'lar (Kullanıcı yazarken imlecin kaybolmaması için)
  late TextEditingController _titleCtrl;
  late TextEditingController _subtitleCtrl;
  late TextEditingController _searchHintCtrl;
  late TextEditingController _baristaNameCtrl;
  late TextEditingController _baristaPriceCtrl;
  late TextEditingController _bannerTitleCtrl;
  late TextEditingController _bannerSubCtrl;
  
  late TextEditingController _storyTitleCtrl;
  late TextEditingController _flashSaleNameCtrl;
  late TextEditingController _flashSaleDescCtrl;
  late TextEditingController _flashSaleOldPriceCtrl;
  late TextEditingController _flashSalePriceCtrl;
  late TextEditingController _productNameCtrl;
  late TextEditingController _productDescCtrl;
  late TextEditingController _productPriceCtrl;
  
  late TextEditingController _drawerUserNameCtrl;
  late TextEditingController _drawerUserEmailCtrl;
  late TextEditingController _drawerPointsCtrl;
  late TextEditingController _drawerTableCtrl;
  
  late TextEditingController _bundleTitleCtrl;
  late TextEditingController _couponCodeCtrl;
  late TextEditingController _couponDescCtrl;
  
  late TextEditingController _storyImageCtrl;
  late TextEditingController _bannerImageCtrl;
  late TextEditingController _baristaImageCtrl;
  late TextEditingController _flashSaleImageCtrl;
  late TextEditingController _productImageCtrl;
  
  late List<TextEditingController> _drawerItemCtrls;
  late List<TextEditingController> _drawerIconUrlCtrls;

  late List<TextEditingController> _categoryTitleCtrls;
  late List<TextEditingController> _categoryImageCtrls;

  late List<TextEditingController> _bundleNameCtrls;
  late List<TextEditingController> _bundleImageCtrls;

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
    
    _storyTitleCtrl = TextEditingController(text: _storyTitle);
    _flashSaleNameCtrl = TextEditingController(text: _flashSaleName);
    _flashSaleDescCtrl = TextEditingController(text: _flashSaleDesc);
    _flashSaleOldPriceCtrl = TextEditingController(text: _flashSaleOldPrice.toString());
    _flashSalePriceCtrl = TextEditingController(text: _flashSalePrice.toString());
    _productNameCtrl = TextEditingController(text: _productName);
    _productDescCtrl = TextEditingController(text: _productDesc);
    _productPriceCtrl = TextEditingController(text: _productPrice.toString());
    
    _drawerUserNameCtrl = TextEditingController(text: _drawerUserName);
    _drawerUserEmailCtrl = TextEditingController(text: _drawerUserEmail);
    _drawerPointsCtrl = TextEditingController(text: _drawerPoints.toString());
    _drawerTableCtrl = TextEditingController(text: _drawerTable);
    
    _bundleTitleCtrl = TextEditingController(text: _bundleTitle);
    _couponCodeCtrl = TextEditingController(text: _couponCode);
    _couponDescCtrl = TextEditingController(text: _couponDesc);
    
    _storyImageCtrl = TextEditingController(text: _storyImageUrl);
    _bannerImageCtrl = TextEditingController(text: _bannerImageUrl);
    _baristaImageCtrl = TextEditingController(text: _baristaImageUrl);
    _flashSaleImageCtrl = TextEditingController(text: _flashSaleImageUrl);
    _productImageCtrl = TextEditingController(text: _productImageUrl);
    
    _drawerItemCtrls = _drawerItems.map((item) => TextEditingController(text: item["title"] as String)).toList();
    _drawerIconUrlCtrls = _drawerItems.map((item) => TextEditingController(text: item["iconUrl"] as String? ?? "")).toList();
    
    _categoryTitleCtrls = _categoryItems.map((item) => TextEditingController(text: item["title"] as String)).toList();
    _categoryImageCtrls = _categoryItems.map((item) => TextEditingController(text: item["image"] as String)).toList();
    
    _bundleNameCtrls = _bundleItems.map((item) => TextEditingController(text: item["name"] as String)).toList();
    _bundleImageCtrls = _bundleItems.map((item) => TextEditingController(text: item["image"] as String)).toList();
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
    
    _storyTitleCtrl.dispose();
    _flashSaleNameCtrl.dispose();
    _flashSaleDescCtrl.dispose();
    _flashSaleOldPriceCtrl.dispose();
    _flashSalePriceCtrl.dispose();
    _productNameCtrl.dispose();
    _productDescCtrl.dispose();
    _productPriceCtrl.dispose();
    
    _drawerUserNameCtrl.dispose();
    _drawerUserEmailCtrl.dispose();
    _drawerPointsCtrl.dispose();
    _drawerTableCtrl.dispose();
    
    _bundleTitleCtrl.dispose();
    _couponCodeCtrl.dispose();
    _couponDescCtrl.dispose();
    
    _storyImageCtrl.dispose();
    _bannerImageCtrl.dispose();
    _baristaImageCtrl.dispose();
    _flashSaleImageCtrl.dispose();
    _productImageCtrl.dispose();
    
    for (var ctrl in _drawerItemCtrls) {
      ctrl.dispose();
    }
    for (var ctrl in _drawerIconUrlCtrls) {
      ctrl.dispose();
    }
    for (var ctrl in _categoryTitleCtrls) {
      ctrl.dispose();
    }
    for (var ctrl in _categoryImageCtrls) {
      ctrl.dispose();
    }
    for (var ctrl in _bundleNameCtrls) {
      ctrl.dispose();
    }
    for (var ctrl in _bundleImageCtrls) {
      ctrl.dispose();
    }
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
                      _buildStoryConfig(),
                      _buildFlashSaleConfig(),
                      _buildProductsConfig(),
                      _buildDrawerConfig(),
                      _buildCategoryMenuConfig(),
                      _buildBundleConfig(),
                      _buildCouponConfig(),
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
                      activeTable: _drawerTable,
                      userName: _drawerUserName,
                      userEmail: _drawerUserEmail,
                      avatarLetter: _drawerUserName.isNotEmpty ? _drawerUserName[0].toUpperCase() : "G",
                      loyaltyStamps: 3,
                      totalMokaPoints: _drawerPoints,
                      menuItems: _drawerItems.map((item) => DrawerMenuItem(
                        icon: item["icon"] as IconData?,
                        iconUrl: item["iconUrl"] as String?,
                        title: item["title"] as String,
                        onTap: () {},
                      )).toList(),
                      onCallWaiterTap: () {},
                      onLogoutTap: () {},
                    ),
                    body: ListView(
                      children: [
                        CustomHeader(
                          title: _headerTitle,
                          subtitle: _headerSubtitle,
                          activeTable: _drawerTable,
                          totalItemCount: 3,
                        ),
                        SearchWidget(
                          hintText: _searchHint,
                          products: const [],
                          onProductTap: (p) {},
                        ),
                        const SizedBox(height: 16),
                        StoryWidget(
                          stories: [
                            {"image": _storyImageUrl, "title": _storyTitle, "isLive": _storyIsLive},
                          ],
                        ),
                        const SizedBox(height: 16),
                        CategoryMenuWidget(
                          categories: _categoryItems,
                          onCategoryTap: (c) {},
                        ),
                        const SizedBox(height: 16),
                        CouponWidget(
                          code: _couponCode,
                          description: _couponDesc,
                          onCopy: () {},
                        ),
                        const SizedBox(height: 16),
                        BannerCarouselWidget(
                          banners: [
                            {
                              "imageUrl": _bannerImageUrl,
                              "tagText": "NEW",
                              "title": _bannerTitle,
                              "subtitle": _bannerSubtitle,
                            },
                          ],
                        ),
                        const SizedBox(height: 16),
                        BaristaSuggestionWidget(
                          productName: _baristaProductName,
                          description: "Carefully selected coffee beans.",
                          imageUrl: _baristaImageUrl,
                          price: _baristaPrice,
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                        BundleWidget(
                          title: _bundleTitle,
                          products: _bundleItems,
                          totalPrice: 120.0,
                          onAddBundle: () {},
                        ),
                        const SizedBox(height: 16),
                        FlashSaleWidget(
                          products: [
                            {
                              "name": _flashSaleName,
                              "description": _flashSaleDesc,
                              "oldPrice": _flashSaleOldPrice,
                              "price": _flashSalePrice,
                              "discountPercentage": _flashSaleOldPrice > 0 ? ((_flashSaleOldPrice - _flashSalePrice) / _flashSaleOldPrice * 100).roundToDouble() : 0.0,
                              "imageUrl": _flashSaleImageUrl,
                            },
                          ],
                          onProductTap: (p) => {},
                        ),
                        const SizedBox(height: 24),
                        QualityAndProductsWidget(
                          products: [
                            {
                              "name": _productName,
                              "description": _productDesc,
                              "price": _productPrice,
                              "imageUrl": _productImageUrl,
                            },
                          ],
                          onProductTap: (p) => {},
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                    floatingActionButton: FloatingCallWaiterWidget(
                      activeTable: _drawerTable,
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
        _buildTextField("Banner Image URL", _bannerImageCtrl, (val) => setState(() => _bannerImageUrl = val)),
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
        _buildTextField("Product Image URL", _baristaImageCtrl, (val) => setState(() => _baristaImageUrl = val)),
      ],
    );
  }

  Widget _buildStoryConfig() {
    return ExpansionTile(
      title: _buildTileTitle("STORY"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("Story Title", _storyTitleCtrl, (val) => setState(() => _storyTitle = val)),
        _buildTextField("Story Image URL", _storyImageCtrl, (val) => setState(() => _storyImageUrl = val)),
        SwitchListTile(
          title: const Text("Is Live?", style: TextStyle(fontSize: 14)),
          value: _storyIsLive,
          onChanged: (val) => setState(() => _storyIsLive = val),
          contentPadding: EdgeInsets.zero,
        )
      ],
    );
  }

  Widget _buildFlashSaleConfig() {
    return ExpansionTile(
      title: _buildTileTitle("FLASH SALE"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("Product Name", _flashSaleNameCtrl, (val) => setState(() => _flashSaleName = val)),
        _buildTextField("Description", _flashSaleDescCtrl, (val) => setState(() => _flashSaleDesc = val)),
        _buildTextField("Old Price", _flashSaleOldPriceCtrl, (val) => setState(() => _flashSaleOldPrice = double.tryParse(val) ?? 0.0)),
        _buildTextField("New Price", _flashSalePriceCtrl, (val) => setState(() => _flashSalePrice = double.tryParse(val) ?? 0.0)),
        _buildTextField("Product Image URL", _flashSaleImageCtrl, (val) => setState(() => _flashSaleImageUrl = val)),
      ],
    );
  }

  Widget _buildProductsConfig() {
    return ExpansionTile(
      title: _buildTileTitle("PRODUCTS"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("Product Name", _productNameCtrl, (val) => setState(() => _productName = val)),
        _buildTextField("Description", _productDescCtrl, (val) => setState(() => _productDesc = val)),
        _buildTextField("Price", _productPriceCtrl, (val) => setState(() => _productPrice = double.tryParse(val) ?? 0.0)),
        _buildTextField("Product Image URL", _productImageCtrl, (val) => setState(() => _productImageUrl = val)),
      ],
    );
  }

  Widget _buildDrawerConfig() {
    return ExpansionTile(
      title: _buildTileTitle("DRAWER & PROFILE"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("User Name", _drawerUserNameCtrl, (val) => setState(() => _drawerUserName = val)),
        _buildTextField("User Email", _drawerUserEmailCtrl, (val) => setState(() => _drawerUserEmail = val)),
        _buildTextField("Moka Points", _drawerPointsCtrl, (val) => setState(() => _drawerPoints = int.tryParse(val) ?? 0)),
        _buildTextField("Active Table", _drawerTableCtrl, (val) => setState(() => _drawerTable = val)),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Menu Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
        for (var i = 0; i < _drawerItems.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _drawerIconUrlCtrls[i],
                    onChanged: (val) {
                      setState(() {
                        _drawerItems[i]["iconUrl"] = val;
                      });
                    },
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: "Icon URL",
                      labelStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(4)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _drawerItemCtrls[i],
                    onChanged: (val) {
                      setState(() {
                        _drawerItems[i]["title"] = val;
                      });
                    },
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: "Item ${i + 1}",
                      labelStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(4)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryMenuConfig() {
    return ExpansionTile(
      title: _buildTileTitle("CATEGORY MENU"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        for (var i = 0; i < _categoryItems.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Category ${i + 1}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 4),
              _buildTextField("Title", _categoryTitleCtrls[i], (val) {
                setState(() {
                  _categoryItems[i]["title"] = val;
                });
              }),
              _buildTextField("Image URL", _categoryImageCtrls[i], (val) {
                setState(() {
                  _categoryItems[i]["image"] = val;
                });
              }),
              const Divider(),
            ],
          ),
      ],
    );
  }

  Widget _buildBundleConfig() {
    return ExpansionTile(
      title: _buildTileTitle("BUNDLE"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("Bundle Title", _bundleTitleCtrl, (val) => setState(() => _bundleTitle = val)),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Bundle Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
        for (var i = 0; i < _bundleItems.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Product ${i + 1}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 4),
              _buildTextField("Name", _bundleNameCtrls[i], (val) {
                setState(() {
                  _bundleItems[i]["name"] = val;
                });
              }),
              _buildTextField("Image URL", _bundleImageCtrls[i], (val) {
                setState(() {
                  _bundleItems[i]["image"] = val;
                });
              }),
              const Divider(),
            ],
          ),
      ],
    );
  }

  Widget _buildCouponConfig() {
    return ExpansionTile(
      title: _buildTileTitle("COUPON"),
      backgroundColor: const Color(0xFFF9F9F9),
      collapsedBackgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(16),
      children: [
        _buildTextField("Coupon Code", _couponCodeCtrl, (val) => setState(() => _couponCode = val)),
        _buildTextField("Coupon Description", _couponDescCtrl, (val) => setState(() => _couponDesc = val)),
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
