import 'package:flutter/material.dart';

class AnimatedRatingModal extends StatefulWidget {
  final String orderId;
  final List<dynamic> orderItems;
  final Color primaryColor;
  final String title;
  final String subtitle;
  final String hintText;
  final String submitButtonText;
  final String successMessage;
  final Color starColor;
  final Function(int rating, String comment)? onSubmit;

  const AnimatedRatingModal({
    super.key,
    required this.orderId,
    required this.orderItems,
    this.primaryColor = const Color(0xFF6B4E3D),
    this.starColor = Colors.amber,
    this.title = "How was your coffee?",
    this.subtitle = "Rating us helps us improve our quality.",
    this.hintText = "Anything you'd like to add? (Optional)",
    this.submitButtonText = "Submit",
    this.successMessage = "Thank you for your feedback!",
    this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, 
    String orderId, 
    List<dynamic> orderItems, {
    Color primaryColor = const Color(0xFF6B4E3D),
    Color starColor = Colors.amber,
    Function(int rating, String comment)? onSubmit,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AnimatedRatingModal(
          orderId: orderId, 
          orderItems: orderItems,
          primaryColor: primaryColor,
          starColor: starColor,
          onSubmit: onSubmit,
        ),
      ),
    );
  }

  @override
  State<AnimatedRatingModal> createState() => _AnimatedRatingModalState();
}

class _AnimatedRatingModalState extends State<AnimatedRatingModal> {
  int _currentRating = 5;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      if (widget.onSubmit != null) {
        widget.onSubmit!(_currentRating, _commentController.text);
      }
      
      setState(() => _isSubmitting = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: widget.primaryColor,
            ),
          ),
          
          const SizedBox(height: 8),
          Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          
          const SizedBox(height: 32),
          
          // Yıldızlar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starIndex = index + 1;
              return GestureDetector(
                onTap: () => setState(() => _currentRating = starIndex),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    starIndex <= _currentRating ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: widget.starColor,
                    size: 48,
                  ),
                ),
              );
            }),
          ),
          
          const SizedBox(height: 24),
          
          // Yorum Alanı
          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: widget.primaryColor, width: 1.5),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Gönder Butonu
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(
                      widget.submitButtonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
