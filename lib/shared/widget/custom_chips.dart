import 'package:flutter/material.dart';

class CustomChips extends StatelessWidget {
  const CustomChips(
      {super.key,
      this.isSelected = false,
      required this.onSelected,
      required this.title});
  final bool isSelected;
  final Function(bool isSelected) onSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: FittedBox(child: Text(title)),
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}
