import 'package:flutter/material.dart';

/// A floating action button alternative designed for calling a waiter.
class FloatingCallWaiterWidget extends StatelessWidget {
  /// The active table number or name.
  final String activeTable;

  /// The text displayed on the button.
  final String buttonText;

  /// The background color of the container.
  final Color backgroundColor;

  /// The primary color of the button.
  final Color primaryColor;

  /// The accent color used for icons and text.
  final Color accentColor;

  /// The background color for the table badge.
  final Color badgeColor;

  /// Callback triggered when the button is pressed.
  final VoidCallback? onCallWaiter;

  /// Creates a new [FloatingCallWaiterWidget].
  const FloatingCallWaiterWidget({
    Key? key,
    this.activeTable = "Table",
    this.buttonText = "Call Waiter",
    this.backgroundColor = const Color(0xFFF9F9F9),
    this.primaryColor = const Color(0xFF6B4E3D),
    this.accentColor = Colors.amber,
    this.badgeColor = const Color(0xFF4E342E),
    this.onCallWaiter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: () {
            if (onCallWaiter != null) {
              onCallWaiter!();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.front_hand, color: accentColor, size: 22),
              const SizedBox(width: 10),
              Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 12),
              // Masa Numarası Rozeti
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  activeTable,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
