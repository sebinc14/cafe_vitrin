import 'package:flutter/material.dart';
import 'widget_config.dart';

import 'custom_header.dart';
import 'search_widget.dart';
import 'story_widget.dart';
import 'banner_carousel_widget.dart';
import 'flash_sale_widget.dart';
import 'barista_suggestion_widget.dart';
import 'quality_and_products_widget.dart';
import 'gamification_widget.dart';
import 'reviews_and_announcement_widget.dart';
import 'cart_modal_widget.dart';
import 'customization_dialog_widget.dart';
import 'animated_rating_modal.dart';
import 'custom_drawer_widget.dart';
import 'floating_call_waiter_widget.dart';

void main() {
  runApp(const CafeCustomizerApp());
}

class CafeCustomizerApp extends StatelessWidget {
  const CafeCustomizerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe UI Customizer',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: const CustomizerHomePage(),
    );
  }
}

class CustomizerHomePage extends StatefulWidget {
  const CustomizerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomizerHomePage> createState() => _CustomizerHomePageState();
}

class _CustomizerHomePageState extends State<CustomizerHomePage> {
  // Global Özelleştirme Ayarları (Patronun değiştirebileceği alanlar)
  final Map<String, dynamic> _customizations = {
    'cafeTitle': 'Moka Mola',
    'cafeSubtitle': 'CAFE',
    'activeTable': 'Table 5',
    'searchHint': 'Search for coffee, dessert...',
    'bannerTitle': 'Summer Deals',
    'baristaProduct': "Barista's Special Coffee of the Week",
    'baristaPrice': 85.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafe Arayüz Özelleştirici'),
        actions: [
          // Sağ üstte ayarlar panelini açan buton
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.tune, size: 28),
              tooltip: 'Tasarımı Özelleştir',
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      // SAĞ TARAF: Özelleştirme Paneli (Görseldeki sağ panelin birebir aynısı)
      endDrawer: Drawer(
        width: 350,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.brown),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Tasarım Yönetim Paneli', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Metinleri ve ayarları anlık değiştirebilirsiniz.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const Text("1. Header (Başlık) Ayarları", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
            TextField(
              controller: TextEditingController(text: _customizations['cafeTitle']),
              decoration: const InputDecoration(labelText: 'Kafe Adı'),
              onChanged: (val) => setState(() => _customizations['cafeTitle'] = val),
            ),
            TextField(
              controller: TextEditingController(text: _customizations['cafeSubtitle']),
              decoration: const InputDecoration(labelText: 'Alt Başlık (Badge)'),
              onChanged: (val) => setState(() => _customizations['cafeSubtitle'] = val),
            ),
            TextField(
              controller: TextEditingController(text: _customizations['activeTable']),
              decoration: const InputDecoration(labelText: 'Aktif Masa Bilgisi'),
              onChanged: (val) => setState(() => _customizations['activeTable'] = val),
            ),
            const SizedBox(height: 20),
            const Text("2. Arama Çubuğu Ayarları", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
            TextField(
              controller: TextEditingController(text: _customizations['searchHint']),
              decoration: const InputDecoration(labelText: 'Arama İpucu (Hint Text)'),
              onChanged: (val) => setState(() => _customizations['searchHint'] = val),
            ),
            const SizedBox(height: 20),
            const Text("3. Barista Önerisi Ayarları", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
            TextField(
              controller: TextEditingController(text: _customizations['baristaProduct']),
              decoration: const InputDecoration(labelText: 'Ürün Adı'),
              onChanged: (val) => setState(() => _customizations['baristaProduct'] = val),
            ),
            TextField(
              controller: TextEditingController(text: _customizations['baristaPrice'].toString()),
              decoration: const InputDecoration(labelText: 'Fiyat (TL)'),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() => _customizations['baristaPrice'] = double.tryParse(val) ?? 85.0),
            ),
          ],
        ),
      ),
      // ORTA/SOL TARAF: Sabit Sıralı Kafe Vitrini (Canlı Önizleme)
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                // 1. Header
                CustomHeader(
                  title: _customizations['cafeTitle'],
                  subtitle: _customizations['cafeSubtitle'],
                  activeTable: _customizations['activeTable'],
                  totalItemCount: 3,
                ),
                
                // 2. Search
                SearchWidget(
                  hintText: _customizations['searchHint'],
                  products: const [
                    {"name": "Filter Coffee", "category": "Coffees", "price": 60.0, "imageUrl": "https://images.unsplash.com/photo-1551030173-122aabc4489c?auto=format&fit=crop&w=250&q=80"},
                    {"name": "Latte", "category": "Coffees", "price": 75.0, "imageUrl": "https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?auto=format&fit=crop&w=250&q=80"},
                  ],
                  onProductTap: (p) => print("Tapped: ${p['name']}"),
                ),
                
                const SizedBox(height: 16),

                // 3. Story
                StoryWidget(
                  stories: const [
                    {"image": "https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=250&q=80", "title": "New Tastes", "isLive": true},
                    {"image": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=250&q=80", "title": "Coffee Time", "isLive": false},
                  ],
                ),
                
                const SizedBox(height: 16),

                // 4. Banner Carousel
                const BannerCarouselWidget(
                  banners: [
                    {"imageUrl": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=800&auto=format&fit=crop", "tagText": "NEW", "title": "Summer Deals", "subtitle": "20% off all cold drinks!"},
                  ],
                ),
                
                const SizedBox(height: 16),

                // 5. Flash Sale
                FlashSaleWidget(
                  products: const [
                    {"name": "Caramel Macchiato", "description": "Hot Drinks", "oldPrice": 120.0, "price": 80.0, "discountPercentage": 33.0, "imageUrl": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=250&q=80"},
                  ],
                  onProductTap: (p) => {},
                  onAddToCart: (p) => {},
                  onFavoriteToggle: (p) => {},
                ),

                const SizedBox(height: 24),

                // 6. Barista Suggestion (Özelleştirilebilir alan)
                BaristaSuggestionWidget(
                  productName: _customizations['baristaProduct'],
                  description: "Freshly brewed with special Guatemala beans",
                  imageUrl: "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=600&q=80",
                  price: _customizations['baristaPrice'],
                  onTap: () {},
                  onAddToCart: () {},
                  onFavoriteToggle: () {},
                ),
                
                const SizedBox(height: 24),

                // Diğer sabit widget'lar...
                QualityAndProductsWidget(
                  products: const [
                    {"name": "Latte", "description": "Espresso and milk", "price": 75.0, "imageUrl": "https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?auto=format&fit=crop&w=250&q=80"},
                  ],
                  onProductTap: (p) => {},
                  onAddToCart: (p) => {},
                  onFavoriteToggle: (p) => {},
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingCallWaiterWidget(
        activeTable: _customizations['activeTable'],
        onCallWaiter: () => print("Waiter called"),
      ),
    );
  }
}