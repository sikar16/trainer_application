import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String traningName;
  final String locaton;
  final String time;
  final String age;
  final String rationale;
  final String nextpage;
  final VoidCallback onNextTap;

  const CustomCard({
    super.key,
    required this.traningName,
    required this.locaton,
    required this.time,
    required this.age,
    required this.rationale,
    required this.nextpage,
    required this.onNextTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        //
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              traningName,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: colorTheme.secondary,
                ),
                const SizedBox(width: 4),
                Text("N/A", style: TextStyle(fontSize: 10)),
                const SizedBox(width: 16),

                Icon(
                  Icons.timer_outlined,
                  size: 14,
                  color: colorTheme.secondary,
                ),
                const SizedBox(width: 4),
                Text(time, style: TextStyle(fontSize: 10)),
                const SizedBox(width: 16),

                Text(age, style: TextStyle(fontSize: 10)),
              ],
            ),

            const SizedBox(height: 8),

            Text(rationale, style: TextStyle(fontSize: 12)),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: onNextTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      nextpage,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorTheme.primary,
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: colorTheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
