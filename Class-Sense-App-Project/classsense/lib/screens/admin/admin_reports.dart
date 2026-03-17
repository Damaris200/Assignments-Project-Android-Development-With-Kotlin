import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/engagement_chart.dart';

class AdminReports extends StatelessWidget {
  const AdminReports({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final classReports = [
      {'class': 'Mathematics', 'attendance': '92%', 'status': 'On Track'},
      {'class': 'Physics', 'attendance': '78%', 'status': 'Needs Review'},
      {'class': 'Computer Science', 'attendance': '86%', 'status': 'On Track'},
      {'class': 'Chemistry', 'attendance': '69%', 'status': 'At Risk'},
    ];

    final riskAlerts = [
      {
        'title': 'Chemistry attendance dropped by 8%',
        'detail': '3 consecutive lessons below 75% attendance',
        'severity': 'High',
      },
      {
        'title': 'Low engagement in Physics Lab 3',
        'detail': 'Sensor trend indicates higher distraction moments',
        'severity': 'Medium',
      },
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
                    'Reports & Insights',
                    style: TextStyle(
                      fontSize: size.width * 0.065,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkNavy,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    'Attendance and engagement trends',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      // ignore: deprecated_member_use
                      color: AppColors.darkNavy.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.025),
            _AnimatedIn(
              index: 1,
              child: SizedBox(
                height: 38,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _PeriodChip(label: 'Today', selected: false),
                    SizedBox(width: 8),
                    _PeriodChip(label: 'This Week', selected: true),
                    SizedBox(width: 8),
                    _PeriodChip(label: 'This Month', selected: false),
                    SizedBox(width: 8),
                    _PeriodChip(label: 'Term', selected: false),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _AnimatedIn(
              index: 2,
              child: Row(
                children: [
                  _buildSummaryCard(
                    context,
                    label: 'Absence Rate',
                    value: '9%',
                    color: AppColors.alertRed,
                  ),
                  const SizedBox(width: 10),
                  _buildSummaryCard(
                    context,
                    label: 'Engagement',
                    value: '76%',
                    color: AppColors.skyBlue,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            _AnimatedIn(
              index: 3,
              child: Row(
                children: [
                  _buildSummaryCard(
                    context,
                    label: 'Avg Attendance',
                    value: '84%',
                    color: AppColors.successGreen,
                  ),
                  const SizedBox(width: 10),
                  _buildSummaryCard(
                    context,
                    label: 'Late Rate',
                    value: '7%',
                    color: AppColors.warningYellow,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _AnimatedIn(
              index: 4,
              child: EngagementChart(
                scores: const [72, 64, 83, 57, 91, 76, 69],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            _AnimatedIn(
              index: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Risk Alerts',
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkNavy,
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  ...riskAlerts.map((alert) {
                    final isHigh = alert['severity'] == 'High';
                    final alertColor =
                        isHigh ? AppColors.alertRed : AppColors.warningYellow;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(size.width * 0.04),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: alertColor),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  alert['title']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkNavy,
                                    fontSize: size.width * 0.036,
                                  ),
                                ),
                                Text(
                                  alert['detail']!,
                                  style: TextStyle(
                                    // ignore: deprecated_member_use
                                    color: AppColors.darkNavy.withOpacity(0.6),
                                    fontSize: size.width * 0.032,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: alertColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              alert['severity']!,
                              style: TextStyle(
                                color: alertColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _AnimatedIn(
              index: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Class Breakdown',
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkNavy,
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  ListView.separated(
                    itemCount: classReports.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final report = classReports[index];
                      final status = report['status']!;
                      final Color statusColor;
                      if (status == 'On Track') {
                        statusColor = AppColors.successGreen;
                      } else if (status == 'Needs Review') {
                        statusColor = AppColors.warningYellow;
                      } else {
                        statusColor = AppColors.alertRed;
                      }

                      return _AnimatedIn(
                        index: index,
                        child: Container(
                          padding: EdgeInsets.all(size.width * 0.04),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      report['class']!,
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkNavy,
                                      ),
                                    ),
                                    Text(
                                      'Attendance ${report['attendance']}',
                                      style: TextStyle(
                                        fontSize: size.width * 0.032,
                                        // ignore: deprecated_member_use
                                        color: AppColors.darkNavy.withOpacity(
                                          0.6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: statusColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.032,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _AnimatedIn(
              index: 7,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Export scheduled. CSV will be available soon.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Export This Report'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.018),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: size.width * 0.045,
              ),
            ),
            Text(
              label,
              style: TextStyle(color: color, fontSize: size.width * 0.03),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _PeriodChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color:
            selected
                ? AppColors.skyBlue.withOpacity(0.15)
                : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? AppColors.skyBlue : AppColors.darkNavy,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AnimatedIn extends StatelessWidget {
  final int index;
  final Widget child;

  const _AnimatedIn({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 80)),
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
