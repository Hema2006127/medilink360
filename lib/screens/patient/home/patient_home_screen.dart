import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../booking/booking_screen.dart';
import '../reports/reports_screen.dart';
import '../wallet/wallet_screen.dart';
import '../ai_check/ai_check_screen.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> with SingleTickerProviderStateMixin {
  int _tab = 0;
  
  // Real Icons instead of emojis
  static const _navItems = [
    (Icons.home_rounded, 'Home'),
    (Icons.calendar_month_rounded, 'Booking'),
    (Icons.summarize_rounded, 'Reports'),
    (Icons.account_balance_wallet_rounded, 'Wallet'),
    (Icons.auto_awesome_rounded, 'AI Insight'),
  ];

  // Tab indices: 0=Home, 1=Booking, 2=Reports, 3=Wallet, 4=AI
  static const _quickActions = [
    (Icons.event_available_rounded, 'Book', 1, AppColors.primary),
    (Icons.smart_toy_rounded, 'AI Check', 4, AppColors.purple),
    (Icons.medical_services_rounded, 'Reports', 2, AppColors.teal),
    (Icons.account_balance_wallet_rounded, 'Wallet', 3, AppColors.pink),
  ];

  static const _doctors = [
    ('Dr. Karim Hassan', 'Cardiology', '4.9', 'https://cdn-icons-png.flaticon.com/512/3774/3774299.png'),
    ('Dr. Sara Ahmed', 'Neurology', '4.8', 'https://cdn-icons-png.flaticon.com/512/3774/3774284.png'),
    ('Dr. Tarek Fouad', 'Orthopedics', '4.7', 'https://cdn-icons-png.flaticon.com/512/3774/3774299.png'),
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
        return const BookingScreen();
      case 2:
        return const ReportsScreen();
      case 3:
        return const WalletScreen();
      case 4:
        return const AiCheckScreen();
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
                      Text('Next Appointment', style: AppTextStyles.h3.copyWith(fontSize: 18)),
                      TextButton(
                        onPressed: () {},
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
                  child: _buildNextAppointment(),
                ),
                const SizedBox(height: 32),
                
                _FadeInSlide(
                  animation: _animCtrl,
                  delay: 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Top Specialists', style: AppTextStyles.h3.copyWith(fontSize: 18)),
                      Icon(Icons.arrow_forward_rounded, color: AppColors.text3, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _FadeInSlide(
                  animation: _animCtrl,
                  delay: 0.6,
                  child: _buildDoctorRow(),
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
            // Premium background gradient
            Container(decoration: const BoxDecoration(gradient: AppColors.primaryGradient)),
            // Abstract geometric overlay
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
            // Header Content
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
                            Text('Ahmed Kamal', style: AppTextStyles.h2White.copyWith(fontSize: 22)),
                          ],
                        ),
                        _buildProfileAvatar(),
                      ],
                    ),
                    const Spacer(),
                    // Health Score Card (Glassmorphism)
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
                                  Text('WELLNESS SCORE', style: AppTextStyles.label.copyWith(color: Colors.white70, letterSpacing: 1.2)),
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
                                        Text('+4pts', style: AppTextStyles.captionWhite.copyWith(color: AppColors.green, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('82', style: AppTextStyles.h1White.copyWith(fontSize: 48, height: 1)),
                                  const SizedBox(width: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Text('Excellent', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.green2)),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.favorite_rounded, color: AppColors.pink, size: 36),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  _buildMiniMetric(Icons.favorite_border_rounded, '72 bpm'),
                                  _buildDivider(),
                                  _buildMiniMetric(Icons.water_drop_outlined, '120/80'),
                                  _buildDivider(),
                                  _buildMiniMetric(Icons.directions_walk_rounded, '7.2k steps'),
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
              image: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80'),
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
              color: AppColors.red,
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
      height: 20,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white.withValues(alpha: 0.2),
    );
  }

  Widget _buildMiniMetric(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 14),
        const SizedBox(width: 4),
        Text(value, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _quickActions.map((action) {
        return GestureDetector(
          onTap: () {
            setState(() => _tab = action.$3);
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

  Widget _buildNextAppointment() {
    return Container(
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
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.blue3,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('12', style: AppTextStyles.h3.copyWith(color: AppColors.primary, height: 1)),
                      Text('OCT', style: AppTextStyles.label.copyWith(color: AppColors.primary, fontSize: 10)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. Karim Hassan', style: AppTextStyles.bodyBold.copyWith(fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(
                        'Cardiologist • City Hospital',
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
                    '10:30',
                    style: AppTextStyles.bodyBold.copyWith(color: AppColors.text),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorRow() {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: _doctors.length,
        itemBuilder: (context, i) {
          final doc = _doctors[i];
          return GestureDetector(
            onTap: () => context.go('/patient/booking'),
            child: Container(
              width: 130,
              margin: const EdgeInsets.only(right: 16),
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
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.s2,
                      image: DecorationImage(
                        image: NetworkImage(doc.$4),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    doc.$1,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyBold.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doc.$2,
                    style: AppTextStyles.caption.copyWith(color: AppColors.text3),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(doc.$3, style: AppTextStyles.bodyMedium.copyWith(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        // Calculate tailored animation progress with delay
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
