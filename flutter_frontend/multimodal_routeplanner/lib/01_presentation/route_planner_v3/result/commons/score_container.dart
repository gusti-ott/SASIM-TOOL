import 'package:flutter/material.dart';

enum ShapeDirection { left, right, top, bottom }

class CustomShapeWidget extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final ShapeDirection direction;
  final Size size;

  const CustomShapeWidget({
    super.key,
    required this.color,
    required this.borderColor,
    required this.direction,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: MyShapePainter(color: color, borderColor: borderColor, direction: direction),
    );
  }
}

class MyShapePainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final ShapeDirection direction;

  MyShapePainter({required this.color, required this.borderColor, required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0; // Adjust the border width as needed

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    switch (direction) {
      case ShapeDirection.left:
        path.moveTo(size.width * 0.5, 0);
        path.arcToPoint(
          Offset(size.width * 0.5, size.height),
          radius: Radius.circular(size.width * 0.5),
          clockwise: false,
        );
        path.lineTo(0, size.height);
        path.lineTo(0, 0);
        break;
      case ShapeDirection.right:
        path.moveTo(size.width * 0.5, 0);
        path.arcToPoint(
          Offset(size.width * 0.5, size.height),
          radius: Radius.circular(size.width * 0.5),
          clockwise: true,
        );
        path.lineTo(size.width, size.height);
        path.lineTo(size.width, 0);
        break;
      case ShapeDirection.top:
        path.moveTo(0, size.height * 0.5);
        path.arcToPoint(
          Offset(size.width, size.height * 0.5),
          radius: Radius.circular(size.height * 0.5),
          clockwise: true,
        );
        path.lineTo(size.width, 0);
        path.lineTo(0, 0);
        break;
      case ShapeDirection.bottom:
        path.moveTo(0, size.height * 0.5);
        path.arcToPoint(
          Offset(size.width, size.height * 0.5),
          radius: Radius.circular(size.height * 0.5),
          clockwise: false,
        );
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        break;
    }
    path.close();

    // Draw the border first
    canvas.drawPath(path, borderPaint);
    // Draw the filled shape
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
