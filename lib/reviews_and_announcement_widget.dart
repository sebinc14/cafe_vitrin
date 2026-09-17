import 'package:flutter/material.dart';

class ReviewsAndAnnouncementWidget extends StatefulWidget {
  final List<Map<String, dynamic>> reviews;
  final bool isAnnouncementVisible;
  final String announcementTitle;
  final String announcementSubtitle;
  final String announcementDescription;

  final Color primaryColor;
  final Color accentColor;
  final Color darkColor;

  final Function(int rating, String comment)? onAddReview;

  const ReviewsAndAnnouncementWidget({
    super.key,
    required this.reviews,
    this.isAnnouncementVisible = true,
    this.announcementTitle = "ANNOUNCEMENT OF THE WEEK",
    this.announcementSubtitle = "Live Acoustic Music Evenings!",
    this.announcementDescription =
        "Enjoy music with the smell of fresh coffee.",
    this.primaryColor = const Color(0xFF6B4E3D),
    this.accentColor = Colors.amber,
    this.darkColor = const Color(0xFF4E342E),
    this.onAddReview,
  });

  @override
  State<ReviewsAndAnnouncementWidget> createState() =>
      _ReviewsAndAnnouncementWidgetState();
}

class _ReviewsAndAnnouncementWidgetState
    extends State<ReviewsAndAnnouncementWidget> {
  void _showAddReviewModal(BuildContext context) {
    int selectedRating = 5;
    String commentText = "";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            color: widget.primaryColor,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Rate Your Coffee",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Text(
                    "Share your experience with other coffee lovers",
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Yıldız Puanlama Alanı
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Your Rating: $selectedRating / 5 Stars",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 4,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setModalState(() {
                                    selectedRating = index + 1;
                                  });
                                },
                                child: Icon(
                                  index < selectedRating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: widget.accentColor,
                                  size: 36,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Kullanıcı Profili (Yorumu Yapan)
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: widget.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                          child: Text(
                            "G", // Guest
                            style: TextStyle(
                              color: widget.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Guest",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Yorum Metni
                    const Text(
                      "Your Review",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      onChanged: (val) => commentText = val,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText:
                            "How was the taste, service, and atmosphere?...",
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (commentText.trim().isNotEmpty) {
                      if (widget.onAddReview != null) {
                        widget.onAddReview!(selectedRating, commentText);
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Post Review",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Başlık ve Yorum Yaz Butonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.local_cafe, color: widget.darkColor, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    "Coffee Lover Reviews",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddReviewModal(context),
                icon: Icon(Icons.add, size: 14, color: widget.darkColor),
                label: Text(
                  "Write a Review",
                  style: TextStyle(
                    fontSize: 11,
                    color: widget.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.accentColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Yorum Listesi
          if (widget.reviews.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "No reviews yet. Be the first to review!",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.reviews.length,
                itemBuilder: (context, index) {
                  final rev = widget.reviews[index];
                  final fullName = "${rev['firstName']} ${rev['lastName']}";
                  final avatarInitial = fullName.isNotEmpty ? fullName[0] : "U";

                  final comment = rev['comment'];
                  final rating = rev['rating'] as int;
                  final dateStr = rev['dateStr'];

                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: widget.primaryColor
                                      .withValues(alpha: 0.1),
                                  child: Text(
                                    avatarInitial,
                                    style: TextStyle(
                                      color: widget.primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    fullName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: List.generate(
                                      rating,
                                      (_) => Icon(
                                        Icons.star,
                                        color: widget.accentColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    '"$comment"',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      dateStr,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Close",
                                  style: TextStyle(color: widget.primaryColor),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 260,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: widget.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                child: Text(
                                  avatarInitial,
                                  style: TextStyle(
                                    color: widget.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  rating,
                                  (_) => Icon(
                                    Icons.star,
                                    color: widget.accentColor,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '"$comment"',
                            style: const TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              dateStr,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 20),

          // 3. Haftanın Duyurusu Banner (31. Görsel)
          if (widget.isAnnouncementVisible)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.darkColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.accentColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.campaign,
                      color: widget.accentColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.announcementTitle,
                          style: TextStyle(
                            color: widget.accentColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.announcementSubtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.announcementDescription,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
