import 'package:flutter/material.dart';
import 'package:training/core/widgets/app_drawer.dart';
import 'package:training/core/widgets/custom_appbar.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

enum TopTab { jobs, applications }

enum JobFilter { all, active, newJob }

enum ApplicationFilter { all, accepted, rejected, pending }

class _JobScreenState extends State<JobScreen> {
  TopTab selectedTopTab = TopTab.jobs;
  JobFilter selectedJobFilter = JobFilter.all;
  ApplicationFilter selectedApplicationFilter = ApplicationFilter.all;

  final List<Map<String, String>> jobs = [
    {
      "title": "Bahirdar Mesenado Tuesday Afternoon (Oct 21)",
      "date": "10/21/2025 - 10/31/2025",
    },
    {
      "title": "Bahirdar Mesenado Monday Afternoon (Oct 20)",
      "date": "10/20/2025 - 10/31/2025",
    },
  ];

  final List applications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        title: "Job",
        onMenuTap: () => scaffoldKey.currentState?.openDrawer(),
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _topTabs(),
            const SizedBox(height: 16),
            _filterTabs(),
            const SizedBox(height: 16),
            _searchBar(),
            const SizedBox(height: 24),
            Expanded(child: _content()),
          ],
        ),
      ),
    );
  }

  Widget _topTabs() {
    return Row(
      children: [
        _topTab("Jobs", TopTab.jobs),
        const SizedBox(width: 24),
        _topTab("My Applications", TopTab.applications),
      ],
    );
  }

  Widget _topTab(String title, TopTab tab) {
    final bool selected = selectedTopTab == tab;

    return GestureDetector(
      onTap: () => setState(() => selectedTopTab = tab),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: selected ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
          if (selected)
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 2,
              width: tab == TopTab.jobs ? 40 : 120,
              color: Theme.of(context).primaryColor,
            ),
        ],
      ),
    );
  }

  Widget _filterTabs() {
    return selectedTopTab == TopTab.jobs
        ? _jobFilters()
        : _applicationFilters();
  }

  Widget _jobFilters() {
    return _filterContainer(
      children: [
        _filterItem(
          "View All",
          selectedJobFilter == JobFilter.all,
          () => setState(() => selectedJobFilter = JobFilter.all),
        ),
        _filterItem(
          "Active",
          selectedJobFilter == JobFilter.active,
          () => setState(() => selectedJobFilter = JobFilter.active),
        ),
        _filterItem(
          "New",
          selectedJobFilter == JobFilter.newJob,
          () => setState(() => selectedJobFilter = JobFilter.newJob),
        ),
      ],
    );
  }

  Widget _applicationFilters() {
    return _filterContainer(
      children: [
        _filterItem(
          "View All",
          selectedApplicationFilter == ApplicationFilter.all,
          () =>
              setState(() => selectedApplicationFilter = ApplicationFilter.all),
        ),
        _filterItem(
          "Accepted",
          selectedApplicationFilter == ApplicationFilter.accepted,
          () => setState(
            () => selectedApplicationFilter = ApplicationFilter.accepted,
          ),
        ),
        _filterItem(
          "Rejected",
          selectedApplicationFilter == ApplicationFilter.rejected,
          () => setState(
            () => selectedApplicationFilter = ApplicationFilter.rejected,
          ),
        ),
        _filterItem(
          "Pending",
          selectedApplicationFilter == ApplicationFilter.pending,
          () => setState(
            () => selectedApplicationFilter = ApplicationFilter.pending,
          ),
        ),
      ],
    );
  }

  Widget _filterContainer({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(children: children),
    );
  }

  Widget _filterItem(String title, bool selected, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? const Color.fromARGB(255, 246, 246, 246)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected
                  ? Colors.black
                  : const Color.fromARGB(215, 0, 0, 0),
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _content() {
    if (selectedTopTab == TopTab.jobs) {
      return jobs.isEmpty ? _emptyState() : _jobList();
    } else {
      return applications.isEmpty ? _emptyState() : const SizedBox();
    }
  }

  Widget _jobList() {
    return ListView.separated(
      itemCount: jobs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final job = jobs[index];
        return JobCard(title: job["title"]!, date: job["date"]!);
      },
    );
  }

  Widget _emptyState() {
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
        const Text(
          "No Jobs Available",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "There are currently no jobs available.\nCheck back later.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class JobCard extends StatelessWidget {
  final String title;
  final String date;

  const JobCard({super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          /// Date + Sessions
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(date, style: TextStyle(color: Colors.grey.shade600)),
              const Spacer(),
              Icon(
                Icons.menu_book_outlined,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Text("1 Sessions", style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),

          const SizedBox(height: 16),

          /// Subtitle
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),

          const SizedBox(height: 12),

          /// Time ago
          Text(
            "3 months ago",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),

          const SizedBox(height: 24),

          /// Button
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: themeColor),
                foregroundColor: themeColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "View Detail",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
