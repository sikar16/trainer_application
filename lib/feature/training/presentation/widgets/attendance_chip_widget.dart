import 'package:flutter/material.dart';

class AttendanceChipWidget extends StatefulWidget {
  final bool initialIsPresent;
  final Function(bool isPresent) onChanged;

  const AttendanceChipWidget({
    super.key,
    required this.initialIsPresent,
    required this.onChanged,
  });

  @override
  State<AttendanceChipWidget> createState() => _AttendanceChipWidgetState();
}

class _AttendanceChipWidgetState extends State<AttendanceChipWidget> {
  late bool _isPresent;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _isPresent = widget.initialIsPresent;
  }

  @override
  void didUpdateWidget(AttendanceChipWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIsPresent != widget.initialIsPresent) {
      _isPresent = widget.initialIsPresent;
      _hasChanged = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPresent = !_isPresent;
          _hasChanged = true;
        });
        widget.onChanged(_isPresent);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _isPresent ? Colors.green : Colors.red),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isPresent ? Icons.check_circle : Icons.close_rounded,
              size: 16,
              color: _isPresent ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 6),
            Text(
              _isPresent ? "Present" : "Absent",
              style: TextStyle(color: _isPresent ? Colors.green : Colors.red),
            ),
            if (_hasChanged) ...[
              const SizedBox(width: 8),
              Text(
                "Editing",
                style: TextStyle(
                  fontSize: 12,
                  color: _isPresent ? Colors.green : Colors.blue,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
