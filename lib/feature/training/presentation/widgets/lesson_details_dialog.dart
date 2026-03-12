import 'package:flutter/material.dart';
import '../../domain/entities/lesson_entity.dart';

class LessonDetailsDialog extends StatelessWidget {
  final LessonEntity lesson;

  const LessonDetailsDialog({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 800,
          maxWidth: 900,
          maxHeight: 900,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('View Lesson', style: TextStyle(fontSize: 14)),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildDetailField('Lesson Name', lesson.name),
              const SizedBox(height: 16),

              _buildDetailField('Objective', lesson.objective),
              const SizedBox(height: 16),

              _buildDetailField('Description', lesson.description),
              const SizedBox(height: 16),

              _buildDetailField(
                'Duration',
                '${lesson.duration} ${lesson.durationType.toLowerCase()}',
              ),
              const SizedBox(height: 16),

              _buildListField(
                'Instructional Methods',
                lesson.instructionalMethods
                    .map((method) => method.name)
                    .toList(),
              ),
              const SizedBox(height: 16),

              _buildListField(
                'Technology Integrations',
                lesson.technologyIntegrations.map((tech) => tech.name).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      side: BorderSide(color: Colors.grey.shade400, width: 0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400, width: 0.5),
            color: const Color(0xFFF9FAFB),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  Widget _buildListField(String label, List<String> items) {
    final displayText = items.isEmpty ? 'None' : items.join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Text(
            displayText,
            style: TextStyle(
              fontSize: 14,
              color: items.isEmpty ? Colors.grey[500] : Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}
