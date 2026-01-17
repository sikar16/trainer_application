import 'package:flutter/material.dart';
import 'package:training/core/widgets/app_drawer.dart';
import 'package:training/core/widgets/custom_appbar.dart';
import '../widgets/job_list_widget.dart';
import '../widgets/application_list_widget.dart';

enum TopTab { jobs, applications }

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _JobScreenState extends State<JobScreen> {
  TopTab selectedTopTab = TopTab.jobs;

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
              fontWeight: FontWeight.normal,
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

  Widget _content() {
    if (selectedTopTab == TopTab.jobs) {
      return const JobListWidget();
    } else {
      return const ApplicationListWidget();
    }
  }
}
