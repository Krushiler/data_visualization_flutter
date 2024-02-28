import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';

class ScatterPainter extends FlDotPainter {
  final Color color;
  final double sizeFactor;

  ScatterPainter({required this.color, required this.sizeFactor});

  final _paint = Paint()..style = PaintingStyle.fill;

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    _paint.color = color;

    canvas.drawCircle(offsetInCanvas, 8 * sizeFactor, _paint);
  }

  @override
  Size getSize(FlSpot spot) {
    return Size(16 * sizeFactor, 16 * sizeFactor);
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is! ScatterPainter || b is! ScatterPainter) {
      return b;
    }
    return ScatterPainter(
      color: Color.lerp(a.color, b.color, t)!,
      sizeFactor: lerpDouble(a.sizeFactor, b.sizeFactor, t)!,
    );
  }

  @override
  Color get mainColor => color;

  @override
  List<Object?> get props => [color, sizeFactor];
}
