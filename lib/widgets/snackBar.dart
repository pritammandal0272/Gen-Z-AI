import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:voice_assistant/controller/getxController.dart';

void showSnackbarFunction(
  BuildContext context,
  String text,
  Color colorValue,
  iconMessage,
) {
  final colorsScheme = Theme.of(context).colorScheme;
  var getxController = Get.find<getController>();
  showTopSnackBar(
    Overlay.of(context),
    Container(
      height: 64,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: colorsScheme.surface,
        border: Border.all(color: colorValue.withOpacity(.6)),
        boxShadow: [
          BoxShadow(
            color: colorValue.withOpacity(.45),
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          // scan indicator
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  colorValue.withOpacity(.9),
                  colorValue.withOpacity(.3),
                ],
              ),
              boxShadow: [BoxShadow(color: colorValue, blurRadius: 5)],
            ),
            child: Icon(iconMessage, color: Colors.white, size: 20),
          ),

          SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: getxController.darkMode.value
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w600,
                // letterSpacing: .3,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    ),
    animationDuration: const Duration(milliseconds: 600),
    displayDuration: const Duration(seconds: 2),
    curve: Curves.easeOutCubic,
  );
}
