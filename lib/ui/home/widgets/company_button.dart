import 'package:flutter/material.dart';
import 'package:tractian_challenge/ui/core/colors.dart';

class CompanyButton extends StatelessWidget {
  const CompanyButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBlue,
          minimumSize: Size.fromHeight(70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.widgets,
              color: AppColors.white,
            ),
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ));
  }
}
