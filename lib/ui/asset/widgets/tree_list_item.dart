import 'package:flutter/material.dart';
import 'package:tractian_challenge/ui/asset/widgets/tree_item_icon.dart';
import 'package:tractian_challenge/ui/asset/widgets/tree_item_indicator.dart';

import '../../../domain/models/tree_item.dart';

class TreeListItem extends StatelessWidget {
  const TreeListItem(
      {super.key, required this.item, required this.isExpandable});

  final TreeItem item;
  final bool isExpandable;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < item.depth; i++)
          Container(
            margin: const EdgeInsets.only(left: 12),
            width: 1,
            height: 30,
            color: Colors.grey,
          ),
        if (isExpandable)
          Icon(
            item.isExpanded
                ? Icons.keyboard_arrow_down_rounded
                : Icons.keyboard_arrow_right_rounded,
          )
        else
          const SizedBox(width: 12),
        TreeItemIcon(type: item.type),
        Flexible(
          child: Tooltip(
            message: item.name,
            child: Text.rich(
              style: const TextStyle(overflow: TextOverflow.ellipsis),
              TextSpan(
                children: [
                  TextSpan(
                    text: item.name.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (item.hasIndicator)
          TreeItemIndicator(
            type: item.sensorType == 'energy'
                ? SensorType.energy
                : SensorType.vibration,
          ),
      ],
    );
  }
}
