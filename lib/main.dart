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
  runApp(const CafeShowcaseApp());
}

class CafeShowcaseApp extends StatelessWidget {
  const CafeShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Vitrin Widgets Showcase',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const ShowcaseHomePage(),
    );
  }
}

class ShowcaseHomePage extends StatefulWidget {
  const ShowcaseHomePage({super.key});

  @override
  State<ShowcaseHomePage> createState() => _ShowcaseHomePageState();
}

class _ShowcaseHomePageState extends State<ShowcaseHomePage> {
  int _selectedIndex = 0;

  final List<String> _menuItems = [
    "📱 Tüm Uygulama Vitrini",
    "🔍 Search Widget",
    "📸 Story Widget",
    "🖼️ Banner Carousel",
    "⚡ Flash Sale Widget",
    "☕ Barista Suggestion",
    "✨ Quality & Products",
    "🛎️ Call Waiter FAB",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafe Vitrin Widgets Showcase'),
        backgroundColor: const Color(0xFF4E342E),
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          // Sol Menü (Sidebar)
          Container(
            width: 250,
            color: Colors.white,
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedIndex;
                return ListTile(
                  title: Text(
                    _menuItems[index],
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? const Color(0xFF4E342E) : Colors.black87,
                    ),
                  ),
                  tileColor: isSelected ? Colors.brown.withOpacity(0.1) : null,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          const VerticalDivider(width: 1, color: Colors.grey),
          
          // Sağ İçerik (Önizleme)
          Expanded(
            child: Container(
              color: const Color(0xFFF5F5F5),
              child: Center(
                child: MobileMockup(
                  child: _buildSelectedContent(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedIndex) {
      case 0:
        return const FullAppView();
      case 1:
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Search Widget', style: TextStyle(fontSize: 16))),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchWidget(
              products: const [
                {"name": "Filter Coffee", "category": "Coffees", "price": 60.0},
                {"name": "Latte", "category": "Coffees", "price": 75.0},
              ],
              onProductTap: (p) => debugPrint("Tapped: ${p['name']}"),
            ),
          ),
        );
      case 2:
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Story Widget', style: TextStyle(fontSize: 16))),
          body: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: StoryWidget(
              stories: [
                {
                  "image": "https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=250&q=80",
                  "title": "New Tastes",
                  "isLive": true,
                },
                {
                  "image": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=250&q=80",
                  "title": "Coffee Time",
                  "isLive": false,
                },
              ],
            ),
          ),
        );
      case 3:
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Banner Carousel', style: TextStyle(fontSize: 16))),
          body: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: BannerCarouselWidget(
              banners: [
                {
                  "imageUrl": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=800&auto=format&fit=crop",
                  "tagText": "NEW",
                  "title": "Summer Deals",
                  "subtitle": "20% off all cold drinks!",
                },
              ],
            ),
          ),
        );
      case 4:
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Flash Sale', style: TextStyle(fontSize: 16))),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: FlashSaleWidget(
              products: const [
                {
                  "name": "Caramel Macchiato",
                  "description": "Hot Drinks",
                  "oldPrice": 120.0,
                  "price": 80.0,
                  "discountPercentage": 33.0,
                  "imageUrl": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=250&q=80",
                },
              ],
              onProductTap: (p) => {},
            ),
          ),
        );
      case 5:
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Barista Suggestion', style: TextStyle(fontSize: 16))),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: BaristaSuggestionWidget(
              productName: "Barista's Special Coffee of the Week",
              description: "Freshly brewed with special Guatemala beans",
              imageUrl: "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=600&q=80",
              price: 85.0,
              onTap: () {},
            ),
          ),
        );
      case 6:
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Quality & Products', style: TextStyle(fontSize: 16))),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: QualityAndProductsWidget(
              products: const [
                {
                  "name": "Latte",
                  "description": "Espresso and milk",
                  "price": 75.0,
                  "imageUrl": "https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?auto=format&fit=crop&w=250&q=80",
                },
              ],
              onProductTap: (p) => {},
            ),
          ),
        );
      case 7:
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Call Waiter FAB', style: TextStyle(fontSize: 16))),
          floatingActionButton: FloatingCallWaiterWidget(
            activeTable: "Table 5",
            onCallWaiter: () => debugPrint("Waiter called"),
          ),
          body: const Center(child: Text("Look at the bottom right corner!")),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

/// A container that visually simulates a mobile phone screen.
class MobileMockup extends StatelessWidget {
  final Widget child;
  const MobileMockup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 800,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10)),
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

/// The original full cafe app layout.
class FullAppView extends StatelessWidget {
  const FullAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          DrawerMenuItem(icon: Icons.settings, title: "Ayarlar", onTap: () {}),
        ],
        onCallWaiterTap: () => debugPrint("Garson Çağrıldı"),
        onLogoutTap: () => debugPrint("Çıkış Yapıldı"),
      ),
      body: ListView(
        children: [
          const CustomHeader(
            title: 'Moka Mola',
            subtitle: 'CAFE',
            activeTable: 'Table 5',
            totalItemCount: 3,
          ),
          SearchWidget(
            hintText: 'Search for coffee, dessert...',
            products: const [
              {
                "name": "Filter Coffee",
                "category": "Coffees",
                "price": 60.0,
                "imageUrl": "https://images.unsplash.com/photo-1551030173-122aabc4489c?auto=format&fit=crop&w=250&q=80",
              },
            ],
            onProductTap: (p) => debugPrint("Tapped: ${p['name']}"),
          ),
          const SizedBox(height: 16),
          const StoryWidget(
            stories: [
              {
                "image": "https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=250&q=80",
                "title": "New Tastes",
                "isLive": true,
              },
            ],
          ),
          const SizedBox(height: 16),
          const BannerCarouselWidget(
            banners: [
              {
                "imageUrl": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=800&auto=format&fit=crop",
                "tagText": "NEW",
                "title": "Summer Deals",
                "subtitle": "20% off all cold drinks!",
              },
            ],
          ),
          const SizedBox(height: 16),
          FlashSaleWidget(
            products: const [
              {
                "name": "Caramel Macchiato",
                "description": "Hot Drinks",
                "oldPrice": 120.0,
                "price": 80.0,
                "discountPercentage": 33.0,
                "imageUrl": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=250&q=80",
              },
            ],
            onProductTap: (p) => {},
          ),
          const SizedBox(height: 24),
          BaristaSuggestionWidget(
            productName: "Barista's Special Coffee of the Week",
            description: "Freshly brewed with special Guatemala beans",
            imageUrl: "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=600&q=80",
            price: 85.0,
            onTap: () {},
          ),
          const SizedBox(height: 50),
        ],
      ),
      floatingActionButton: FloatingCallWaiterWidget(
        activeTable: 'Table 5',
        onCallWaiter: () => debugPrint("Waiter called"),
      ),
    );
  }
}
