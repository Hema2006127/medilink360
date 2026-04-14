import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/phone_auth_screen.dart';

// Patient
import 'screens/patient/home/patient_home_screen.dart';
import 'screens/patient/booking/booking_screen.dart';
import 'screens/patient/booking/confirm_booking_screen.dart';
import 'screens/patient/reports/reports_screen.dart';
import 'screens/patient/wallet/wallet_screen.dart';
import 'screens/patient/ai_check/ai_check_screen.dart';

// Doctor
import 'screens/doctor/home/doctor_home_screen.dart';
import 'screens/doctor/patients/patients_list_screen.dart';
import 'screens/doctor/patients/patient_profile_screen.dart';
import 'screens/doctor/prescription/prescription_screen.dart';
import 'screens/doctor/schedule/schedule_screen.dart';
import 'screens/doctor/earnings/earnings_screen.dart';
import 'screens/doctor/chat/doctor_chat_screen.dart';
import 'screens/doctor/profile/doctor_profile_screen.dart';

import 'theme/app_theme.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/',            builder: (_, _) => const SplashScreen()),
    GoRoute(path: '/onboarding',  builder: (_, _) => const OnboardingScreen()),
    GoRoute(path: '/login',       builder: (_, _) => const LoginScreen()),
    GoRoute(path: '/signup',      builder: (_, _) => const SignupScreen()),
    GoRoute(
      path: '/phone-auth',
      builder: (_, state) => PhoneAuthScreen(isPatient: state.extra as bool? ?? true),
    ),

    // ── Patient ──────────────────────────────
    GoRoute(path: '/patient/home',    builder: (_, _) => const PatientHomeScreen()),
    GoRoute(path: '/patient/booking', builder: (_, _) => const BookingScreen()),
    GoRoute(path: '/patient/booking/confirm', builder: (_, _) => const ConfirmBookingScreen()),
    GoRoute(path: '/patient/reports', builder: (_, _) => const ReportsScreen()),
    GoRoute(path: '/patient/wallet',  builder: (_, _) => const WalletScreen()),
    GoRoute(path: '/patient/ai',      builder: (_, _) => const AiCheckScreen()),

    // ── Doctor ───────────────────────────────
    GoRoute(path: '/doctor/home',     builder: (_, _) => const DoctorHomeScreen()),
    GoRoute(path: '/doctor/patients', builder: (_, _) => const PatientsListScreen()),
    GoRoute(
      path: '/doctor/patients/:id',
      builder: (_, state) => PatientProfileScreen(
        patientId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/doctor/patients/:id/prescription',
      builder: (_, state) => PrescriptionScreen(
        patientId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(path: '/doctor/schedule', builder: (_, _) => const ScheduleScreen()),
    GoRoute(path: '/doctor/earnings', builder: (_, _) => const EarningsScreen()),
    GoRoute(path: '/doctor/chat',     builder: (_, _) => const DoctorChatScreen()),
    GoRoute(path: '/doctor/profile',  builder: (_, _) => const DoctorProfileScreen()),
  ],
);

class MediLinkApp extends StatelessWidget {
  const MediLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MediLink 360',
      theme: AppTheme.light,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
