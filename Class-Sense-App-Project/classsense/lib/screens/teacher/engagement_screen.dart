import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/engagement_chart.dart';

class TeacherEngagementScreen extends StatelessWidget {
  const TeacherEngagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final engagementList = [
      {'name': 'Ada Obi', 'score': 88, 'status': 'Focused'},
      {'name': 'Tomi Bello', 'score': 72, 'status': 'Engaged'},
      {'name': 'Kola Yusuf', 'score': 54, 'status': 'Distracted'},
      {'name': 'Zainab Ali', 'score': 41, 'status': 'Low'},
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Engagement Insights',
              style: TextStyle(
                fontSize: size.width * 0.065,
                fontWeight: FontWeight.bold,
                color: AppColors.darkNavy,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              'Live focus trends from sensors',
              style: TextStyle(
                fontSize: size.width * 0.04,
                // ignore: deprecated_member_use
                color: AppColors.darkNavy.withOpacity(0.6),
              ),
            ),
            SizedBox(height: size.height * 0.025),
            EngagementChart(scores: const [72, 64, 83, 57, 91, 76, 69]),
            SizedBox(height: size.height * 0.025),
            Text(
              'Student Engagement',
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
              itemCount: engagementList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final student = engagementList[index];
                final score = student['score'] as int;
                final Color scoreColor;
                if (score >= 80) {
                  scoreColor = AppColors.successGreen;
                } else if (score >= 60) {
                  scoreColor = AppColors.skyBlue;
                } else if (score >= 45) {
                  scoreColor = AppColors.warningYellow;
                } else {
                  scoreColor = AppColors.alertRed;
                }

                return Container(
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.darkNavy,
                        foregroundColor: AppColors.white,
                        child: Text((student['name'] as String)[0]),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student['name'] as String,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkNavy,
                              ),
                            ),
                            Text(
                              student['status'] as String,
                              style: TextStyle(
                                fontSize: size.width * 0.032,
                                // ignore: deprecated_member_use
                                color: AppColors.darkNavy.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: scoreColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$score%',
                          style: TextStyle(
                            color: scoreColor,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.032,
                          ),
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
    );
  }
}
