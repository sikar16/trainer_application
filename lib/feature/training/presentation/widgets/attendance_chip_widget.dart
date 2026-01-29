import 'package:flutter/material.dart';

class AttendanceChipWidget extends StatefulWidget {
  final bool initialIsPresent;
  final Function(bool isPresent) onChanged;
  final Function(String comment)? onCommentChanged;

  const AttendanceChipWidget({
    super.key,
    required this.initialIsPresent,
    required this.onChanged,
    this.onCommentChanged,
  });

  @override
  State<AttendanceChipWidget> createState() => _AttendanceChipWidgetState();
}

class _AttendanceChipWidgetState extends State<AttendanceChipWidget> {
  late bool _isPresent;
  bool _isEditing = false;
  final TextEditingController _commentController = TextEditingController();

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
      _isEditing = false;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _showCommentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'Attendance Comment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 20),

                // Text Field
                TextField(
                  controller: _commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter your comment here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Cancel Button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Save Comment Button
                    ElevatedButton(
                      onPressed: () {
                        widget.onCommentChanged?.call(_commentController.text);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Save Comment'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final presentColor = colorScheme.primary;
    final absentColor = colorScheme.error;

    if (_isEditing) {
      // Second image: Editing mode with current status and action buttons
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Current attendance status (bold + icon)
            Row(
              children: [
                Icon(
                  _isPresent ? Icons.check_circle : Icons.cancel,
                  size: 18,
                  color: _isPresent ? presentColor : absentColor,
                ),
                const SizedBox(width: 6),
                Text(
                  _isPresent ? "Present" : "Absent",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _isPresent ? presentColor : absentColor,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPresent = false;
                    });
                    widget.onChanged(false);
                  },
                  child: Icon(Icons.cancel, size: 18, color: absentColor),
                ),
              ],
            ),

            SizedBox(width: 60),
            // Right side: Comment and Clear icons
            Row(
              children: [
                _buildIconAction(
                  icon: Icons.comment,
                  onPressed: _showCommentDialog,
                  color: Colors.blue.shade600,
                ),
                const SizedBox(width: 8),
                _buildIconAction(
                  icon: Icons.clear,
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                      _isPresent = widget.initialIsPresent;
                    });
                  },
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // First image: Simple chip with edit icon - make it clickable to toggle
      return GestureDetector(
        onTap: () {
          setState(() {
            _isPresent = !_isPresent;
          });
          widget.onChanged(_isPresent);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _isPresent ? Icons.check_circle : Icons.cancel,
                size: 16,
                color: _isPresent ? presentColor : absentColor,
              ),
              const SizedBox(width: 6),
              Text(
                _isPresent ? "Present" : "Absent",
                style: textTheme.labelSmall?.copyWith(
                  color: _isPresent ? presentColor : absentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  _startEditing();
                },
                child: Icon(Icons.edit, size: 16, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildIconAction({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    double size = 20,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size + 8,
        height: size + 8,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Icon(icon, size: size - 4, color: color),
      ),
    );
  }
}
