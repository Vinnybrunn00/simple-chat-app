import 'package:flutter/material.dart';
import 'package:ghost/constants/app_colors.dart';
import 'package:ghost/core/providers/current_platform.dart';

class InputMessage extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function()? sendMessage;
  final TextEditingController? controller;

  const InputMessage({
    super.key,
    this.onChanged,
    this.sendMessage,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * .15,
        minHeight: size.height * .06,
        maxWidth: size.width,
      ),
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withAlpha(100)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.text,
                onChanged: onChanged,
                style: TextStyle(color: AppColors.whiteColor),
                autofocus: isMobile.value ? false : true,
                cursorColor: Colors.white.withAlpha(75),
                cursorHeight: 20,
                minLines: 1,
                maxLines: 5,
                cursorWidth: 1.5,
                decoration: InputDecoration(
                  hintText: 'Typing a message...',
                  hintStyle: TextStyle(
                    color: Colors.white.withAlpha(75),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            InkWell(
              onTap: sendMessage,
              borderRadius: BorderRadius.circular(22.5),
              child: Ink(
                height: 45,
                width: 45,
                child: Center(
                  child: Icon(Icons.send, color: AppColors.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
