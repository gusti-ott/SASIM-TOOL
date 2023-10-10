import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class CustomAnimatedTableCell extends StatefulWidget {
  const CustomAnimatedTableCell(
      {super.key,
      required this.selectedTrip,
      required this.animationController,
      required this.animation,
      required this.child});

  final Trip selectedTrip;
  final AnimationController animationController;
  final Animation animation;
  final Widget child;

  @override
  State<CustomAnimatedTableCell> createState() =>
      _CustomAnimatedTableCellState();
}

class _CustomAnimatedTableCellState extends State<CustomAnimatedTableCell>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: AnimatedBuilder(
          animation: widget.animation,
          builder: (context, child) {
            return Opacity(
              opacity: widget.animation.value,
              child: widget.child,
            );
          }),
    );
  }
}
