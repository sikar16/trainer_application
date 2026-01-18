import 'package:flutter/material.dart';

class CostomDropDown extends StatefulWidget {
  final String title;
  final Widget? content;
  final VoidCallback? onTap;

  const CostomDropDown({
    super.key,
    required this.title,
    this.content,
    this.onTap,
  });

  @override
  State<CostomDropDown> createState() => _CostomDropDownState();
}

class _CostomDropDownState extends State<CostomDropDown> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final hasContent = widget.content != null;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          if (hasContent) {
            setState(() => isExpanded = !isExpanded);
          } else {
            widget.onTap?.call();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (hasContent)
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: colorTheme.primary,
                    ),
                ],
              ),
            ),
            if (isExpanded && hasContent)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: widget.content,
              ),
          ],
        ),
      ),
    );
  }
}
