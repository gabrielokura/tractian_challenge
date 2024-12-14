import 'package:flutter/material.dart';
import 'package:tractian_challenge/ui/core/colors.dart';

class ThreeItemIcon extends StatelessWidget {
  const ThreeItemIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Icon(
        Icons.wallet,
        size: 20,
        color: AppColors.lightBlue,
      ),
    );
  }
}
