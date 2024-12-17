import 'package:flutter/material.dart';
import 'package:tractian_challenge/config/assets.dart';
import 'package:tractian_challenge/domain/models/tree_item.dart';
import 'package:tractian_challenge/ui/core/colors.dart';

class TreeItemIcon extends StatelessWidget {
  const TreeItemIcon({super.key, required this.type});

  final TreeItemType type;

  String get icon {
    switch (type) {
      case TreeItemType.asset:
        return Assets.assetIcon;
      case TreeItemType.component:
        return Assets.componentIcon;
      case TreeItemType.location:
        return Assets.locationIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Image.asset(
        icon,
        width: 26,
        height: 26,
        fit: BoxFit.fitHeight,
        color: AppColors.lightBlue,
      ),
    );
  }
}
