import 'dart:math';
import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<double> weeklyData = [0.45, 0.72, 0.38, 0.88, 0.58, 0.95, 0.68];

  final categories = const [
    _CategoryData(
      title: "Food",
      amount: "\$420",
      percent: 0.72,
      icon: Icons.restaurant_rounded,
      color: Color(0xFFF59E0B),
    ),
    _CategoryData(
      title: "Shopping",
      amount: "\$310",
      percent: 0.55,
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFF8B5CF6),
    ),
    _CategoryData(
      title: "Transport",
      amount: "\$180",
      percent: 0.38,
      icon: Icons.directions_car_rounded,
      color: Color(0xFF3B82F6),
    ),
    _CategoryData(
      title: "Bills",
      amount: "\$260",
      percent: 0.48,
      icon: Icons.receipt_long_rounded,
      color: Color(0xFFEF4444),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get totalCategoryPercent =>
      categories.fold(0, (sum, item) => sum + item.percent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF0F5961),
      bottomNavigationBar: const _StatsFloatingNav(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _Header(controller: _controller),

            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
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
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SummaryCards(controller: _controller),

                      const SizedBox(height: 24),

                      Row(
                        children: const [
                          Text(
                            "Weekly Activity",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "This week",
                            style: TextStyle(
                              color: Color(0xFF0F5961),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      _FancyChart(
                        controller: _controller,
                        values: weeklyData,
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: const [
                          Text(
                            "Spending Split",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Monthly",
                            style: TextStyle(
                              color: Color(0xFF0F5961),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      _DonutAndStats(
                        controller: _controller,
                        categories: categories,
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        "Top Categories",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),

                      const SizedBox(height: 16),

                      ...categories.map(
                            (item) => _CategoryTile(
                          data: item,
                          controller: _controller,
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
}

class _Header extends StatelessWidget {
  final AnimationController controller;

  const _Header({required this.controller});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Statistics",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.20),
                    Colors.white.withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white.withOpacity(0.18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.14),
                    blurRadius: 22,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Spending",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "\$1,170.00",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "+12% higher than last month",
                          style: TextStyle(
                            color: Color(0xFF9FE870),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 62,
                    width: 62,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9FE870),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9FE870).withOpacity(0.35),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_graph_rounded,
                      color: Color(0xFF102118),
                      size: 34,
                    ),
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

class _SummaryCards extends StatelessWidget {
  final AnimationController controller;

  const _SummaryCards({required this.controller});

  @override
  Widget build(BuildContext context) {
    final cards = const [
      _MiniStat("Income", "\$3.8k", Icons.south_west_rounded, Color(0xFF10B981)),
      _MiniStat("Expense", "\$1.17k", Icons.north_east_rounded, Color(0xFFEF4444)),
      _MiniStat("Saving", "\$2.63k", Icons.savings_rounded, Color(0xFF8B5CF6)),
    ];

    return Row(
      children: List.generate(cards.length, (index) {
        final item = cards[index];

        return Expanded(
          child: FadeTransition(
            opacity: controller,
            child: Container(
              margin: EdgeInsets.only(right: index == cards.length - 1 ? 0 : 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(item.icon, color: item.color),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.amount,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _FancyChart extends StatelessWidget {
  final AnimationController controller;
  final List<double> values;

  const _FancyChart({
    required this.controller,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Container(
      height: 250,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
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
                "\$890",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "+8.4%",
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.show_chart_rounded,
                color: Color(0xFF0F5961),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(values.length, (index) {
                    final active = index == 5;
                    final height = 130 * values[index] * controller.value;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height.clamp(20, 130),
                          width: active ? 22 : 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: active
                                  ? const [
                                Color(0xFF0F5961),
                                Color(0xFF073B40),
                              ]
                                  : const [
                                Color(0xFF9FE870),
                                Color(0xFFD9F99D),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: active
                                ? [
                              BoxShadow(
                                color: const Color(0xFF0F5961)
                                    .withOpacity(0.25),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ]
                                : [],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          days[index],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                            active ? FontWeight.bold : FontWeight.w500,
                            color: active
                                ? const Color(0xFF0F5961)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutAndStats extends StatelessWidget {
  final AnimationController controller;
  final List<_CategoryData> categories;

  const _DonutAndStats({
    required this.controller,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _DonutPainter(
                    progress: controller.value,
                    categories: categories,
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "\$1.17k",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          "Spent",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: categories.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        height: 11,
                        width: 11,
                        decoration: BoxDecoration(
                          color: item.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF334155),
                          ),
                        ),
                      ),
                      Text(
                        "${(item.percent * 100).round()}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double progress;
  final List<_CategoryData> categories;

  _DonutPainter({
    required this.progress,
    required this.categories,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 18.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - strokeWidth;

    final bgPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    double startAngle = -pi / 2;
    final total = categories.fold<double>(0, (sum, item) => sum + item.percent);

    for (final item in categories) {
      final sweep = (item.percent / total) * 2 * pi * progress;

      final paint = Paint()
        ..color = item.color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep - 0.08,
        false,
        paint,
      );

      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _CategoryTile extends StatelessWidget {
  final _CategoryData data;
  final AnimationController controller;

  const _CategoryTile({
    required this.data,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                color: data.color.withOpacity(0.13),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(data.icon, color: data.color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        data.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        data.amount,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: data.percent * controller.value,
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(data.color),
                        ),
                      );
                    },
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

class _StatsFloatingNav extends StatefulWidget {
  const _StatsFloatingNav();

  @override
  State<_StatsFloatingNav> createState() => _StatsFloatingNavState();
}

class _StatsFloatingNavState extends State<_StatsFloatingNav> {
  int selectedIndex = 1;

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
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.symmetric(
                  horizontal: selectedIndex == index ? 15 : 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? const Color(0xFF9FE870)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: selectedIndex == index
                      ? [
                    BoxShadow(
                      color: const Color(0xFF9FE870).withOpacity(0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ]
                      : [],
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
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      child: selectedIndex == index
                          ? Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          item.label,
                          style: const TextStyle(
                            color: Color(0xFF102118),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
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

class _MiniStat {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  const _MiniStat(this.title, this.amount, this.icon, this.color);
}

class _CategoryData {
  final String title;
  final String amount;
  final double percent;
  final IconData icon;
  final Color color;

  const _CategoryData({
    required this.title,
    required this.amount,
    required this.percent,
    required this.icon,
    required this.color,
  });
}

class _NavData {
  final IconData icon;
  final String label;

  const _NavData(this.icon, this.label);
}