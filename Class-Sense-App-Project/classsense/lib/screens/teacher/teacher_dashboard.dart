import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/stat_card.dart';

class TeacherDashboard extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const TeacherDashboard({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final upcomingClasses = [
      {'subject': 'Mathematics', 'time': '08:00 - 09:30', 'room': 'Room 201'},
      {'subject': 'Physics', 'time': '10:00 - 11:30', 'room': 'Lab 3'},
      {'subject': 'CS', 'time': '13:00 - 14:30', 'room': 'Room 105'},
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Teacher Dashboard',
              style: TextStyle(
                fontSize: size.width * 0.065,
                fontWeight: FontWeight.bold,
                color: AppColors.darkNavy,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              'Today\'s classroom summary',
              style: TextStyle(
                fontSize: size.width * 0.04,
                // ignore: deprecated_member_use
                color: AppColors.darkNavy.withOpacity(0.6),
              ),
            ),
            SizedBox(height: size.height * 0.012),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.lightBlueTint,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.successGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.bluetooth_connected,
                      color: AppColors.successGreen,
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: Text(
                      'BLE and geofence sync active. Attendance updates every 30 seconds.',
                      style: TextStyle(
                        color: AppColors.darkNavy,
                        fontSize: size.width * 0.033,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.025),
            StatCard(
              icon: Icons.group,
              title: 'Students Enrolled',
              value: '42',
              color: AppColors.skyBlue,
              onTap: () => onNavigate(1),
            ),
            SizedBox(height: size.height * 0.015),
            StatCard(
              icon: Icons.check_circle,
              title: 'Present Today',
              value: '38',
              color: AppColors.successGreen,
              onTap: () => onNavigate(1),
            ),
            SizedBox(height: size.height * 0.015),
            StatCard(
              icon: Icons.warning_amber,
              title: 'Late / Absent',
              value: '4',
              color: AppColors.warningYellow,
              onTap: () => onNavigate(1),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
                color: AppColors.darkNavy,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.25,
              children: [
                _QuickActionCard(
                  icon: Icons.how_to_reg,
                  label: 'Take Attendance',
                  color: AppColors.successGreen,
                  onTap: () => onNavigate(1),
                ),
                _QuickActionCard(
                  icon: Icons.insights,
                  label: 'Engagement',
                  color: AppColors.skyBlue,
                  onTap: () => onNavigate(2),
                ),
                _QuickActionCard(
                  icon: Icons.notifications_active,
                  label: 'Send Reminder',
                  color: AppColors.warningYellow,
                  onTap: () => onNavigate(3),
                ),
                _QuickActionCard(
                  icon: Icons.quiz,
                  label: 'Quick Quiz',
                  color: AppColors.darkNavy,
                  onTap: () => onNavigate(3),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.width * 0.045),
              decoration: BoxDecoration(
                color: AppColors.darkNavy,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Safety & Focus Snapshot',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: size.width * 0.042,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.008),
                  Text(
                    '2 students repeatedly leaving seat zone. 1 class segment needs engagement boost.',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.9),
                      fontSize: size.width * 0.033,
                    ),
                  ),
                  SizedBox(height: size.height * 0.014),
                  OutlinedButton.icon(
                    onPressed: () => onNavigate(2),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      side: const BorderSide(color: AppColors.white),
                    ),
                    icon: const Icon(Icons.insights_outlined),
                    label: const Text('Review Engagement Detail'),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              'Upcoming Classes',
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
                color: AppColors.darkNavy,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upcomingClasses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final cls = upcomingClasses[index];
                return Container(
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: AppColors.skyBlue.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.schedule,
                          color: AppColors.skyBlue,
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cls['subject']!,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkNavy,
                              ),
                            ),
                            Text(
                              '${cls['time']} - ${cls['room']}',
                              style: TextStyle(
                                fontSize: size.width * 0.032,
                                // ignore: deprecated_member_use
                                color: AppColors.darkNavy.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 16, color: AppColors.skyBlue),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.lightBlueTint,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color),
            ),
            const Spacer(),
            Text(
              label,
              style: TextStyle(
                fontSize: size.width * 0.036,
                fontWeight: FontWeight.w600,
                color: AppColors.darkNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
