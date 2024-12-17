import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/tree_item.dart';
import 'package:tractian_challenge/ui/core/colors.dart';

class TreeItemIcon extends StatelessWidget {
  const TreeItemIcon({super.key, required this.type});

  final TreeItemType type;

  IconData get icon {
    switch (type) {
      case TreeItemType.asset:
        return Icons.gif_box;
      case TreeItemType.component:
        return Icons.code;
      case TreeItemType.location:
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
