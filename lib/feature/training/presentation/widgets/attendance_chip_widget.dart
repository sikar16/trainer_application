import 'package:flutter/material.dart';

class AttendanceChipWidget extends StatefulWidget {
  const AttendanceChipWidget({super.key});

  @override
  State<AttendanceChipWidget> createState() => _AttendanceChipWidgetState();
}

class _AttendanceChipWidgetState extends State<AttendanceChipWidget> {
  bool _isAbsent = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isAbsent = !_isAbsent;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _isAbsent ? Colors.red : Colors.green),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isAbsent ? Icons.close : Icons.check,
              size: 16,
              color: _isAbsent ? Colors.red : Colors.green,
            ),
            const SizedBox(width: 6),
            Text(
              _isAbsent ? "Absent" : "Present",
              style: TextStyle(color: _isAbsent ? Colors.red : Colors.green),
            ),
            const SizedBox(width: 8),
            Text(
              "Editing",
              style: TextStyle(
                fontSize: 12,
                color: _isAbsent ? Colors.blue : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
