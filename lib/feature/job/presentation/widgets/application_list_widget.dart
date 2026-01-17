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
    return Row(
      children: [
        _filterItem("View All", ApplicationFilter.all),
        const SizedBox(width: 12),
        _filterItem("Accepted", ApplicationFilter.accepted),
        const SizedBox(width: 12),
        _filterItem("Rejected", ApplicationFilter.rejected),
        const SizedBox(width: 12),
        _filterItem("Pending", ApplicationFilter.pending),
      ],
    );
  }

  Widget _filterItem(String title, ApplicationFilter filter) {
    final bool selected = selectedFilter == filter;

    return GestureDetector(
      onTap: () => setState(() => selectedFilter = filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.grey.shade200 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.black : Colors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
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
