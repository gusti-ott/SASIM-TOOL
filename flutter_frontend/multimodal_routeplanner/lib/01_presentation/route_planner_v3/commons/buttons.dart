import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget v3CustomButton(
    {required String label, required Function onTap, Color? color, Color? textColor, IconData? leadingIcon}) {
  return IntrinsicWidth(
    child: InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: color ?? primaryColorV3,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mediumPadding, vertical: smallPadding),
            child: Row(
              children: [
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, color: textColor ?? Colors.white),
                  smallHorizontalSpacer
                ],
                Text(
                  label,
                  style: TextStyle(color: textColor ?? Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
