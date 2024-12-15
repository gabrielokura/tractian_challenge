import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/three_item.dart';

import '../../core/colors.dart';

class ThreeItemIndicator extends StatelessWidget {
  const ThreeItemIndicator({super.key, required this.type});

  final SensorType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Row(
        children: [
          if (type == SensorType.energy)
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                size: 16,
                color: AppColors.green,
                Icons.bolt,
              ),
            ),
          if (type == SensorType.vibration)
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                size: 12,
                color: AppColors.red,
                Icons.fiber_manual_record,
              ),
            ),
        ],
      ),
    );
  }
}
