import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/attendance_card.dart';

class TeacherAttendanceScreen extends StatelessWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final students = [
      {'name': 'Ada Obi', 'status': 'present', 'time': '08:02 AM'},
      {'name': 'Tomi Bello', 'status': 'present', 'time': '08:05 AM'},
      {'name': 'Kola Yusuf', 'status': 'late', 'time': '08:15 AM'},
      {'name': 'Zainab Ali', 'status': 'absent', 'time': '---'},
      {'name': 'Ifeanyi Okafor', 'status': 'present', 'time': '08:01 AM'},
    ];

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
            Expanded(
              child: ListView.separated(
                itemCount: students.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final student = students[index];
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
            Text(
              label,
              style: TextStyle(color: color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
