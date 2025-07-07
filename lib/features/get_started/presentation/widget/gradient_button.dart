import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/theme/colors_pallete.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      radius: 0.1,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.accents[1], Colors.accents[2], Colors.accents[3]],
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 25,
              color: AppColors.kWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
