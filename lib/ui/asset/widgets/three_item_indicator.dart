import 'package:flutter/material.dart';

import '../../core/colors.dart';

class ThreeItemIndicator extends StatelessWidget {
  const ThreeItemIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(
              size: 16,
              color: AppColors.green,
              Icons.bolt,
            ),
          ),
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
