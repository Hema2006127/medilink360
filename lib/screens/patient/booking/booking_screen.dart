import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedDay = 14;
  int _selectedSlot = -1;

  static const _days = [
    (9, 'Mon', true),
    (10, 'Tue', true),
    (11, 'Wed', true),
    (12, 'Thu', false),
    (13, 'Fri', false),
    (14, 'Sat', true),
    (15, 'Sun', true),
  ];

  static const _slots = [
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
  ];

  static const _takenSlots = {1, 4};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorCard(),
                  const SizedBox(height: 20),
                  Text('Select Date', style: AppTextStyles.h4),
                  const SizedBox(height: 12),
                  _buildCalendar(),
                  const SizedBox(height: 20),
                  Text('Available Slots', style: AppTextStyles.h4),
                  const SizedBox(height: 12),
                  _buildTimeSlots(),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _selectedSlot >= 0
                        ? () => context.go('/patient/booking/confirm')
                        : null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: AppColors.border,
                    ),
                    child: const Text('Confirm Booking'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 52, 16, 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/patient/home'),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.s2,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 16,
                color: AppColors.text,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Book Appointment',
            style: AppTextStyles.h4.copyWith(fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.blue3,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('👨‍⚕️', style: TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Karim Hassan',
                  style: AppTextStyles.bodyBold.copyWith(fontSize: 15),
                ),
                Text(
                  'Cardiologist',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.text2,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 11)),
                    const SizedBox(width: 3),
                    Text('4.9 · 120 reviews', style: AppTextStyles.caption),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'EGP 350',
                style: AppTextStyles.bodyBold.copyWith(
                  color: AppColors.primary,
                  fontSize: 15,
                ),
              ),
              Text('per session', style: AppTextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('April 2025', style: AppTextStyles.bodyBold),
          const SizedBox(height: 10),
          // Weekday headers
          Row(
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map(
                  (d) => Expanded(
                    child: Center(child: Text(d, style: AppTextStyles.caption)),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 6),
          _buildDaysRow(),
        ],
      ),
    );
  }

  Widget _buildDaysRow() {
    return Row(
      children: _days.map((d) {
        final num = d.$1;
        final available = d.$3;
        final selected = num == _selectedDay;
        return Expanded(
          child: GestureDetector(
            onTap: available ? () => setState(() => _selectedDay = num) : null,
            child: AspectRatio(
              aspectRatio: 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: selected ? AppColors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$num',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: selected
                          ? Colors.white
                          : available
                          ? AppColors.text2
                          : AppColors.text3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTimeSlots() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _slots.length,
      itemBuilder: (_, i) {
        final taken = _takenSlots.contains(i);
        final selected = i == _selectedSlot;
        return GestureDetector(
          onTap: taken ? null : () => setState(() => _selectedSlot = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: selected ? AppColors.blue3 : Colors.white,
              border: Border.all(
                color: selected ? AppColors.blue : AppColors.border,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                _slots[i],
                style: AppTextStyles.body.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: taken
                      ? AppColors.text3
                      : selected
                      ? AppColors.blue
                      : AppColors.text2,
                  decoration: taken ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
