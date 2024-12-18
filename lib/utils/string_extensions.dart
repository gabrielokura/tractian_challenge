import 'package:flutter/material.dart';
import 'package:tractian_challenge/ui/core/colors.dart';

// Reference: https://github.com/Eronildo/tractian/blob/main/lib/core/extensions/string_extension.dart
extension StringExtension on String {
  List<String> splitWith({required String text}) {
    final RegExp regExp = RegExp(text, caseSensitive: false);
    final List<String> result = [];

    int lastMatchEnd = 0;
    for (final match in regExp.allMatches(this)) {
      if (match.start > lastMatchEnd) {
        result.add(substring(lastMatchEnd, match.start));
      }
      result.add(match.group(0)!);
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < length) {
      result.add(substring(lastMatchEnd));
    }

    return result;
  }

  List<TextSpan> getTextSpansWithHighlightedTexts(
    String searchQuery,
    TextStyle style,
  ) {
    List<String> parts = splitWith(text: searchQuery);

    return parts.map((part) {
      if (part.toLowerCase() == searchQuery.toLowerCase()) {
        return TextSpan(
          text: part.toUpperCase(),
          style: style.copyWith(color: AppColors.red),
        );
      } else {
        return TextSpan(
          text: part.toUpperCase(),
          style: style,
        );
      }
    }).toList();
  }
}
