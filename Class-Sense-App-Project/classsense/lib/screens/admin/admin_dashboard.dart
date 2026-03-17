import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/stat_card.dart';

class AdminDashboard extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  final VoidCallback onOpenGeofence;

  const AdminDashboard({
    super.key,
    required this.onNavigate,
    required this.onOpenGeofence,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final recentActivity = [
      {'title': 'New teacher added', 'detail': 'Dr. Kalu - Physics'},
      {'title': 'Geofence updated', 'detail': 'North Gate zone expanded'},
      {'title': 'Attendance sync complete', 'detail': 'All classes updated'},
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AnimatedIn(
              index: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin Dashboard',
                    style: TextStyle(
                      fontSize: size.width * 0.065,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkNavy,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    'System overview',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      // ignore: deprecated_member_use
                      color: AppColors.darkNavy.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            _AnimatedIn(
              index: 1,
              child: Column(
                children: [
                  StatCard(
                    icon: Icons.people,
                    title: 'Total Users',
                    value: '128',
                    color: AppColors.skyBlue,
                    onTap: () => onNavigate(1),
                  ),
                  SizedBox(height: size.height * 0.015),
                  StatCard(
                    icon: Icons.school,
                    title: 'Teachers',
                    value: '12',
                    color: AppColors.darkNavy,
                    onTap: () => onNavigate(1),
                  ),
                  SizedBox(height: size.height * 0.015),
                  StatCard(
                    icon: Icons.person,
                    title: 'Students',
                    value: '115',
                    color: AppColors.successGreen,
                    onTap: () => onNavigate(1),
                  ),
                  SizedBox(height: size.height * 0.015),
                  StatCard(
                    icon: Icons.location_on,
                    title: 'Geofences Active',
                    value: '3',
                    color: AppColors.warningYellow,
                    onTap: onOpenGeofence,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            _AnimatedIn(
              index: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        icon: Icons.people_alt,
                        label: 'Manage Users',
                        color: AppColors.skyBlue,
                        onTap: () => onNavigate(1),
                      ),
                      _QuickActionCard(
                        icon: Icons.insights,
                        label: 'View Reports',
                        color: AppColors.darkNavy,
                        onTap: () => onNavigate(2),
                      ),
                      _QuickActionCard(
                        icon: Icons.location_searching,
                        label: 'Geofence Setup',
                        color: AppColors.warningYellow,
                        onTap: onOpenGeofence,
                      ),
                      _QuickActionCard(
                        icon: Icons.notifications_active,
                        label: 'Safety Alerts',
                        color: AppColors.alertRed,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Safety alerts will appear here.'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            _AnimatedIn(
              index: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
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
                    itemCount: recentActivity.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final activity = recentActivity[index];
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
                                Icons.bolt,
                                color: AppColors.skyBlue,
                              ),
                            ),
                            SizedBox(width: size.width * 0.04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity['title']!,
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkNavy,
                                    ),
                                  ),
                                  Text(
                                    activity['detail']!,
                                    style: TextStyle(
                                      fontSize: size.width * 0.032,
                                      // ignore: deprecated_member_use
                                      color:
                                          AppColors.darkNavy.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedIn extends StatelessWidget {
  final int index;
  final Widget child;

  const _AnimatedIn({
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 350 + (index * 90)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 12),
            child: child,
          ),
        );
      },
      child: child,
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
