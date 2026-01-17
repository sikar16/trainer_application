import 'package:flutter/material.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bahirdar Mesenado Monday Afternoon (Oct 20)',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const Text(
              'Number of Sessions - 1',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const Divider(height: 32, thickness: 1),

            const Text(
              'Bahirdar Mesenado Monday Afternoon (Oct 20)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const Divider(height: 32, thickness: 1),

            const Text(
              'Session 1',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                'In Person',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildDetailRow(
                    icon: Icons.calendar_today,
                    text: '10/20/2025',
                  ),
                ),
                Expanded(
                  child: _buildDetailRow(
                    icon: Icons.schedule,
                    text: '11:00 AM',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildDetailRow(icon: Icons.timer, text: '30 mins'),
                ),
                Expanded(
                  child: _buildDetailRow(
                    icon: Icons.location_on,
                    text: 'Bahirdar',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              'Bahirdar Mesenado Monday Afternoon (Oct 20)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const Divider(height: 32, thickness: 1),

            _buildTablesSection(),

            const SizedBox(height: 32),

            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildTablesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTableColumn(
                title: 'Start On',
                value: 'Oct 20, 2025',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTableColumn(title: 'Ends On', value: 'Oct 31, 2025'),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTableColumn(title: 'Number of Sessions', value: '1'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTableColumn(
                title: 'Applicants Required',
                value: '2',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableColumn({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Decline',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Apply',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(home: JobDetailScreen()));
}
