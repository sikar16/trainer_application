import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  final ColorScheme colorScheme;
  const LoadingState(this.colorScheme, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2.5,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 20),
          Text(
            "Loading profile...",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
