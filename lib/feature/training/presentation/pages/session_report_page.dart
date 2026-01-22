import 'package:flutter/material.dart';
import '../widgets/view_report_widget.dart';

class SessionReportPage extends StatelessWidget {
  final String sessionId;

  const SessionReportPage({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return ViewReportPage(sessionId: sessionId);
  }
}

// Example usage:
// To navigate to the report page, use:
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => SessionReportPage(
//       sessionId: '558f4071-c23e-4ff7-8d6c-3b70bf1128c4',
//     ),
//   ),
// );
