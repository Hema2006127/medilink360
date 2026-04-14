import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  static const _weekData = [
    ('Mon', 0.4, false), ('Tue', 0.6, false), ('Wed', 0.5, false),
    ('Thu', 0.8, false), ('Fri', 0.7, false), ('Sat', 0.9, true), ('Sun', 0.65, false),
  ];

  static const _metrics = [
    ('❤️', 'Heart Rate', '72 BPM', 'Normal', AppColors.red, AppColors.red2),
    ('🩸', 'Blood Pressure', '120/80', 'Normal', AppColors.green, AppColors.green2),
    ('🌡️', 'Temperature', '36.6°C', 'Normal', AppColors.blue, AppColors.blue3),
    ('🏃', 'Steps Today', '7,200', '+12%', AppColors.purple, AppColors.purple2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 52, 16, 16),
          child: Row(children: [
            GestureDetector(
              onTap: () => context.go('/patient/home'),
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: AppColors.s2,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(Icons.arrow_back, size: 16, color: AppColors.text),
              ),
            ),
            const SizedBox(width: 12),
            Text('Health Reports', style: AppTextStyles.h4.copyWith(fontSize: 17)),
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildScoreCard(),
              const SizedBox(height: 20),
              Text('Weekly Activity', style: AppTextStyles.h4),
              const SizedBox(height: 12),
              _buildBarChart(),
              const SizedBox(height: 20),
              Text('Health Metrics', style: AppTextStyles.h4),
              const SizedBox(height: 12),
              ..._metrics.map(_buildMetricCard),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('HEALTH SCORE', style: AppTextStyles.captionWhite),
            Text('82', style: AppTextStyles.h1White.copyWith(fontSize: 56, height: 1.1)),
            Text('↑ 4 points this week', style: AppTextStyles.captionWhite),
          ]),
          const Text('💚', style: TextStyle(fontSize: 60)),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _weekData.map((d) {
          return Expanded(
            child: Column(children: [
              Container(
                height: 70 * d.$2,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: d.$3 ? AppColors.blue : AppColors.blue3,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 4),
              Text(d.$1, style: AppTextStyles.caption),
            ]),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMetricCard(
    (String, String, String, String, Color, Color) m,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: m.$6, borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(m.$1, style: const TextStyle(fontSize: 22))),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(m.$2, style: AppTextStyles.body.copyWith(color: AppColors.text2, fontSize: 12)),
          Text(m.$3, style: AppTextStyles.bodyBold.copyWith(fontSize: 16)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            color: m.$6, borderRadius: BorderRadius.circular(6),
          ),
          child: Text(m.$4, style: AppTextStyles.caption.copyWith(
            color: m.$5, fontWeight: FontWeight.w700,
          )),
        ),
      ]),
    );
  }
}
