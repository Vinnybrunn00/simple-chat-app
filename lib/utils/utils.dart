import 'package:flutter/material.dart';
import 'package:ghost/constants/app_colors.dart';
import 'package:ghost/core/providers/current_platform.dart';
import 'package:ghost/ui/pages/home_page.dart';
import 'package:intl/intl.dart' as intl;

class Utils {
  void showMessageError(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: MediaQuery.of(context).size.width * .9,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          decoration: BoxDecoration(
            color: Color(0x4A0D1117),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void pushAndRemoveUntil(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
      (_) => false,
    );
  }

  String dateCreateAccountUser() {
    final DateTime dateTime = DateTime.now();
    final intl.DateFormat formatter = intl.DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(dateTime);
  }

  Future<Container?> showAuthModal(
    BuildContext context, {
    Widget? child,
  }) async {
    final Size sizeDevice = MediaQuery.of(context).size;
    return await showModalBottomSheet<Container?>(
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 8),
        height: sizeDevice.height * (isMobile.value ? .5 : .65),
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyBlackColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: child,
      ),
    );
  }
}
