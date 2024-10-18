import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/app_theme.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color? overlayColor;
  final Color bgColor;
  final Function() ontap;

  const MyButton({
    super.key,
    required this.title,
     this.overlayColor,
    required this.bgColor,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
            overlayColor: overlayColor,
            fixedSize: const Size.fromWidth(300),
            backgroundColor: bgColor),
        child: Text(
          title,
          style: AppTheme.subtitle,
        ),
      ),
    );
  }
}
