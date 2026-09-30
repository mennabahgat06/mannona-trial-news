import 'package:flutter/material.dart';
import 'category_chip.dart';

/// Horizontal list of category chips.
class CategoriesBar extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoriesBar({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map((category) => CategoryChip(
                  label: category,
                  isSelected: category == selected,
                  onTap: () => onSelected(category),
                ))
            .toList(),
      ),
    );
  }
}
