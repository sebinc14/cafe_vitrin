import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';

/// A carousel widget for displaying promotional banners.
class BannerCarouselWidget extends StatefulWidget {
  /// The list of banners to display. Each banner should be a map.
  final List<Map<String, dynamic>> banners;

  /// The color of the active indicator dot.
  final Color indicatorActiveColor;

  /// The color of the inactive indicator dots.
  final Color indicatorInactiveColor;

  /// The height of the carousel.
  final double height;

  /// The interval between automatic page transitions.
  final Duration autoPlayInterval;

  /// Creates a new [BannerCarouselWidget].
  const BannerCarouselWidget({
    Key? key,
    required this.banners,
    this.indicatorActiveColor = const Color(0xFF6B4E3D),
    this.indicatorInactiveColor = const Color(0xFFE0E0E0),
    this.height = 180,
    this.autoPlayInterval = const Duration(seconds: 4),
  }) : super(key: key);

  @override
  State<BannerCarouselWidget> createState() => _BannerCarouselWidgetState();
}

class _BannerCarouselWidgetState extends State<BannerCarouselWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.banners.length,
          options: CarouselOptions(
            height: widget.height,
            autoPlay: widget.banners.length > 1,
            autoPlayInterval: widget.autoPlayInterval,
            enlargeCenterPage: true,
            viewportFraction: 0.92,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final banner = widget.banners[index];
            final imageUrl = banner["imageUrl"] ?? "";
            final tagColor = banner["tagColor"] ?? widget.indicatorActiveColor;

            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.8),
                      Colors.black.withValues(alpha: 0.2),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (banner["tagText"] != null &&
                        banner["tagText"].toString().isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: tagColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          banner["tagText"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      banner["title"] ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      banner["subtitle"] ?? "",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (widget.banners.length > 1) ...[
          const SizedBox(height: 12),
          // Alt kısımdaki nokta (indicator) göstergeleri
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.banners.asMap().entries.map((entry) {
              return Container(
                width: _currentIndex == entry.key ? 20.0 : 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentIndex == entry.key
                      ? widget.indicatorActiveColor
                      : widget.indicatorInactiveColor,
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
