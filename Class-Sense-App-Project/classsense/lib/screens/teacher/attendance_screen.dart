import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/attendance_card.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  int _selectedFilter = 0;

  final List<Map<String, String>> _students = const [
    {'name': 'Ada Obi', 'status': 'present', 'time': '08:02 AM'},
    {'name': 'Tomi Bello', 'status': 'present', 'time': '08:05 AM'},
    {'name': 'Kola Yusuf', 'status': 'late', 'time': '08:15 AM'},
    {'name': 'Zainab Ali', 'status': 'absent', 'time': '---'},
    {'name': 'Ifeanyi Okafor', 'status': 'present', 'time': '08:01 AM'},
  ];

  List<Map<String, String>> get _filteredStudents {
    if (_selectedFilter == 1) {
      return _students.where((s) => s['status'] == 'present').toList();
    }
    if (_selectedFilter == 2) {
      return _students.where((s) => s['status'] == 'late').toList();
    }
    if (_selectedFilter == 3) {
      return _students.where((s) => s['status'] == 'absent').toList();
    }
    return _students;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class Attendance',
              style: TextStyle(
                fontSize: size.width * 0.065,
                fontWeight: FontWeight.bold,
                color: AppColors.darkNavy,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              'Today • SS2 Mathematics',
              style: TextStyle(
                fontSize: size.width * 0.04,
                // ignore: deprecated_member_use
                color: AppColors.darkNavy.withOpacity(0.6),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              padding: EdgeInsets.all(size.width * 0.035),
              decoration: BoxDecoration(
                color: AppColors.lightBlueTint,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.bluetooth_searching,
                    color: AppColors.skyBlue,
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: Text(
                      'Smart attendance is auto-detected from BLE and geofence signals.',
                      style: TextStyle(
                        color: AppColors.darkNavy,
                        fontSize: size.width * 0.032,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Row(
              children: [
                _buildSummaryChip('Present', '38', AppColors.successGreen),
                const SizedBox(width: 8),
                _buildSummaryChip('Late', '2', AppColors.warningYellow),
                const SizedBox(width: 8),
                _buildSummaryChip('Absent', '2', AppColors.alertRed),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Wrap(
              spacing: 8,
              children: [
                _buildFilterChip(0, 'All'),
                _buildFilterChip(1, 'Present'),
                _buildFilterChip(2, 'Late'),
                _buildFilterChip(3, 'Absent'),
              ],
            ),
            SizedBox(height: size.height * 0.015),
            Expanded(
              child: ListView.separated(
                itemCount: _filteredStudents.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final student = _filteredStudents[index];
                  return AttendanceCard(
                    studentName: student['name']!,
                    status: student['status']!,
                    date: 'Checked in ${student['time']}',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = _selectedFilter == index;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.skyBlue.withOpacity(0.15),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.skyBlue : AppColors.darkNavy,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => setState(() => _selectedFilter = index),
    );
  }

  Widget _buildSummaryChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
