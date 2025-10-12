import 'package:flutter/material.dart';
import 'dart:math' as math;

class SoldOverlay extends StatelessWidget {
  const SoldOverlay({super.key, this.size = 60.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: SoldOverlayPainter());
  }
}

class SoldOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Create the starburst shape
    final paint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;

    final path = Path();

    // Create starburst points
    const numPoints = 12;
    const angleStep = 2 * math.pi / numPoints;

    for (int i = 0; i < numPoints; i++) {
      final angle = i * angleStep;
      final outerRadius = radius;
      final innerRadius = radius * 0.75;

      // Outer point
      final outerX = center.dx + outerRadius * math.cos(angle);
      final outerY = center.dy + outerRadius * math.sin(angle);

      // Inner point
      final innerX = center.dx + innerRadius * math.cos(angle + angleStep / 2);
      final innerY = center.dy + innerRadius * math.sin(angle + angleStep / 2);

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      path.lineTo(innerX, innerY);
    }
    path.close();

    canvas.drawPath(path, paint);

    // Add "SOLD" text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'SOLD',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

