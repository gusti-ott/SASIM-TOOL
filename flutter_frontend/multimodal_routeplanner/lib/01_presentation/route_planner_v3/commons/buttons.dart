import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/colors_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

class V3CustomButton extends StatefulWidget {
  final String label;
  final Function onTap;
  final Color? color;
  final Color? textColor;
  final IconData? leadingIcon;
  final double? height;
  final bool reverseColors;

  const V3CustomButton(
      {Key? key,
      required this.label,
      required this.onTap,
      this.color,
      this.textColor,
      this.leadingIcon,
      this.height,
      this.reverseColors = false})
      : super(key: key);

  @override
  State<V3CustomButton> createState() => _V3CustomButtonState();
}

class _V3CustomButtonState extends State<V3CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = widget.color ?? primaryColorV3;
    final Color? borderColor = widget.reverseColors ? widget.color : null;
    final hoverColor = buttonColor.lighten(widget.reverseColors ? 0.6 : 0.15);
    TextTheme textTheme = Theme.of(context).textTheme;

    return IntrinsicWidth(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered = false;
            });
          },
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                widget.onTap();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: widget.height,
                decoration: BoxDecoration(
                  color: _isHovered
                      ? hoverColor
                      : (widget.reverseColors)
                          ? Colors.transparent
                          : buttonColor,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: borderColor ?? Colors.transparent),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mediumPadding, vertical: smallPadding),
                    child: Row(
                      children: [
                        if (widget.leadingIcon != null) ...[
                          Icon(widget.leadingIcon, color: widget.textColor ?? Colors.white),
                          smallHorizontalSpacer,
                        ],
                        Text(
                          widget.label,
                          style: textTheme.labelLarge!.copyWith(color: widget.textColor ?? Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
