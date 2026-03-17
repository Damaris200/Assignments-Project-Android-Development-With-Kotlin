import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/engagement_chart.dart';

class TeacherEngagementScreen extends StatefulWidget {
  const TeacherEngagementScreen({super.key});

  @override
  State<TeacherEngagementScreen> createState() => _TeacherEngagementScreenState();
}

class _TeacherEngagementScreenState extends State<TeacherEngagementScreen> {
  int _selectedClass = 0;

  final List<Map<String, String>> _classes = const [
    {'name': 'SS2 Mathematics', 'avg': '76%'},
    {'name': 'SS1 Physics', 'avg': '71%'},
    {'name': 'JSS3 Basic Science', 'avg': '82%'},
  ];

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
            SizedBox(height: size.height * 0.016),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _classes.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final selected = _selectedClass == index;
                  final item = _classes[index];
                  return ChoiceChip(
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedClass = index),
                    selectedColor: AppColors.skyBlue.withOpacity(0.15),
                    label: Text(item['name']!),
                    labelStyle: TextStyle(
                      color: selected ? AppColors.skyBlue : AppColors.darkNavy,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size.height * 0.025),
            EngagementChart(scores: const [72, 64, 83, 57, 91, 76, 69]),
            SizedBox(height: size.height * 0.016),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.analytics_outlined, color: AppColors.skyBlue),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: Text(
                      '${_classes[_selectedClass]['name']} average engagement: ${_classes[_selectedClass]['avg']}.',
                      style: TextStyle(
                        color: AppColors.darkNavy,
                        fontSize: size.width * 0.034,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.025),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.warningYellow.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.flag_outlined, color: AppColors.warningYellow),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: Text(
                      'At-Risk: 2 students below 50% focus for 3 sessions.',
                      style: TextStyle(
                        color: AppColors.darkNavy,
                        fontSize: size.width * 0.033,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Intervention workflow opened.'),
                        ),
                      );
                    },
                    child: const Text('Open Plan'),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
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
                          horizontal: 12,
                          vertical: 6,
                        ),
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Engagement summary shared to class feed.'),
                    ),
                  );
                },
                icon: const Icon(Icons.share_outlined),
                label: const Text('Share Engagement Summary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
