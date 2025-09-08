// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class CustomThumbShape extends SfThumbShape {
  @override
  Size getPreferredSize(SfSliderThemeData themeData) {
    return const Size.fromRadius(20.0); // Customize the size of the thumb
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required RenderBox? child,
    required SfSliderThemeData themeData,
    SfRangeValues? currentValues,
    dynamic currentValue,
    required Paint? paint,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required SfThumb? thumb,
  }) {
    final Paint trianglePaint = paint ?? Paint()
      ..color = themeData.thumbColor ?? Colors.grey
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final double thumbSize = getPreferredSize(themeData).width;
    final double halfThumbSize = thumbSize / 3.5;
    final double quarterThumbSize = thumbSize / 5.5;

    final Path path = Path()
      ..moveTo(center.dx, center.dy - halfThumbSize)
      ..lineTo(center.dx - quarterThumbSize, center.dy + halfThumbSize)
      ..lineTo(center.dx + quarterThumbSize, center.dy + halfThumbSize)
      ..close();

    context.canvas.drawPath(path, trianglePaint);

    if (child != null) {
      context.paintChild(
          child,
          Offset(center.dx - (child.size.width) / 1.5,
              center.dy - (child.size.height) / 1.5));
    }

    if (themeData.thumbStrokeColor != null &&
        themeData.thumbStrokeWidth != null &&
        themeData.thumbStrokeWidth! > 0) {
      final Paint strokePaint = Paint()
        ..color = themeData.thumbStrokeColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = themeData.thumbStrokeWidth!;
      context.canvas.drawPath(path, strokePaint);
    }
  }
}
