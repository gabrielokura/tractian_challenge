import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/three_item.dart';
import 'package:tractian_challenge/ui/core/colors.dart';

class ThreeItemIcon extends StatelessWidget {
  const ThreeItemIcon({super.key, required this.type});

  final ThreeItemType type;

  IconData get icon {
    switch (type) {
      case ThreeItemType.asset:
        return Icons.gif_box;
      case ThreeItemType.component:
        return Icons.code;
      case ThreeItemType.location:
        return Icons.location_on_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Icon(
        icon,
        size: 20,
        color: AppColors.lightBlue,
      ),
    );
  }
}
