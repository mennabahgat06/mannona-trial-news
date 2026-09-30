import 'package:flutter/material.dart';

/// Simple skyscrapers drawing (made with containers, no image needed).
class BuildingsIllustration extends StatelessWidget {
  const BuildingsIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 300,
      child: Stack(
        children: [
          _building(left: 10, width: 50, height: 140, color: const Color(0xFFF59E0B)),
          _building(right: 15, width: 65, height: 200, color: const Color(0xFF334155)),
          _building(left: 70, width: 75, height: 250, color: const Color(0xFF60A5FA)),
          _building(right: 50, width: 65, height: 180, color: const Color(0xFF1E3A8A)),
        ],
      ),
    );
  }

  Widget _building({
    double? left,
    double? right,
    required double width,
    required double height,
    required Color color,
  }) {
    return Positioned(
      left: left,
      right: right,
      bottom: 0,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
      ),
    );
  }
}
