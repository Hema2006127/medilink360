import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../patients/patients_list_screen.dart';
import '../schedule/schedule_screen.dart';
import '../earnings/earnings_screen.dart';
import '../profile/doctor_profile_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> with SingleTickerProviderStateMixin {
  int _tab = 0;
  
  static const _navItems = [
    (Icons.dashboard_rounded, 'Dashboard'),
    (Icons.calendar_month_rounded, 'Schedule'),
    (Icons.people_rounded, 'Patients'),
    (Icons.account_balance_wallet_rounded, 'Earnings'),
    (Icons.person_rounded, 'Profile'),
  ];

  static const _quickActions = [
    (Icons.event_note_rounded, 'Schedule', 1, AppColors.primary),
    (Icons.people_alt_rounded, 'Patients', 2, AppColors.teal),
    (Icons.payments_rounded, 'Earnings', 3, AppColors.green),
    (Icons.forum_rounded, 'Chat', 0, AppColors.blue), // Just keeping it at 0 or navigating
  ];

  static const _upcomingAppointments = [
    ('Ahmed Kamal', 'Follow-up', '10:30 AM', 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80'),
    ('Sara Ahmed', 'Consultation', '11:15 AM', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80'),
    ('Tarek Fouad', 'Check-up', '01:00 PM', 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=150&q=80'),
  ];

  late final AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
      statusBarIconBrightness: Brightness.light,
    ));
    
    return Scaffold(
      backgroundColor: AppColors.bg,
      extendBody: true,
      body: _buildBody(),
      bottomNavigationBar: _buildFloatingBottomNav(),
    );
  }

  Widget _buildBody() {
    switch (_tab) {
      case 1:
        return const ScheduleScreen(); // currently white screen
      case 2:
        return const PatientsListScreen(); // currently white screen
      case 3:
        return const EarningsScreen(); // currently white screen
      case 4:
        return const DoctorProfileScreen(); // currently white screen
      default:
        break;
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildSliverAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FadeInSlide(
                  animation: _animCtrl,
                  delay: 0.1,
                  child: Text('Quick Actions', style: AppTextStyles.h3.copyWith(fontSize: 18)),
                ),
                const SizedBox(height: 16),
                _FadeInSlide(
                  animation: _animCtrl,
                  delay: 0.2,
                  child: _buildQuickActions(),
                ),
                const SizedBox(height: 32),
                
                _FadeInSlide(
                  animation: _animCtrl,
                  delay: 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Upcoming Appointments', style: AppTextStyles.h3.copyWith(fontSize: 18)),
                      TextButton(
                        onPressed: () => setState(() => _tab = 1),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text('See all', style: AppTextStyles.bodyBold.copyWith(color: AppColors.primary, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _FadeInSlide(
                  animation: _animCtrl,
                  delay: 0.4,
                  child: _buildUpcomingAppointments(),
                ),
                const SizedBox(height: 100), // Space for floating bottom nav
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 280,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(decoration: const BoxDecoration(gradient: AppColors.primaryGradient)),
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkBlue.withValues(alpha: 0.3),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good morning,',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('Dr. Hema', style: AppTextStyles.h2White.copyWith(fontSize: 22)),
                          ],
                        ),
                        _buildProfileAvatar(),
                      ],
                    ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("TODAY'S INSIGHTS", style: AppTextStyles.label.copyWith(color: Colors.white70, letterSpacing: 1.2)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.green.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.trending_up_rounded, color: AppColors.green, size: 14),
                                        const SizedBox(width: 4),
                                        Text('Active', style: AppTextStyles.captionWhite.copyWith(color: AppColors.green, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildStatItem('Appointments', '8', Icons.calendar_today_rounded),
                                  _buildDivider(),
                                  _buildStatItem('Patients', '124', Icons.people_outline_rounded),
                                  _buildDivider(),
                                  _buildStatItem('Earnings', '\$450', Icons.account_balance_wallet_outlined),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
            image: const DecorationImage(
              image: NetworkImage('https://cdn-icons-png.flaticon.com/512/3774/3774299.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: AppColors.green,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70, size: 16),
            const SizedBox(width: 4),
            Text(label, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.h2White.copyWith(fontSize: 24, height: 1)),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _quickActions.map((action) {
        return GestureDetector(
          onTap: () {
            if (action.$3 == 0) {
              context.push('/doctor/chat');
            } else {
              setState(() => _tab = action.$3);
            }
          },
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.text.withValues(alpha: 0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Center(
                  child: Icon(action.$1, color: action.$4, size: 28),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                action.$2,
                style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingAppointments() {
    return Column(
      children: _upcomingAppointments.map((apt) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.text.withValues(alpha: 0.03),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => context.push('/doctor/patients/1'), // Example ID
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(apt.$4),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(apt.$1, style: AppTextStyles.bodyBold.copyWith(fontSize: 15)),
                          const SizedBox(height: 4),
                          Text(
                            apt.$2,
                            style: AppTextStyles.caption.copyWith(color: AppColors.text2, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.s2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        apt.$3,
                        style: AppTextStyles.bodyBold.copyWith(color: AppColors.text),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFloatingBottomNav() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: AppColors.text.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_navItems.length, (i) {
              final active = i == _tab;
              return GestureDetector(
                onTap: () => setState(() => _tab = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: active ? AppColors.blue3 : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    _navItems[i].$1,
                    color: active ? AppColors.primary : AppColors.text3,
                    size: 24,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _FadeInSlide extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double delay;

  const _FadeInSlide({
    required this.child,
    required this.animation,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, childWidget) {
        final double start = delay;
        final double end = (delay + 0.4).clamp(0.0, 1.0);
        final double progress = ((animation.value - start) / (end - start)).clamp(0.0, 1.0);
        
        final double curve = Curves.easeOutCubic.transform(progress);
        
        return Opacity(
          opacity: curve,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - curve)),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}
