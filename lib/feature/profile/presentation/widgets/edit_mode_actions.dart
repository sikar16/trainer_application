import 'package:flutter/material.dart';

class EditModeActions extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const EditModeActions({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton.icon(
            onPressed: onCancel,
            icon: const Icon(Icons.close, size: 18),
            label: const Text("Cancel"),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(color: Colors.grey[400]!),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.check, size: 18),
            label: const Text("Save Changes"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }
}
