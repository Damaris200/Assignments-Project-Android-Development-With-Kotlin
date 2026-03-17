import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import 'admin_dashboard.dart';
import 'admin_reports.dart';
import 'admin_settings.dart';
import 'admin_users.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _currentIndex = 0;

  void _setTab(int index) {
    if (index == _currentIndex) {
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _openGeofence() {
    Navigator.pushNamed(context, AppRoutes.adminGeofence);
  }

  List<Widget> get _tabs => [
        AdminDashboard(
          onNavigate: _setTab,
          onOpenGeofence: _openGeofence,
        ),
        const AdminUsers(),
        const AdminReports(),
        const AdminSettings(),
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
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people, color: AppColors.darkNavy),
            label: 'Users',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights, color: AppColors.darkNavy),
            label: 'Reports',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings, color: AppColors.darkNavy),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
