import 'package:flutter/material.dart';

class CostomDropDown extends StatefulWidget {
  final String title;
  final Widget? content;
  final VoidCallback? onTap;
  final String? groupKey;
  const CostomDropDown({
    super.key,
    required this.title,
    this.content,
    this.onTap,
    this.groupKey,
  });

  @override
  State<CostomDropDown> createState() => _CostomDropDownState();
}

class _CostomDropDownState extends State<CostomDropDown> {
  bool isExpanded = false;

  static final Map<String, _CostomDropDownState?> _expandedDropdowns =
      <String, _CostomDropDownState?>{};

  @override
  void initState() {
    super.initState();
    final group = widget.groupKey ?? 'default';
    _expandedDropdowns[group] = this;
  }

  @override
  void dispose() {
    final group = widget.groupKey ?? 'default';
    if (_expandedDropdowns[group] == this) {
      _expandedDropdowns[group] = null;
    }
    super.dispose();
  }

  void _toggleExpansion() {
    if (widget.content != null) {
      final group = widget.groupKey ?? 'default';

      if (isExpanded) {
        setState(() {
          isExpanded = false;
        });
        _expandedDropdowns[group] = null;
        return;
      }

      final currentExpanded = _expandedDropdowns[group];
      if (currentExpanded != null && currentExpanded.mounted) {
        currentExpanded.setState(() {
          currentExpanded.isExpanded = false;
        });
      }

      setState(() {
        isExpanded = true;
      });
      _expandedDropdowns[group] = this;
    } else {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    final hasContent = widget.content != null;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _toggleExpansion,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isExpanded
                    ? const Color(0xFFF8FBFF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(widget.title, style: TextStyle(fontSize: 14)),
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
            ),

            if (isExpanded && hasContent)
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: widget.content,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
