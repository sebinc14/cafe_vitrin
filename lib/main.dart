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
      ),
      drawer: CustomDrawerWidget(
        activeTable: _customizations['activeTable'],
        userName: "Misafir",
        userEmail: "misafir@example.com",
        avatarLetter: "M",
        loyaltyStamps: 3,
        totalMokaPoints: 120,
        menuItems: [
          DrawerMenuItem(icon: Icons.person_outline, title: "Profilim", onTap: () {}),
          DrawerMenuItem(icon: Icons.history, title: "Sipariş Geçmişi", onTap: () {}),
          DrawerMenuItem(icon: Icons.local_offer_outlined, title: "Kampanyalar", onTap: () {}),
          DrawerMenuItem(icon: Icons.favorite_border, title: "Favorilerim", onTap: () {}),
          DrawerMenuItem(icon: Icons.location_on_outlined, title: "Adreslerim", onTap: () {}),
          DrawerMenuItem(icon: Icons.credit_card, title: "Ödeme Yöntemleri", onTap: () {}),
          DrawerMenuItem(icon: Icons.help_outline, title: "İletişim ve Destek", onTap: () {}),
          DrawerMenuItem(icon: Icons.settings, title: "Ayarlar", onTap: () {}),
        ],
        onCallWaiterTap: () => print("Garson Çağrıldı"),
        onLogoutTap: () => print("Çıkış Yapıldı"),
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