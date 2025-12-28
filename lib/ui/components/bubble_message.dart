import 'package:flutter/material.dart';
import 'package:ghost/constants/app_colors.dart';

class BubbleMessage extends StatelessWidget {
  final String? time;
  final String username;
  final String message;
  final bool isNotMe;

  const BubbleMessage({
    super.key,
    required this.time,
    required this.username,
    required this.message,
    required this.isNotMe,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10, left: 8, right: 8),
      width: deviceSize.width * .85,
      child: Text(
        isNotMe ? '$time $username: $message' : '$time: $message',
        style: TextStyle(
          color: isNotMe
              ? AppColors.whiteColor.withAlpha(180)
              : Colors.cyanAccent.withAlpha(180),
          overflow: TextOverflow.clip,
        ),
        textAlign: isNotMe ? TextAlign.start : TextAlign.end,
      ),
    );
  }
}
