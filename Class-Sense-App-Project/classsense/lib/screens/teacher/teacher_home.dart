import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'teacher_dashboard.dart';
import 'attendance_screen.dart';
import 'engagement_screen.dart';
import 'teacher_classwork.dart';
import 'teacher_profile.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  int _currentIndex = 0;

  void _setTab(int index) {
    if (index == _currentIndex) {
      return;
    }
    setState(() => _currentIndex = index);
  }

  List<Widget> get _tabs => [
    TeacherDashboard(onNavigate: _setTab),
    const TeacherAttendanceScreen(),
    const TeacherEngagementScreen(),
    const TeacherClassworkScreen(),
    const TeacherProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _setTab,
        backgroundColor: AppColors.white,
        // ignore: deprecated_member_use
        indicatorColor: AppColors.skyBlue.withOpacity(0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard, color: AppColors.darkNavy),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle, color: AppColors.darkNavy),
            label: 'Attendance',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights, color: AppColors.darkNavy),
            label: 'Engagement',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment, color: AppColors.darkNavy),
            label: 'Classwork',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppColors.darkNavy),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
