import 'package:flutter/material.dart';

class CustomPopupDropdown<T> extends StatelessWidget {
  final T? selectedItem;
  final List<DropdownMenuItem<T>> items;
  final String hint;
  final void Function(T) onSelected;

  const CustomPopupDropdown({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.onSelected,
    this.hint = "Select",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: PopupMenuButton<T>(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedItem != null ? _getItemLabel(selectedItem!) : hint,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
        onSelected: onSelected,
        itemBuilder: (context) {
          return items
              .map(
                (item) =>
                    PopupMenuItem<T>(value: item.value, child: item.child),
              )
              .toList();
        },
      ),
    );
  }

  String _getItemLabel(T item) {
    // Find the label of the selected item
    final match = items.firstWhere((i) => i.value == item);
    if (match.child is Text) {
      return (match.child as Text).data ?? "";
    }
    return item.toString();
  }
}
