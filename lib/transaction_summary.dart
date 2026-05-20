import 'package:flutter/material.dart';

class TransactionSummary extends StatelessWidget {
  const TransactionSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        "title": "Grocery Shopping",
        "subtitle": "Today • 10:30 AM",
        "amount": "- \$42.50",
        "icon": Icons.shopping_bag_rounded,
        "color": Color(0xFFF59E0B),
      },
      {
        "title": "Salary Received",
        "subtitle": "Yesterday • 6:00 PM",
        "amount": "+ \$620.00",
        "icon": Icons.account_balance_wallet_rounded,
        "color": Color(0xFF10B981),
      },
      {
        "title": "Netflix",
        "subtitle": "12 May • Subscription",
        "amount": "- \$18.99",
        "icon": Icons.movie_rounded,
        "color": Color(0xFFEF4444),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                "Transaction Summary",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Spacer(),
              Text(
                "See all",
                style: TextStyle(
                  color: Color(0xFF10505A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ...transactions.map((tx) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: (tx["color"] as Color).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      tx["icon"] as IconData,
                      color: tx["color"] as Color,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tx["title"] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tx["subtitle"] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    tx["amount"] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: (tx["amount"] as String).startsWith("+")
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}