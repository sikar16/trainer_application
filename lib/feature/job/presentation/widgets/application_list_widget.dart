import 'package:flutter/material.dart';

enum ApplicationFilter { all, accepted, rejected, pending }

class ApplicationListWidget extends StatefulWidget {
  const ApplicationListWidget({super.key});

  @override
  State<ApplicationListWidget> createState() => _ApplicationListWidgetState();
}

class _ApplicationListWidgetState extends State<ApplicationListWidget> {
  ApplicationFilter selectedFilter = ApplicationFilter.all;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _filterTabs(),
        const SizedBox(height: 16),
        Expanded(child: _content()),
      ],
    );
  }

  Widget _filterTabs() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segmentItem("View All", ApplicationFilter.all, isFirst: true),
          _verticalDivider(),
          _segmentItem("Accepted", ApplicationFilter.accepted),
          _verticalDivider(),
          _segmentItem("Rejected", ApplicationFilter.rejected),
          _verticalDivider(),
          _segmentItem("Pending", ApplicationFilter.pending, isLast: true),
        ],
      ),
    );
  }

  Widget _segmentItem(
    String title,
    ApplicationFilter filter, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final bool selected = selectedFilter == filter;

    return InkWell(
      onTap: () => setState(() => selectedFilter = filter),
      borderRadius: BorderRadius.horizontal(
        left: isFirst ? const Radius.circular(12) : Radius.zero,
        right: isLast ? const Radius.circular(12) : Radius.zero,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: isFirst ? const Radius.circular(12) : Radius.zero,
            right: isLast ? const Radius.circular(12) : Radius.zero,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(width: 1, height: 28, color: Colors.grey.shade300);
  }

  Widget _content() {
    switch (selectedFilter) {
      case ApplicationFilter.all:
        return _applicationList("All Applications");
      case ApplicationFilter.accepted:
        return _applicationList("Accepted Applications");
      case ApplicationFilter.rejected:
        return _applicationList("Rejected Applications");
      case ApplicationFilter.pending:
        return _applicationList("Pending Applications");
    }
  }

  Widget _applicationList(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.work_outline, size: 48, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        Text(
          "No $title Available",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "There are currently no applications available.\nCheck back later.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
