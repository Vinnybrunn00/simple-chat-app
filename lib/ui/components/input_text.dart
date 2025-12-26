import 'package:flutter/material.dart';
import 'package:ghost/constants/app_colors.dart';
import 'package:ghost/core/providers/current_platform.dart';
import 'package:ghost/ui/style/borders_style.dart';

class InputText extends StatelessWidget {
  final String label;
  final void Function(String)? onChanged;

  const InputText({super.key, required this.label, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 650),
      height: 50,
      margin: EdgeInsets.only(
        left: isMobile.value ? 18 : 150,
        right: isMobile.value ? 18 : 150,
      ),
      child: TextFormField(
        onChanged: onChanged,
        style: TextStyle(color: AppColors.whiteColor),
        cursorWidth: 1,
        cursorColor: AppColors.pupleColor,
        decoration: InputDecoration(
          label: Text(label),
          floatingLabelStyle: TextStyle(
            color: AppColors.whiteColor.withAlpha(90),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderStyleApp.borderCircular12,
            borderSide: BorderSide(width: 1.4, color: AppColors.pupleColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderStyleApp.borderCircular12,
            borderSide: BorderSide(color: AppColors.pupleLowColor),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
