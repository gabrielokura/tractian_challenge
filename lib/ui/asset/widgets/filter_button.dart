import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_challenge/ui/core/colors.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.text,
    required this.icon,
    this.isSelected = false,
    this.onPress,
  });

  final String text;
  final IconData icon;
  final bool isSelected;

  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPress,
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? AppColors.lightBlue : Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          side: isSelected
              ? BorderSide.none
              : BorderSide(color: AppColors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      icon: Icon(
        icon,
        color: isSelected ? AppColors.white : AppColors.grey,
        size: 22,
      ),
      label: Text(text,
          style: GoogleFonts.roboto(
            color: isSelected ? AppColors.white : AppColors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
