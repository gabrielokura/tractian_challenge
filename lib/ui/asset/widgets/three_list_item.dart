import 'package:flutter/material.dart';
import 'package:tractian_challenge/ui/asset/widgets/three_item_icon.dart';
import 'package:tractian_challenge/ui/asset/widgets/three_item_indicator.dart';

import '../../../domain/models/three_item.dart';

class ThreeListItem extends StatelessWidget {
  const ThreeListItem(
      {super.key, required this.item, required this.isExpandable});

  final ThreeItem item;
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
        ThreeItemIcon(type: item.type),
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
          ThreeItemIndicator(
            type: item.sensorType == 'energy'
                ? SensorType.energy
                : SensorType.vibration,
          ),
      ],
    );
  }
}
