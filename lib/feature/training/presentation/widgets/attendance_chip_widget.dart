import 'package:flutter/material.dart';

class AttendanceChipWidget extends StatefulWidget {
  final bool initialIsPresent;
  final Function(bool isPresent) onChanged;
  final Function(String comment)? onCommentChanged;
  final String? initialComment;

  const AttendanceChipWidget({
    super.key,
    required this.initialIsPresent,
    required this.onChanged,
    this.onCommentChanged,
    this.initialComment,
  });

  @override
  State<AttendanceChipWidget> createState() => _AttendanceChipWidgetState();
}

class _AttendanceChipWidgetState extends State<AttendanceChipWidget> {
  late bool _isPresent;
  bool _isEditing = false;
  final TextEditingController _commentController = TextEditingController();
  String? _savedComment;

  @override
  void initState() {
    super.initState();
    _isPresent = widget.initialIsPresent;
    _savedComment = widget.initialComment;
  }

  @override
  void didUpdateWidget(covariant AttendanceChipWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIsPresent != widget.initialIsPresent ||
        oldWidget.initialComment != widget.initialComment) {
      _isPresent = widget.initialIsPresent;
      _savedComment = widget.initialComment;
      _isEditing = false;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _setPresent() {
    setState(() {
      _isPresent = true;
    });
    widget.onChanged(true);
  }

  void _setAbsent() {
    setState(() {
      _isPresent = false;
    });
    widget.onChanged(false);
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _isPresent = widget.initialIsPresent;
    });
  }

  String? getComment() {
    return _savedComment;
  }

  void setComment(String? comment) {
    setState(() {
      _savedComment = comment;
    });
  }

  void _showCommentDialog() {
    _commentController.text = _savedComment ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Attendance Comment'),
          content: TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Add a comment about this student\'s attendance',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedComment = _commentController.text;
                });
                Navigator.pop(context);
                if (widget.onCommentChanged != null) {
                  widget.onCommentChanged!(_savedComment ?? '');
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final presentColor = Colors.green;
    final absentColor = Colors.red;

    if (_isEditing) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.blue.shade200, width: 2),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: _setPresent,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isPresent ? presentColor : Colors.grey.shade400,
                    width: 2,
                  ),
                  color: _isPresent ? presentColor.withOpacity(0.1) : null,
                ),
                child: Icon(
                  Icons.check,
                  color: _isPresent ? presentColor : Colors.grey.shade400,
                  size: 18,
                ),
              ),
            ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap: _setAbsent,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: !_isPresent ? absentColor : Colors.grey.shade400,
                    width: 2,
                  ),
                  color: !_isPresent ? absentColor.withOpacity(0.1) : null,
                ),
                child: Icon(
                  Icons.close,
                  color: !_isPresent ? absentColor : Colors.grey.shade400,
                  size: 18,
                ),
              ),
            ),

            const SizedBox(width: 10),

            Text(
              _isPresent ? 'Present' : 'Absent',
              style: TextStyle(
                color: _isPresent ? presentColor : absentColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(width: 10),

            if (_savedComment != null && _savedComment!.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.comment,
                      size: 14,
                      color: Colors.orange.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Comment',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Editing',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Spacer(),

            _circleIcon(
              icon: Icons.chat_bubble_outline,
              color: _savedComment != null && _savedComment!.isNotEmpty
                  ? Colors.orange.shade700
                  : Colors.grey.shade700,
              onTap: _showCommentDialog,
            ),

            const SizedBox(width: 10),

            _circleIcon(
              icon: Icons.close,
              color: Colors.grey.shade600,
              onTap: _cancelEditing,
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _isPresent = !_isPresent;
        });
        widget.onChanged(_isPresent);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _isEditing ? Colors.blue.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isEditing ? Colors.blue.shade300 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _setPresent,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: _isPresent
                      ? presentColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: _isPresent ? presentColor : Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: _setAbsent,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: !_isPresent
                      ? absentColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.cancel,
                  size: 18,
                  color: !_isPresent ? absentColor : Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(width: 8),

            Text(
              _isPresent ? 'Present' : 'Absent',
              style: TextStyle(
                color: _isPresent ? presentColor : absentColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),

            const SizedBox(width: 6),

            GestureDetector(
              onTap: _showCommentDialog,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: _savedComment != null && _savedComment!.isNotEmpty
                      ? Colors.orange.shade100
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.comment,
                  size: 14,
                  color: _savedComment != null && _savedComment!.isNotEmpty
                      ? Colors.orange.shade700
                      : Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
