import 'dart:math';
import 'package:flutter/material.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnim;
  late Animation<double> _shineAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _shineAnim = Tween<double>(begin: -1.2, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnim.value),
          child: Container(
            height: 220,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 22,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Stack(
                children: [
                  /// Background
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF031F1B),
                          Color(0xFF06352E),
                          Color(0xFF0A1A24),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),

                  /// Indian art pattern
                  const Positioned(
                    right: -20,
                    top: 35,
                    child: Icon(
                      Icons.spa,
                      size: 180,
                      color: Color(0x2234D399),
                    ),
                  ),

                  const Positioned(
                    right: 45,
                    bottom: 20,
                    child: Icon(
                      Icons.local_florist,
                      size: 95,
                      color: Color(0x44D4AF37),
                    ),
                  ),

                  Positioned(
                    right: 70,
                    top: 70,
                    child: CustomPaint(
                      size: const Size(120, 90),
                      painter: PeacockPainter(),
                    ),
                  ),

                  /// Wise green corner
                  Positioned(
                    top: -28,
                    right: -28,
                    child: Container(
                      height: 125,
                      width: 125,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9FE870),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, right: 14),
                          child: Text(
                            "WISE",
                            style: TextStyle(
                              color: Color(0xFF102118),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Animated shine
                  Positioned.fill(
                    child: Transform.translate(
                      offset: Offset(_shineAnim.value * 280, 0),
                      child: Transform.rotate(
                        angle: pi / 6,
                        child: Container(
                          width: 70,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0),
                                Colors.white.withOpacity(0.18),
                                Colors.white.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Main content
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/chip.png",
                              height: 38,
                            ),
                            const SizedBox(width: 12),
                            Image.asset(
                              "assets/nfc.png",
                              height: 26,
                              color: Colors.white,
                            ),
                          ],
                        ),

                        const Spacer(),

                        const Text(
                          "4532  ••••  ••••  9021",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3,
                          ),
                        ),

                        const SizedBox(height: 22),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CARD HOLDER",
                                  style: TextStyle(
                                    color: Color(0xFFD4AF37),
                                    fontSize: 10,
                                    letterSpacing: 2,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "SABBIR AHMED",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "VISA",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 31,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "Debit",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PeacockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final goldPaint = Paint()
      ..color = const Color(0x88D4AF37)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final greenPaint = Paint()
      ..color = const Color(0x5534D399)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final body = Path()
      ..moveTo(size.width * 0.45, size.height * 0.85)
      ..quadraticBezierTo(
        size.width * 0.2,
        size.height * 0.45,
        size.width * 0.5,
        size.height * 0.25,
      )
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.45,
        size.width * 0.65,
        size.height * 0.85,
      );

    canvas.drawPath(body, greenPaint);

    final neck = Path()
      ..moveTo(size.width * 0.5, size.height * 0.3)
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.05,
        size.width * 0.8,
        size.height * 0.15,
      );

    canvas.drawPath(neck, goldPaint);

    for (int i = 0; i < 7; i++) {
      final x = size.width * (0.2 + i * 0.1);
      final path = Path()
        ..moveTo(size.width * 0.5, size.height * 0.75)
        ..quadraticBezierTo(
          x,
          size.height * 0.35,
          x + 10,
          size.height * 0.05,
        );
      canvas.drawPath(path, goldPaint);
    }

    for (int i = 0; i < 10; i++) {
      canvas.drawCircle(
        Offset(size.width * (0.2 + i * 0.07), size.height * 0.85),
        3,
        greenPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}