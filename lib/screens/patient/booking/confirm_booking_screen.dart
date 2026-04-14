import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class ConfirmBookingScreen extends StatelessWidget {
  const ConfirmBookingScreen({super.key});

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
              onTap: () => context.go('/patient/booking'),
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
            Text('Confirm Booking', style: AppTextStyles.h4.copyWith(fontSize: 17)),
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              _SummaryCard(),
              const SizedBox(height: 16),
              _DetailRow(label: 'Date', value: 'Saturday, April 14'),
              _DetailRow(label: 'Time', value: '10:30 AM'),
              _DetailRow(label: 'Type', value: 'In-Person'),
              _DetailRow(label: 'Fee', value: 'EGP 350'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => _SuccessDialog(
                      onDone: () => context.go('/patient/home'),
                    ),
                  );
                },
                child: const Text('Confirm & Pay'),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go('/patient/booking'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.text2,
                    side: const BorderSide(color: AppColors.border2, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Change Slot'),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(children: [
        Container(
          width: 56, height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(child: Text('👨‍⚕️', style: TextStyle(fontSize: 28))),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Dr. Karim Hassan', style: AppTextStyles.bodyWhite.copyWith(fontWeight: FontWeight.w800, fontSize: 15)),
          Text('Cardiologist', style: AppTextStyles.captionWhite.copyWith(fontSize: 12)),
          const SizedBox(height: 4),
          Text('City Medical Center', style: AppTextStyles.captionWhite),
        ])),
      ]),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body.copyWith(color: AppColors.text2)),
          Text(value, style: AppTextStyles.bodyBold),
        ],
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final VoidCallback onDone;
  const _SuccessDialog({required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('🎉', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 16),
          Text('Booking Confirmed!', style: AppTextStyles.h4),
          const SizedBox(height: 8),
          Text(
            'Your appointment with Dr. Karim has been successfully booked.',
            style: AppTextStyles.body.copyWith(color: AppColors.text2, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: onDone, child: const Text('Done')),
        ]),
      ),
    );
  }
}
