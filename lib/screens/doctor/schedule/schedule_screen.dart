import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  int _selectedDateIndex = 2; // Default to 'Today'

  // Dummy dates for the week
  final List<Map<String, String>> _weekDates = [
    {'day': 'Mon', 'date': '10'},
    {'day': 'Tue', 'date': '11'},
    {'day': 'Wed', 'date': '12'},
    {'day': 'Thu', 'date': '13'},
    {'day': 'Fri', 'date': '14'},
    {'day': 'Sat', 'date': '15'},
  ];

  // Dummy schedule data
  final List<Map<String, dynamic>> _schedule = [
    {
      'time': '09:00 AM',
      'patient': 'Ali Youssef',
      'type': 'General Checkup',
      'status': 'Completed',
      'image': 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=150&q=80',
    },
    {
      'time': '10:30 AM',
      'patient': 'Ahmed Kamal',
      'type': 'Follow-up',
      'status': 'Upcoming',
      'image': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
    },
    {
      'time': '11:15 AM',
      'patient': 'Sara Ahmed',
      'type': 'Consultation',
      'status': 'Upcoming',
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
    },
    {
      'time': '01:00 PM',
      'patient': 'Tarek Fouad',
      'type': 'Lab Results',
      'status': 'Upcoming',
      'image': 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=150&q=80',
    },
  ];

  late final AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildDatePicker(),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Appointments',
                    style: AppTextStyles.h3.copyWith(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16),
                _buildScheduleList(),
                const SizedBox(height: 120), // Extra space for floating bottom nav
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120), // Avoid bottom nav
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add_rounded, color: Colors.white),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.bg,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'My Schedule',
        style: AppTextStyles.h2.copyWith(fontSize: 20),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert_rounded, color: AppColors.text),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _weekDates.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedDateIndex == index;
          final date = _weekDates[index];
          
          return GestureDetector(
            onTap: () {
              setState(() => _selectedDateIndex = index);
              _animCtrl.forward(from: 0); // Re-trigger list animation
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: 65,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.text.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date['day']!,
                    style: AppTextStyles.label.copyWith(
                      color: isSelected ? Colors.white70 : AppColors.text3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date['date']!,
                    style: AppTextStyles.h3.copyWith(
                      color: isSelected ? Colors.white : AppColors.text,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: List.generate(_schedule.length, (index) {
          final item = _schedule[index];
          final bool isCompleted = item['status'] == 'Completed';

          return AnimatedBuilder(
            animation: _animCtrl,
            builder: (context, child) {
              final double start = (index * 0.1).clamp(0.0, 1.0);
              final double end = (start + 0.4).clamp(0.0, 1.0);
              final double progress = ((_animCtrl.value - start) / (end - start)).clamp(0.0, 1.0);
              final double curve = Curves.easeOutCubic.transform(progress);

              return Opacity(
                opacity: curve,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - curve)),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline Time
                  SizedBox(
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          item['time'],
                          style: AppTextStyles.bodyBold.copyWith(
                            color: isCompleted ? AppColors.text3 : AppColors.text,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Timeline line & indicator
                  Column(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.only(top: 14),
                        decoration: BoxDecoration(
                          color: isCompleted ? AppColors.text3 : AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isCompleted ? Colors.transparent : AppColors.primary.withValues(alpha: 0.3),
                            width: 3,
                          ),
                        ),
                      ),
                      if (index != _schedule.length - 1)
                        Container(
                          width: 2,
                          height: 100, // Approximate height to connect to next
                          color: AppColors.border,
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),

                  // Appointment Card
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.text.withValues(alpha: 0.03),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          )
                        ],
                        border: Border.all(
                          color: isCompleted ? AppColors.border : Colors.transparent,
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(item['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: isCompleted
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.6),
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['patient'],
                                      style: AppTextStyles.bodyBold.copyWith(
                                        fontSize: 15,
                                        color: isCompleted ? AppColors.text2 : AppColors.text,
                                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item['type'],
                                      style: AppTextStyles.caption.copyWith(color: AppColors.text3),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isCompleted ? AppColors.s2 : AppColors.blue3,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item['status'],
                                  style: AppTextStyles.caption.copyWith(
                                    color: isCompleted ? AppColors.text3 : AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (!isCompleted) ...[
                            const SizedBox(height: 16),
                            const Divider(height: 1, color: AppColors.border),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.text2,
                                      side: const BorderSide(color: AppColors.border),
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Reschedule'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Start'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
