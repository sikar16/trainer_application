import 'package:flutter/material.dart';
import '../../domain/entities/session_entity.dart';

class SessionCardWidget extends StatelessWidget {
  final SessionEntity session;
  final VoidCallback onViewAttendance;

  const SessionCardWidget({
    super.key,
    required this.session,
    required this.onViewAttendance,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    session.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date", style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: colorScheme.onSurface,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              session.formattedDate,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Time", style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(
                        session.formattedTime,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivery Method",
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 4),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              session.deliveryMethod.toLowerCase() == 'online'
                              ? Colors.green.withOpacity(0.15)
                              : Colors.grey.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          session.deliveryMethod[0].toUpperCase() +
                              session.deliveryMethod.substring(1).toLowerCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                session.deliveryMethod.toLowerCase() == 'online'
                                ? Colors.green
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Status and button row
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status", style: TextStyle(fontSize: 12)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(session.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _getStatusDotColor(session.status),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        session.status,
                        style: textTheme.bodySmall?.copyWith(
                          color: _getStatusTextColor(session.status),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: onViewAttendance,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View Attendance',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return const Color(0xFFE8F0FB);
      case 'completed':
        return const Color(0xFFE9F7EF);
      case 'cancelled':
        return const Color(0xFFFDEAEA);
      case 'in progress':
        return const Color(0xFFFFF7E6);
      default:
        return Colors.grey;
    }
  }

  Color _getStatusDotColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Colors.blue.shade300;
      case 'completed':
        return Colors.green.shade300;
      case 'cancelled':
        return Colors.red.shade300;
      case 'in progress':
        return Colors.orange.shade300;
      default:
        return Colors.grey.shade300;
    }
  }
}

Color _getStatusTextColor(String status) {
  switch (status.toLowerCase()) {
    case 'scheduled':
      return Colors.blue.shade700;

    case 'completed':
      return Colors.green.shade700;

    case 'cancelled':
      return Colors.red.shade700;

    case 'in progress':
      return Colors.orange.shade700;

    default:
      return Colors.grey.shade700;
  }
}
