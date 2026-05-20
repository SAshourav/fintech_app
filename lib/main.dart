import 'package:fintech_app/action_button.dart';
import 'package:fintech_app/pages/profile_page.dart';
import 'package:fintech_app/pages/stats_page.dart';
import 'package:fintech_app/pages/wallet_page.dart';
import 'package:fintech_app/transaction_summary.dart';
import 'package:flutter/material.dart';

import 'balance_section.dart';
import 'credit_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinTech App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF10505A)),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 16, 80, 90),
      bottomNavigationBar: const FloatingBottomNav(),

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back !",
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Sabbir Ahmed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_rounded),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: BalanceSection(),
            ),

            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 190),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(44),
                        topRight: Radius.circular(44),
                      ),
                    ),
                  ),

                  const Positioned(
                    top: 20,
                    left: 25,
                    right: 25,
                    child: CreditCard(),
                  ),

                  Positioned.fill(
                    top: 270,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 120),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: const [
                          ActionButtonsSection(),
                          SizedBox(height: 24),
                          TransactionSummary(),
                        ],
                      ),
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

class FloatingBottomNav extends StatefulWidget {
  const FloatingBottomNav({super.key});

  @override
  State<FloatingBottomNav> createState() => _FloatingBottomNavState();
}

class _FloatingBottomNavState extends State<FloatingBottomNav> {
  int selectedIndex = 0;

  final items = const [
    _NavData(Icons.home_rounded, "Home"),
    _NavData(Icons.bar_chart_rounded, "Stats"),
    _NavData(Icons.wallet_rounded, "Wallet"),
    _NavData(Icons.person_rounded, "Profile"),
  ];

  void handleNavTap(int index) {
    if (index == 1) {
      setState(() => selectedIndex = 1);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StatsPage()),
      ).then((_) {
        setState(() => selectedIndex = 0);
      });
    } else if (index == 2) {
      setState(() => selectedIndex = 2);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WalletPage()),
      ).then((_) {
        setState(() => selectedIndex = 0);
      });
    } else if (index == 3) {
      setState(() => selectedIndex = 3);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      ).then((_) {
        setState(() => selectedIndex = 0);
      });
    } else {
      setState(() => selectedIndex = index);
    }
  }

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
            return _FloatingNavItem(
              icon: items[index].icon,
              label: items[index].label,
              isActive: selectedIndex == index,
              onTap: () => handleNavTap(index),
            );
          }),
        ),
      ),
    );
  }
}

class _FloatingNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FloatingNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        scale: isActive ? 1.05 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: isActive ? 15 : 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF9FE870) : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
            boxShadow: isActive
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
                icon,
                color: isActive ? const Color(0xFF102118) : Colors.white60,
                size: 23,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: isActive
                    ? Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text(
                    label,
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
      ),
    );
  }
}

class _NavData {
  final IconData icon;
  final String label;

  const _NavData(this.icon, this.label);
}