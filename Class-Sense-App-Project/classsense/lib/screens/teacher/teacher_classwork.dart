import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TeacherClassworkScreen extends StatelessWidget {
  const TeacherClassworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final reminders = [
      {
        'title': 'Homework Reminder',
        'detail': 'Algebra worksheet due tomorrow',
        'time': '9:00 AM',
      },
      {
        'title': 'Quiz Notification',
        'detail': '5-min exit quiz for SS2 Mathematics',
        'time': '11:30 AM',
      },
      {
        'title': 'Revision Nudge',
        'detail': 'Send study tips to students',
        'time': '2:00 PM',
      },
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Classwork & Reminders',
              style: TextStyle(
                fontSize: size.width * 0.065,
                fontWeight: FontWeight.bold,
                color: AppColors.darkNavy,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              'Homework, quizzes, and quick messages',
              style: TextStyle(
                fontSize: size.width * 0.04,
                // ignore: deprecated_member_use
                color: AppColors.darkNavy.withOpacity(0.6),
              ),
            ),
            SizedBox(height: size.height * 0.025),
            _SectionCard(
              title: 'Today\'s Tasks',
              children: const [
                _TaskTile(
                  icon: Icons.assignment_turned_in,
                  title: 'Check submissions',
                  subtitle: '24 homework submissions received',
                  color: AppColors.successGreen,
                ),
                _TaskTile(
                  icon: Icons.quiz,
                  title: 'Create quick quiz',
                  subtitle: 'Set a 5-question exit quiz',
                  color: AppColors.skyBlue,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            _SectionCard(
              title: 'Scheduled Reminders',
              children: reminders
                  .map(
                    (item) => _ReminderTile(
                      title: item['title']!,
                      detail: item['detail']!,
                      time: item['time']!,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: size.height * 0.02),
            _SectionCard(
              title: 'Quick Actions',
              children: const [
                _ActionTile(
                  icon: Icons.notifications_active,
                  title: 'Send reminder to class',
                  subtitle: 'Notify students about homework',
                ),
                _ActionTile(
                  icon: Icons.menu_book,
                  title: 'Share study guide',
                  subtitle: 'Push notes for next lesson',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
            ),
          ),
          SizedBox(height: size.height * 0.015),
          ...children,
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _TaskTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkNavy,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.darkNavy.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  final String title;
  final String detail;
  final String time;

  const _ReminderTile({
    required this.title,
    required this.detail,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.schedule, color: AppColors.skyBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkNavy,
                  ),
                ),
                Text(
                  detail,
                  style: TextStyle(
                    color: AppColors.darkNavy.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.darkNavy.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppColors.skyBlue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.skyBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkNavy,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.darkNavy.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
