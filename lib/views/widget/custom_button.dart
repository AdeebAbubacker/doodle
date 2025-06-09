import 'package:doodle/core/const/colors.dart';
import 'package:doodle/core/const/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final Color backgroundColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.backgroundColor = AppColors.greenF50, // Default to green
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ?  CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
              )
            : Text(
                label,
                style: AppTextStyles.whiteWboldS16,
              ),
      ),
    );
  }
}
