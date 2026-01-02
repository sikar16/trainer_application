import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String traningName;
  final String locaton;
  final String time;
  final String age;
  final String nextpage;
  final VoidCallback onNextTap;

  const CustomCard({
    super.key,
    required this.traningName,
    required this.locaton,
    required this.time,
    required this.age,
    required this.nextpage,
    required this.onNextTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            traningName,
            style: textTheme.titleLarge?.copyWith(color: colorTheme.primary),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: colorTheme.secondary,
              ),
              const SizedBox(width: 5),
              Text(locaton, style: textTheme.bodySmall),
              const SizedBox(width: 20),

              Icon(Icons.timer_outlined, size: 16, color: colorTheme.secondary),
              const SizedBox(width: 5),
              Text(time, style: textTheme.bodySmall),
              const SizedBox(width: 20),

              Text(age, style: textTheme.bodySmall),
            ],
          ),

          const SizedBox(height: 20),

          Text(traningName, style: textTheme.bodyMedium),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: onNextTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    nextpage,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorTheme.primary,
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    size: 20,
                    color: colorTheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
