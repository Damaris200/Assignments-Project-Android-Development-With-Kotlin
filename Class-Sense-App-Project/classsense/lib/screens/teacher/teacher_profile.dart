import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';

class TeacherProfileTab extends StatefulWidget {
  const TeacherProfileTab({super.key});

  @override
  State<TeacherProfileTab> createState() => _TeacherProfileTabState();
}

class _TeacherProfileTabState extends State<TeacherProfileTab> {
  bool _quizNotifications = true;
  bool _attendanceAlerts = true;
  bool _lowEngagementAlerts = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            CircleAvatar(
              radius: size.width * 0.12,
              backgroundColor: AppColors.darkNavy,
              child: Icon(
                Icons.school,
                size: size.width * 0.12,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              user?.displayName ?? 'Teacher',
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: AppColors.darkNavy,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              user?.email ?? 'teacher@classsense.com',
              style: TextStyle(
                fontSize: size.width * 0.038,
                // ignore: deprecated_member_use
                color: AppColors.darkNavy.withOpacity(0.6),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: AppColors.skyBlue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Teacher',
                style: TextStyle(
                  color: AppColors.skyBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.035,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  _StatItem(label: 'Classes', value: '3', size: size),
                  _VerticalDivider(size: size),
                  _StatItem(label: 'Students', value: '42', size: size),
                  _VerticalDivider(size: size),
                  _StatItem(label: 'Avg Focus', value: '76%', size: size),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _SectionCard(
              title: 'Notification Preferences',
              children: [
                SwitchListTile(
                  value: _attendanceAlerts,
                  onChanged: (value) => setState(() => _attendanceAlerts = value),
                  activeColor: AppColors.skyBlue,
                  title: const Text('Attendance alerts'),
                  subtitle: const Text('Notify me of late and absent students'),
                ),
                SwitchListTile(
                  value: _lowEngagementAlerts,
                  onChanged: (value) =>
                      setState(() => _lowEngagementAlerts = value),
                  activeColor: AppColors.skyBlue,
                  title: const Text('Low engagement alerts'),
                  subtitle: const Text('Detect focus drops from sensor trends'),
                ),
                SwitchListTile(
                  value: _quizNotifications,
                  onChanged: (value) => setState(() => _quizNotifications = value),
                  activeColor: AppColors.skyBlue,
                  title: const Text('Quiz reminders'),
                  subtitle: const Text('Remind me to send quick revision quizzes'),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.015),
            _SectionCard(
              title: 'Teacher Tools',
              children: [
                _ToolTile(
                  icon: Icons.file_download_outlined,
                  title: 'Export class summary',
                  subtitle: 'Download attendance and engagement snapshots',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Class summary export created.'),
                      ),
                    );
                  },
                ),
                _ToolTile(
                  icon: Icons.support_agent,
                  title: 'Open student support plan',
                  subtitle: 'Track interventions for at-risk learners',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Support plan page will open next.'),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              width: double.infinity,
              height: size.height * 0.065,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  }
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.alertRed,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.darkNavy,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _ToolTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ToolTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.skyBlue),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.darkNavy,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Size size;

  const _StatItem({
    required this.label,
    required this.value,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: size.width * 0.046,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: AppColors.darkNavy.withOpacity(0.6),
              fontSize: size.width * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  final Size size;

  const _VerticalDivider({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: size.height * 0.04,
      color: AppColors.darkNavy.withOpacity(0.15),
    );
  }
}
