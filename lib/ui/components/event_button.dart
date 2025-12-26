import 'package:flutter/material.dart';
import 'package:ghost/constants/app_colors.dart';
import 'package:ghost/core/providers/current_platform.dart';
import 'package:ghost/ui/style/borders_style.dart';

class EventButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? borderColor;
  final void Function()? onTap;

  const EventButton({
    super.key,
    this.color,
    this.borderColor,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size sizeDevice = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 650),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderStyleApp.borderCircular12,
        child: Ink(
          width: isMobile.value
              ? sizeDevice.width * .9
              : sizeDevice.width * .57,
          padding: EdgeInsets.only(top: 14, bottom: 14),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor ?? Colors.transparent),
            borderRadius: BorderStyleApp.borderCircular12,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: AppColors.whiteColor, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
