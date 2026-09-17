import 'package:flutter/material.dart';
import 'dart:math';

class Prize {
  final String title;
  final Color color;
  final String actionType; // 'cart', 'code', 'none'
  final dynamic actionData;
  final IconData icon;

  Prize(this.title, this.color, this.actionType, this.actionData, this.icon);
}

class GamificationWidget extends StatefulWidget {
  final List<Prize> prizes;
  final Function(Prize)? onPrizeWon;
  final Function(Prize)? onPrizeRedeemed;

  final String titleText;
  final String subtitleText;
  final Color gradientStartColor;
  final Color gradientEndColor;

  const GamificationWidget({
    super.key,
    required this.prizes,
    this.onPrizeWon,
    this.onPrizeRedeemed,
    this.titleText = "Wheel of Fortune",
    this.subtitleText = "Spin the wheel, catch surprise discounts!",
    this.gradientStartColor = const Color(0xFF6B4E3D),
    this.gradientEndColor = Colors.amber,
  });

  @override
  State<GamificationWidget> createState() => _GamificationWidgetState();
}

class _GamificationWidgetState extends State<GamificationWidget> {
  final bool _isLoading = false;
  bool _hasSpun = false;
  bool _hasActivePrize = false;
  Prize? _activePrize;

  void _openWheelDialog() {
    if (_hasSpun && !_hasActivePrize) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _SpinWheelDialog(
            prizes: widget.prizes,
            initialWonPrize: _activePrize,
            onWin: (Prize wonPrize) {
              setState(() {
                _hasSpun = true;
                _hasActivePrize = wonPrize.actionType != 'none';
                _activePrize = wonPrize;
              });
              if (widget.onPrizeWon != null) {
                widget.onPrizeWon!(wonPrize);
              }
            },
            onRedeem: (Prize wonPrize) {
              setState(() {
                _hasActivePrize = false;
              });
              if (widget.onPrizeRedeemed != null) {
                widget.onPrizeRedeemed!(wonPrize);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentTitle = _isLoading ? "Preparing Wheel..." : widget.titleText;
    String currentSubtitle = widget.subtitleText;
    IconData iconData = Icons.attractions;

    if (!_isLoading) {
      if (_hasActivePrize) {
        currentTitle = "Your Gift is Waiting!";
        currentSubtitle = "Click to view your gift.";
        iconData = Icons.card_giftcard;
      } else if (_hasSpun) {
        currentTitle = "Wheel Spun!";
        currentSubtitle = "You used your luck for today.";
        iconData = Icons.check_circle;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: _openWheelDialog,
        child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                widget.gradientStartColor,
                widget.gradientEndColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.gradientEndColor.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Icon(Icons.incomplete_circle, size: 120, color: Colors.white.withValues(alpha: 0.1)),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: _isLoading 
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Icon(
                            iconData,
                            color: Colors.white,
                            size: 36,
                          ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            currentSubtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!_hasSpun && !_isLoading || _hasActivePrize)
                      const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpinWheelDialog extends StatefulWidget {
  final List<Prize> prizes;
  final Function(Prize) onWin;
  final Function(Prize) onRedeem;
  final Prize? initialWonPrize;

  const _SpinWheelDialog({required this.prizes, required this.onWin, required this.onRedeem, this.initialWonPrize});

  @override
  State<_SpinWheelDialog> createState() => _SpinWheelDialogState();
}

class _SpinWheelDialogState extends State<_SpinWheelDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isSpinning = false;
  bool _isFinished = false;
  late Prize _wonPrize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);

    if (widget.initialWonPrize != null) {
      _wonPrize = widget.initialWonPrize!;
      _isFinished = true;
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isSpinning = false;
          _isFinished = true;
        });
        widget.onWin(_wonPrize);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spin() {
    if (_isSpinning || _isFinished) return;
    if (widget.prizes.isEmpty) return;

    setState(() {
      _isSpinning = true;
    });

    final int winIndex = Random().nextInt(widget.prizes.length);
    _wonPrize = widget.prizes[winIndex];

    double sliceCenterAngle = winIndex * 60.0 + 30.0;
    double offsetAngle = 270.0 - sliceCenterAngle;
    if (offsetAngle < 0) offsetAngle += 360.0;
    
    double randomJitter = (Random().nextDouble() * 40) - 20;
    offsetAngle += randomJitter;

    double offsetTurns = offsetAngle / 360.0;
    double totalTurns = 5.0 + offsetTurns;

    _animation = Tween<double>(
      begin: 0,
      end: totalTurns,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCirc,
    ));

    _controller.forward(from: 0.0);
  }

  Widget _buildActionArea() {
    if (_wonPrize.actionType == 'none') {
      return Column(
        children: [
          const Text("Unfortunately, you missed this time.", style: TextStyle(fontSize: 14)),
          const SizedBox(height: 24),
          _buildCloseButton("Close"),
        ],
      );
    }

    if (_wonPrize.actionType == 'code') {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade300),
            ),
            child: Text(
              _wonPrize.actionData.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.orange),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.check_circle, color: Colors.white),
              label: const Text("Apply Discount to Cart", style: TextStyle(color: Colors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B4E3D),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                widget.onRedeem(_wonPrize);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    }

    if (_wonPrize.actionType == 'cart') {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_wonPrize.icon, color: Colors.green, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _wonPrize.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              label: const Text("Add to Cart for Free", style: TextStyle(color: Colors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                widget.onRedeem(_wonPrize);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    }

    return _buildCloseButton("Close");
  }

  Widget _buildCloseButton(String text) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B4E3D),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.prizes.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Wheel of Fortune",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF6B4E3D)),
              ),
              const SizedBox(height: 24),

              if (!_isFinished) ...[
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: RotationTransition(
                        turns: _animation,
                        child: SizedBox(
                          width: 220,
                          height: 220,
                          child: CustomPaint(
                            painter: _WheelPainter(widget.prizes.map((p) => p.color).toList()),
                            child: Stack(
                              children: List.generate(widget.prizes.length, (index) {
                                double angle = (index * (360 / widget.prizes.length) + (180 / widget.prizes.length)) * pi / 180;
                                return Align(
                                  alignment: Alignment(cos(angle) * 0.6, sin(angle) * 0.6),
                                  child: Transform.rotate(
                                    angle: angle + pi / 2, 
                                    child: Icon(widget.prizes[index].icon, color: Colors.white, size: 24),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, size: 48, color: Color(0xFF6B4E3D)),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isSpinning ? Colors.grey : const Color(0xFF6B4E3D),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _isSpinning ? null : _spin,
                    child: Text(
                      _isSpinning ? "Spinning..." : "Spin!",
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ] else ...[
                Icon(_wonPrize.icon, color: _wonPrize.color, size: 60),
                const SizedBox(height: 16),
                Text(
                  _wonPrize.actionType == 'none' ? "Better Luck Next Time!" : "Congratulations!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _wonPrize.actionType == 'none' ? Colors.grey : Colors.green),
                ),
                const SizedBox(height: 8),
                Text(
                  _wonPrize.actionType == 'none' 
                    ? "You might be luckier next time." 
                    : "${_wonPrize.title} won!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 24),
                _buildActionArea(),
              ]
            ],
          ),
          Positioned(
            right: -16,
            top: -16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black54),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  final List<Color> colors;
  _WheelPainter(this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    if (colors.isEmpty) return;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..style = PaintingStyle.fill;
    final sweepAngle = (2 * pi) / colors.length;

    for (int i = 0; i < colors.length; i++) {
      paint.color = colors[i];
      canvas.drawArc(rect, i * sweepAngle, sweepAngle, true, paint);

      paint.color = Colors.white;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 3;
      canvas.drawArc(rect, i * sweepAngle, sweepAngle, true, paint);
      paint.style = PaintingStyle.fill;
    }
    
    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 20, paint);
    
    final textPainter = TextPainter(
      text: const TextSpan(text: "★", style: TextStyle(color: Colors.amber, fontSize: 24)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, size.height / 2 - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
