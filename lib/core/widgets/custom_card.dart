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

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            traningName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),

          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: colorTheme.secondary,
              ),
              const SizedBox(width: 5),
              Text("N/A", style: TextStyle(fontSize: 12)),
              const SizedBox(width: 20),

              Icon(Icons.timer_outlined, size: 16, color: colorTheme.secondary),
              const SizedBox(width: 5),
              Text(time, style: TextStyle(fontSize: 12)),
              const SizedBox(width: 20),

              Text(age, style: TextStyle(fontSize: 12)),
            ],
          ),

          const SizedBox(height: 15),

          Text(rationale, style: TextStyle(fontSize: 12)),

          const SizedBox(height: 20),

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
                      fontWeight: FontWeight.w700,
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
    );
  }
}
