import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';

// ─────────────────────────────────────────────
//  MOCK DATA — replace with real Firebase data later
// ─────────────────────────────────────────────
const String _activeClass = 'Mathematics — Room 204';

final List<Map<String, dynamic>> _students = [
  {'name': 'Amara Smith',    'initials': 'AS', 'attendance': 92, 'engagement': 'Engaged'},
  {'name': 'Brian Kofi',     'initials': 'BK', 'attendance': 85, 'engagement': 'Distracted'},
  {'name': 'Chioma Osei',    'initials': 'CO', 'attendance': 98, 'engagement': 'Engaged'},
  {'name': 'David Mensah',   'initials': 'DM', 'attendance': 60, 'engagement': 'Off-task'},
  {'name': 'Esi Amoah',      'initials': 'EA', 'attendance': 100,'engagement': 'Engaged'},
  {'name': 'Frank Boateng',  'initials': 'FB', 'attendance': 78, 'engagement': 'Idle'},
  {'name': 'Grace Tetteh',   'initials': 'GT', 'attendance': 90, 'engagement': 'Engaged'},
  {'name': 'Henry Asante',   'initials': 'HA', 'attendance': 55, 'engagement': 'Absent'},
];

// ─────────────────────────────────────────────
//  TEACHER HOME — main screen
// ─────────────────────────────────────────────
class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Compute attendance counts from mock data
    final int present = _students.where((s) => s['engagement'] != 'Absent').length;
    final int absent  = _students.where((s) => s['engagement'] == 'Absent').length;
    final int late    = 1; // TODO: replace with Firebase query

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        backgroundColor: AppColors.darkNavy,
        foregroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Greeting ──────────────────────────────
          Text(
            'Welcome back, ${user?.displayName ?? 'Teacher'} 👋',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _activeClass,
            style: const TextStyle(fontSize: 14, color: AppColors.idleGrey),
          ),
          const SizedBox(height: 16),

          // ── Attendance Overview Card ───────────────
          _AttendanceOverviewCard(present: present, absent: absent, late: late),
          const SizedBox(height: 16),

          // ── Class List heading ────────────────────
          const Text(
            'Students',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
            ),
          ),
          const SizedBox(height: 8),

          // ── Student List ──────────────────────────
          ..._students.asMap().entries.map((entry) {
            final int  idx     = entry.key;
            final Map  student = entry.value;
            return _StudentListTile(
              student: student,
              isEven: idx.isEven,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StudentDetailScreen(student: student),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ATTENDANCE OVERVIEW CARD
// ─────────────────────────────────────────────
class _AttendanceOverviewCard extends StatelessWidget {
  final int present;
  final int absent;
  final int late;

  const _AttendanceOverviewCard({
    required this.present,
    required this.absent,
    required this.late,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightBlueTint,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatBox(label: 'Present', count: '$present', color: AppColors.successGreen),
            _divider(),
            _StatBox(label: 'Absent',  count: '$absent',  color: AppColors.alertRed),
            _divider(),
            _StatBox(label: 'Late',    count: '$late',    color: AppColors.warningYellow),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
    width: 1, height: 40,
    color: AppColors.skyBlue.withOpacity(0.25),
  );
}

class _StatBox extends StatelessWidget {
  final String label;
  final String count;
  final Color  color;

  const _StatBox({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.idleGrey)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  STUDENT LIST TILE
// ─────────────────────────────────────────────
class _StudentListTile extends StatelessWidget {
  final Map    student;
  final bool   isEven;
  final VoidCallback onTap;

  const _StudentListTile({
    required this.student,
    required this.isEven,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isEven ? AppColors.white : AppColors.lightGrey,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.skyBlue,
          child: Text(
            student['initials'],
            style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          student['name'],
          style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkNavy),
        ),
        subtitle: Text(
          'Attendance: ${student['attendance']}%',
          style: const TextStyle(fontSize: 12, color: AppColors.idleGrey),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            EngagementBadge(label: student['engagement']),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.idleGrey, size: 18),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ENGAGEMENT BADGE — reusable widget
// ─────────────────────────────────────────────
class EngagementBadge extends StatelessWidget {
  final String label;

  const EngagementBadge({super.key, required this.label});

  Color get _color {
    switch (label) {
      case 'Engaged':    return AppColors.successGreen;
      case 'Distracted': return AppColors.warningYellow;
      case 'Off-task':   return AppColors.alertRed;
      case 'Absent':     return AppColors.alertRed;
      default:           return AppColors.idleGrey; // Idle
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withOpacity(0.6)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _color,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  STUDENT DETAIL SCREEN
// ─────────────────────────────────────────────

// Mock engagement trend data — 6 snapshots across a class
// Y-axis: 1=Idle, 2=Off-task, 3=Distracted, 4=Engaged, 5=Highly Engaged
final Map<String, List<FlSpot>> _engagementTrends = {
  'Amara Smith':   [FlSpot(0,4), FlSpot(1,5), FlSpot(2,4), FlSpot(3,5), FlSpot(4,4), FlSpot(5,5)],
  'Brian Kofi':    [FlSpot(0,3), FlSpot(1,4), FlSpot(2,3), FlSpot(3,2), FlSpot(4,3), FlSpot(5,3)],
  'Chioma Osei':   [FlSpot(0,5), FlSpot(1,5), FlSpot(2,4), FlSpot(3,5), FlSpot(4,5), FlSpot(5,4)],
  'David Mensah':  [FlSpot(0,2), FlSpot(1,2), FlSpot(2,1), FlSpot(3,2), FlSpot(4,2), FlSpot(5,1)],
  'Esi Amoah':     [FlSpot(0,4), FlSpot(1,4), FlSpot(2,5), FlSpot(3,4), FlSpot(4,5), FlSpot(5,4)],
  'Frank Boateng': [FlSpot(0,1), FlSpot(1,2), FlSpot(2,1), FlSpot(3,1), FlSpot(4,2), FlSpot(5,1)],
  'Grace Tetteh':  [FlSpot(0,4), FlSpot(1,3), FlSpot(2,4), FlSpot(3,5), FlSpot(4,4), FlSpot(5,4)],
  'Henry Asante':  [FlSpot(0,1), FlSpot(1,1), FlSpot(2,1), FlSpot(3,1), FlSpot(4,1), FlSpot(5,1)],
};

class StudentDetailScreen extends StatelessWidget {
  final Map student;

  const StudentDetailScreen({super.key, required this.student});

  Color get _attendanceColor {
    final int pct = student['attendance'] as int;
    if (pct >= 85) return AppColors.successGreen;
    if (pct >= 70) return AppColors.warningYellow;
    return AppColors.alertRed;
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots =
        _engagementTrends[student['name']] ?? _engagementTrends['Amara Smith']!;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: Text(student['name']),
        backgroundColor: AppColors.darkNavy,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Attendance rate card ──────────────────
          Card(
            color: AppColors.lightGreenTint,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _attendanceColor.withOpacity(0.15),
                child: Icon(Icons.check_circle, color: _attendanceColor),
              ),
              title: const Text(
                'Attendance Rate',
                style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkNavy),
              ),
              trailing: Text(
                '${student['attendance']}%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _attendanceColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Current engagement badge ──────────────
          Card(
            color: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  const Text(
                    'Current engagement',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkNavy,
                    ),
                  ),
                  const Spacer(),
                  EngagementBadge(label: student['engagement']),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Engagement trend chart ────────────────
          Card(
            color: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Engagement Trend (this class)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '5 = Highly Engaged  ·  1 = Idle',
                    style: TextStyle(fontSize: 11, color: AppColors.idleGrey),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: LineChart(
                      LineChartData(
                        minY: 0,
                        maxY: 6,
                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: 1,
                          getDrawingHorizontalLine: (_) => FlLine(
                            color: AppColors.lightGrey,
                            strokeWidth: 1,
                          ),
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 1,
                              getTitlesWidget: (value, _) {
                                if (value < 1 || value > 5) return const SizedBox.shrink();
                                const labels = {1:'Idle',2:'Off',3:'Dist',4:'Eng',5:'High'};
                                return Text(
                                  labels[value.toInt()] ?? '',
                                  style: const TextStyle(fontSize: 9, color: AppColors.idleGrey),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 20,
                              getTitlesWidget: (value, _) => Text(
                                '${(value.toInt() * 10 + 10)}m',
                                style: const TextStyle(fontSize: 9, color: AppColors.idleGrey),
                              ),
                            ),
                          ),
                          topTitles:   AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: AppColors.skyBlue,
                            barWidth: 2.5,
                            dotData: FlDotData(
                              getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                                radius: 4,
                                color: AppColors.skyBlue,
                                strokeColor: AppColors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppColors.skyBlue.withOpacity(0.08),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Placeholder for BLE status ────────────
          Card(
            color: AppColors.lightBlueTint,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const ListTile(
              leading: Icon(Icons.bluetooth, color: AppColors.skyBlue),
              title: Text(
                'BLE Status',
                style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkNavy),
              ),
              trailing: Text(
                'In Range',
                style: TextStyle(color: AppColors.successGreen, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}