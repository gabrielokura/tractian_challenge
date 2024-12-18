import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_challenge/ui/asset/widgets/tree_item_icon.dart';
import 'package:tractian_challenge/ui/asset/widgets/tree_item_indicator.dart';
import 'package:tractian_challenge/utils/string_extensions.dart';

import '../../../domain/models/tree_item.dart';

class TreeListItem extends StatelessWidget {
  const TreeListItem({
    super.key,
    required this.item,
    required this.isExpandable,
    required this.searchQuery,
  });

  final TreeItem item;
  final bool isExpandable;

  final String searchQuery;

  final itemHeight = 40.0;
  final arrowIconWidth = 24.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < item.depth; i++)
            Container(
              margin: EdgeInsets.only(left: arrowIconWidth / 2),
              width: 1,
              height: itemHeight,
              color: Colors.grey.withValues(alpha: 0.6),
            ),
          if (isExpandable)
            Icon(
              item.isExpanded
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_right_rounded,
              size: arrowIconWidth,
            )
          else
            SizedBox(width: item.depth == 0 ? 0 : arrowIconWidth),
          TreeItemIcon(type: item.type),
          Flexible(
            child: Tooltip(
              message: item.name,
              child: Text.rich(
                style: const TextStyle(overflow: TextOverflow.ellipsis),
                TextSpan(
                  children: searchQuery.isNotEmpty
                      ? item.name.getTextSpansWithHighlightedTexts(
                          searchQuery,
                          GoogleFonts.roboto(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )
                      : [
                          TextSpan(
                            text: item.name.toUpperCase(),
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                ),
              ),
            ),
          ),
          if (item.sensorType != null)
            TreeItemIndicator(
              type: item.sensorType!,
            ),
        ],
      ),
    );
  }
}
