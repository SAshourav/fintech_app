import 'package:flutter/material.dart';

class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        "icon": Icons.arrow_downward_rounded,
        "title": "Deposit",
        "color": const Color(0xFF10B981),
      },
      {
        "icon": Icons.swap_horiz_rounded,
        "title": "Transfer",
        "color": const Color(0xFF3B82F6),
      },
      {
        "icon": Icons.arrow_upward_rounded,
        "title": "Withdraw",
        "color": const Color(0xFFF59E0B),
      },
      {
        "icon": Icons.grid_view_rounded,
        "title": "More",
        "color": const Color(0xFF8B5CF6),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((action) {
          return _ActionButton(
            icon: action["icon"] as IconData,
            title: action["title"] as String,
            color: action["color"] as Color,
          );
        }).toList(),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => isPressed = true);
      },
      onTapUp: (_) {
        setState(() => isPressed = false);
      },
      onTapCancel: () {
        setState(() => isPressed = false);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: isPressed ? 0.92 : 1,
        child: Column(
          children: [

            /// ICON CONTAINER
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 68,
              width: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  colors: [
                    widget.color.withOpacity(0.25),
                    widget.color.withOpacity(0.10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: widget.color.withOpacity(0.35),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.25),
                    blurRadius: isPressed ? 8 : 18,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: widget.color,
                size: 30,
              ),
            ),

            const SizedBox(height: 10),

            /// TITLE
            Text(
              widget.title,
              style: const TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            )
          ],
        ),
      ),
    );
  }
}