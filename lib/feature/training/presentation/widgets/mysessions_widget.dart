import 'package:flutter/material.dart';
import 'package:trainer_application/feature/training/presentation/widgets/view_report_widget.dart';

class MysessionsWidget extends StatefulWidget {
  const MysessionsWidget({super.key});

  @override
  State<MysessionsWidget> createState() => _MysessionsWidgetState();
}


class _MysessionsWidgetState extends State<MysessionsWidget> {
  bool _isAbsent = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Attendance",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Cohorts"),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  children: [
                    _pill("Test cohort 4", selected: true),
                    _pill("Test cohort 3"),
                    _pill("Test cohort 2"),
                    _pill("Test cohort 1"),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Sessions"),
                const SizedBox(height: 12),
                _pill("Digital literacy", selected: true),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _card(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoColumn(
                    title: "Digital literacy",
                    subtitle: "Cohort: Test cohort 4",
                  ),
                  const SizedBox(width: 32),

                  _infoColumn(
                    title: "Date",
                    subtitle: "07/10/2025",
                    icon: Icons.calendar_today_outlined,
                  ),
                  const SizedBox(width: 32),

                  _infoColumn(title: "Time", subtitle: "12:00 PM - 3:00 PM"),
                  const SizedBox(width: 32),

                  _infoColumn(title: "Location", subtitle: "Business Center"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ViewReportPage()),
                );
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text("View Report"),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFE7F9EE),
                foregroundColor: const Color(0xFF137333),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: SizedBox(
                    child: Text(
                      "Save Attendance",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        backgroundColor: colorScheme.primary,
                    
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 24),

                SizedBox(
                  width: 188,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search students...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      isDense: true,
                    ),
                  ),
                ),

                const SizedBox(width: 12),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _card(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Checkbox(value: false, onChanged: null)),
                  DataColumn(label: Text("Full Name")),
                  DataColumn(label: Text("Phone Number")),
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Attendance")),
                  DataColumn(label: Text("ID & Consent Form")),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(Checkbox(value: false, onChanged: null)),
                      const DataCell(Text("student one test")),
                      const DataCell(Text("+251920562362")),
                      const DataCell(Text("07/10/2025")),
                      DataCell(_attendanceChip()),
                      DataCell(
                        OutlinedButton.icon(
                          onPressed: () {
                            _showUploadIDDialog(context);
                          },
                          icon: const Icon(Icons.badge_outlined),
                          label: const Text("Add ID & Consent"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _card({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: child,
    );
  }

  Widget _pill(String label, {bool selected = false}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ?  : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.black,
        side: BorderSide(color: selected ? Colors.blue : Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label),
    );
  }

  Widget _infoColumn({
    required String title,
    required String subtitle,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) Icon(icon, size: 16),
            if (icon != null) const SizedBox(width: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _attendanceChip() {
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

  void _showUploadIDDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _uploadIDBottomSheet();
      },
    );
  }

  Widget _uploadIDBottomSheet() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upload ID Document - student test",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ID Type",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select ID type",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Front of ID",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Upload Front",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle upload logic here
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Upload ID",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
