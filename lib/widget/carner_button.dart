import 'package:flutter/material.dart';

import '../resource/app_colors.dart';
import '../resource/app_dimension.dart';
import '../resource/app_font.dart';

class CustomShapeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isTopLeft;
  final Color color;
  final Color borderColor;
  final Color textColor;

  CustomShapeButton({
    required this.text,
    required this.onPressed,
    required this.isTopLeft,
    required this.color,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = TextStyle(
            fontSize: AppDimen.textSize16,
            color: textColor,
            fontFamily: AppFont.font,
            fontWeight: AppFont.bold);
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: textStyle),
          textDirection: TextDirection.ltr,
        )..layout();

        final textWidth = textPainter.width;
        final textHeight = textPainter.height;

        return GestureDetector(
          onTap: onPressed,
          child: CustomPaint(
            size: Size(textWidth + 20, textHeight + 20),
            painter: ButtonShapePainter(isTopLeft, color, borderColor),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ButtonShapePainter extends CustomPainter {
  final bool isTopLeft;
  final Color color;
  final Color borderColor;

  ButtonShapePainter(this.isTopLeft, this.color, this.borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5; // Set the border thickness

    final path = Path();

    double leftTopWidthReduction = isTopLeft ? 10.0 : 0.0;
    double bottomRightWidthReduction = isTopLeft ? 0.0 : 10.0;

    double bottomWidth = size.width - bottomRightWidthReduction;

    // Draw the custom shape
    path.moveTo(leftTopWidthReduction, 0);
    path.lineTo(size.width, 0);
    path.lineTo(bottomWidth, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, borderPaint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
