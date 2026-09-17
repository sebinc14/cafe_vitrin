import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> stories;
  final Color primaryColor;
  final Color accentColor;
  final Color liveColor;

  const StoryWidget({
    super.key,
    required this.stories,
    this.primaryColor = const Color(0xFF6B4E3D),
    this.accentColor = Colors.amber,
    this.liveColor = Colors.red,
  });

  void _showStory(BuildContext context, int initialIndex) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _StoryViewer(stories: stories, initialIndex: initialIndex);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (stories.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          final bool isLive = story["isLive"] == true;
          
          return GestureDetector(
            onTap: () => _showStory(context, index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: isLive
                                ? [liveColor, Colors.orange]
                                : [primaryColor, accentColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Container(
                        width: 66,
                        height: 66,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(story["image"] ?? ""),
                        onBackgroundImageError: (_, _) {},
                        backgroundColor: Colors.grey.shade200,
                      ),
                      if (isLive)
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: liveColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Text("LIVE", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    story["title"] ?? "",
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// -------------------------------------------------------------------------
// HİKAYE EKRANINDAKİ GEÇİŞLERİ VE TIKLAMALARI YÖNETEN YENİ WIDGET
// -------------------------------------------------------------------------
class _StoryViewer extends StatefulWidget {
  final List<Map<String, dynamic>> stories;
  final int initialIndex;

  const _StoryViewer({required this.stories, required this.initialIndex});

  @override
  State<_StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<_StoryViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTapLeft() {
    if (_currentIndex > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _onTapRight() {
    if (_currentIndex < widget.stories.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pop(context); // Son hikayeden sonra kapat
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Hikayelerin Kendisi (Kaydırılabilir PageView)
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.stories.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Image.network(
                    widget.stories[index]["image"] ?? "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.85,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade900,
                      child: const Center(child: Icon(Icons.image, color: Colors.grey, size: 60)),
                    ),
                  ),
                );
              },
            ),

            // 2. Sağ ve Sol Tıklama Alanları (Ekranı ikiye böler)
            Row(
              children: [
                Expanded(
                  flex: 1, // Ekranın %30-40'lık sol kısmı
                  child: GestureDetector(
                    onTap: _onTapLeft,
                    behavior: HitTestBehavior.opaque,
                    child: Container(),
                  ),
                ),
                Expanded(
                  flex: 2, // Ekranın %60-70'lik sağ kısmı
                  child: GestureDetector(
                    onTap: _onTapRight,
                    behavior: HitTestBehavior.opaque,
                    child: Container(),
                  ),
                ),
              ],
            ),

            // 3. Üstteki İlerleme Çubuğu (Instagram Tarzı)
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(widget.stories.length, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 3,
                      decoration: BoxDecoration(
                        color: index == _currentIndex ? Colors.white : Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // 4. Profil Resmi, Başlık ve Kapat Butonu
            Positioned(
              top: 24,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.stories[_currentIndex]["image"] ?? ""),
                        onBackgroundImageError: (_, _) {},
                        radius: 18,
                        backgroundColor: Colors.grey.shade800,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.stories[_currentIndex]["title"] ?? "",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      const Text("2h", style: TextStyle(color: Colors.white70, fontSize: 12)) // Zaman göstergesi
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}