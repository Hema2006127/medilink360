import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _category = 0;

  static const _categories = ['All', 'Lab Results', 'Prescriptions', 'Imaging', 'Reports'];

  static const _files = [
    ('🧪', 'Blood Test Results', 'Lab Results', 'Apr 10, 2025', AppColors.blue, AppColors.blue3),
    ('💊', 'Prescription — Dr. Karim', 'Prescriptions', 'Apr 8, 2025', AppColors.green, AppColors.green2),
    ('🫁', 'Chest X-Ray', 'Imaging', 'Mar 28, 2025', AppColors.purple, AppColors.purple2),
    ('📋', 'Annual Health Report', 'Reports', 'Mar 15, 2025', AppColors.amber, AppColors.amber2),
    ('🧬', 'DNA Test', 'Lab Results', 'Feb 20, 2025', AppColors.teal, AppColors.teal2),
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
            Expanded(child: Text('Medical Wallet', style: AppTextStyles.h4.copyWith(fontSize: 17))),
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(Icons.add, size: 20, color: Colors.white),
            ),
          ]),
        ),
        // Category scroll
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_categories.length, (i) {
                final active = i == _category;
                return GestureDetector(
                  onTap: () => setState(() => _category = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: active ? AppColors.blue3 : AppColors.s2,
                      border: Border.all(
                        color: active ? AppColors.blue4 : AppColors.border,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(_categories[i], style: AppTextStyles.body.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: active ? AppColors.blue : AppColors.text2,
                    )),
                  ),
                );
              }),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _files.length,
            itemBuilder: (_, i) {
              final f = _files[i];
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
                      color: f.$6, borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text(f.$1, style: const TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(f.$2, style: AppTextStyles.bodyBold.copyWith(fontSize: 13)),
                    const SizedBox(height: 3),
                    Text(f.$3, style: AppTextStyles.caption.copyWith(color: f.$5, fontSize: 11)),
                    Text(f.$4, style: AppTextStyles.caption),
                  ])),
                  const Icon(Icons.download_outlined, size: 20, color: AppColors.text3),
                ]),
              );
            },
          ),
        ),
      ]),
    );
  }
}
