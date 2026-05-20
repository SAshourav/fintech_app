import 'dart:math';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final cryptoAssets = const [
    _InvestmentAsset("Bitcoin", "BTC", "\$42,350", "+5.42%", Icons.currency_bitcoin_rounded, Color(0xFFF7931A)),
    _InvestmentAsset("Ethereum", "ETH", "\$2,840", "+3.18%", Icons.diamond_rounded, Color(0xFF627EEA)),
    _InvestmentAsset("Solana", "SOL", "\$156", "-1.24%", Icons.blur_on_rounded, Color(0xFF8B5CF6)),
  ];

  final investments = const [
    _InvestmentAsset("S&P 500 ETF", "VOO", "\$480.22", "+1.85%", Icons.trending_up_rounded, Color(0xFF10B981)),
    _InvestmentAsset("Gold Fund", "GLD", "\$218.40", "+0.72%", Icons.workspace_premium_rounded, Color(0xFFF59E0B)),
    _InvestmentAsset("Tech Stocks", "TECH", "\$1,230", "+2.91%", Icons.memory_rounded, Color(0xFF3B82F6)),
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10505A),
      extendBody: true,
      bottomNavigationBar: const _WalletFloatingNav(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: _circleIcon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    "Wallet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  _circleIcon(Icons.notifications_rounded),
                ],
              ),
            ),

            FadeTransition(
              opacity: controller,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF9FE870),
                      Color(0xFF34D399),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9FE870).withOpacity(0.35),
                      blurRadius: 28,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -30,
                      child: Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 130,
                        color: Colors.black.withOpacity(0.08),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Portfolio Value",
                          style: TextStyle(
                            color: Color(0xFF102118),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "\$12,840.75",
                          style: TextStyle(
                            color: Color(0xFF102118),
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _pill("+ \$742.30 Today", Icons.trending_up_rounded),
                            const SizedBox(width: 10),
                            _pill("+ 6.12%", Icons.show_chart_rounded),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(42),
                    topRight: Radius.circular(42),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _QuickActions(controller: controller),

                      const SizedBox(height: 26),

                      const Text(
                        "Investment Growth",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),

                      const SizedBox(height: 16),

                      _GrowthChart(controller: controller),

                      const SizedBox(height: 26),

                      Row(
                        children: const [
                          Text(
                            "Crypto Investment",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "See all",
                            style: TextStyle(
                              color: Color(0xFF10505A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      ...cryptoAssets.map(
                            (asset) => _AssetTile(
                          asset: asset,
                          controller: controller,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: const [
                          Text(
                            "Other Investments",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Manage",
                            style: TextStyle(
                              color: Color(0xFF10505A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      ...investments.map(
                            (asset) => _AssetTile(
                          asset: asset,
                          controller: controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _pill(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: const Color(0xFF102118)),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF102118),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final AnimationController controller;

  const _QuickActions({required this.controller});

  @override
  Widget build(BuildContext context) {
    final actions = const [
      _WalletAction(Icons.add_rounded, "Deposit", Color(0xFF10B981)),
      _WalletAction(Icons.currency_bitcoin_rounded, "Buy Crypto", Color(0xFFF7931A)),
      _WalletAction(Icons.candlestick_chart_rounded, "Invest", Color(0xFF8B5CF6)),
      _WalletAction(Icons.swap_horiz_rounded, "Exchange", Color(0xFF3B82F6)),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((item) {
        return FadeTransition(
          opacity: controller,
          child: Column(
            children: [
              Container(
                height: 68,
                width: 68,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: item.color.withOpacity(0.20),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(item.icon, color: item.color, size: 30),
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _GrowthChart extends StatelessWidget {
  final AnimationController controller;

  const _GrowthChart({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "\$12.8k",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "+18.7%",
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                "6M",
                style: TextStyle(
                  color: Color(0xFF10505A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _LineChartPainter(progress: controller.value),
                  child: Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final double progress;

  _LineChartPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;

    for (int i = 1; i <= 3; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = [
      Offset(0, size.height * 0.75),
      Offset(size.width * 0.16, size.height * 0.60),
      Offset(size.width * 0.32, size.height * 0.66),
      Offset(size.width * 0.48, size.height * 0.38),
      Offset(size.width * 0.64, size.height * 0.44),
      Offset(size.width * 0.80, size.height * 0.22),
      Offset(size.width, size.height * 0.16),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];

      path.quadraticBezierTo(
        previous.dx + 40,
        previous.dy,
        current.dx,
        current.dy,
      );
    }

    final metric = path.computeMetrics().first;
    final animatedPath = metric.extractPath(0, metric.length * progress);

    final linePaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF10505A),
          Color(0xFF9FE870),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(animatedPath, linePaint);

    final fillPath = Path.from(animatedPath)
      ..lineTo(size.width * progress, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF9FE870).withOpacity(0.20),
          const Color(0xFF9FE870).withOpacity(0.02),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _AssetTile extends StatelessWidget {
  final _InvestmentAsset asset;
  final AnimationController controller;

  const _AssetTile({
    required this.asset,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = asset.change.startsWith("+");

    return FadeTransition(
      opacity: controller,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: asset.color.withOpacity(0.13),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(asset.icon, color: asset.color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    asset.symbol,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  asset.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  asset.change,
                  style: TextStyle(
                    color: isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletFloatingNav extends StatefulWidget {
  const _WalletFloatingNav();

  @override
  State<_WalletFloatingNav> createState() => _WalletFloatingNavState();
}

class _WalletFloatingNavState extends State<_WalletFloatingNav> {
  int selectedIndex = 2;

  final items = const [
    _NavData(Icons.home_rounded, "Home"),
    _NavData(Icons.bar_chart_rounded, "Stats"),
    _NavData(Icons.wallet_rounded, "Wallet"),
    _NavData(Icons.person_rounded, "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
      child: Container(
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0E2F34),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];

            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                padding: EdgeInsets.symmetric(
                  horizontal: selectedIndex == index ? 15 : 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? const Color(0xFF9FE870)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      color: selectedIndex == index
                          ? const Color(0xFF102118)
                          : Colors.white60,
                      size: 23,
                    ),
                    if (selectedIndex == index) ...[
                      const SizedBox(width: 7),
                      Text(
                        item.label,
                        style: const TextStyle(
                          color: Color(0xFF102118),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _InvestmentAsset {
  final String name;
  final String symbol;
  final String price;
  final String change;
  final IconData icon;
  final Color color;

  const _InvestmentAsset(
      this.name,
      this.symbol,
      this.price,
      this.change,
      this.icon,
      this.color,
      );
}

class _WalletAction {
  final IconData icon;
  final String title;
  final Color color;

  const _WalletAction(this.icon, this.title, this.color);
}

class _NavData {
  final IconData icon;
  final String label;

  const _NavData(this.icon, this.label);
}