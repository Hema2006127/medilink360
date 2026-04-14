import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../services/firebase_auth_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  final bool isPatient;
  const PhoneAuthScreen({super.key, required this.isPatient});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool _isLoading = false;
  bool _isCodeSent = false;
  String _verificationId = '';

  final _phoneCtrl = TextEditingController(text: '+20');
  final _otpCtrl = TextEditingController();

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _otpCtrl.dispose();
    super.dispose();
  }

  Future<void> _verifyPhone() async {
    if (_phoneCtrl.text.isEmpty || _phoneCtrl.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number with country code')),
      );
      return;
    }

    setState(() => _isLoading = true);

    await FirebaseAuthService.verifyPhoneNumber(
      phoneNumber: _phoneCtrl.text.trim(),
      codeSent: (verificationId) {
        if (!mounted) return;
        setState(() {
          _verificationId = verificationId;
          _isCodeSent = true;
          _isLoading = false;
        });
      },
      verificationFailed: (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      },
    );
  }

  Future<void> _verifyOTP() async {
    if (_otpCtrl.text.isEmpty || _otpCtrl.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 6-digit OTP')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await FirebaseAuthService.verifyOTP(_verificationId, _otpCtrl.text.trim());
      if (user != null && mounted) {
        final route = widget.isPatient ? '/patient/home' : '/doctor/home';
        context.go(route);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isCodeSent ? 'Verify Phone Code' : 'Enter Phone Number',
                style: AppTextStyles.h1,
              ),
              const SizedBox(height: 12),
              Text(
                _isCodeSent 
                    ? 'We have sent an SMS with a code to ${_phoneCtrl.text}'
                    : 'We will send you a 6-digit verification code. Please include your country code (e.g., +20 for Egypt).',
                style: AppTextStyles.body.copyWith(color: AppColors.text2),
              ),
              const SizedBox(height: 40),

              if (!_isCodeSent) ...[
                // Phone Input
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.border, width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '+20 100 000 0000',
                      hintStyle: AppTextStyles.body.copyWith(color: AppColors.text3),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _PrimaryButton(label: 'Send Code', onTap: _verifyPhone, isLoading: _isLoading),
              ] else ...[
                // OTP Input
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.border, width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _otpCtrl,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _PrimaryButton(label: 'Verify & Login', onTap: _verifyOTP, isLoading: _isLoading),
                
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isCodeSent = false;
                        _otpCtrl.clear();
                      });
                    },
                    child: Text(
                      'Change Phone Number',
                      style: AppTextStyles.bodyBold.copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const _PrimaryButton({required this.label, required this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: isLoading 
              ? const SizedBox(
                  width: 24, height: 24,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                )
              : Text(
                  label,
                  style: AppTextStyles.bodyBold.copyWith(color: Colors.white, fontSize: 16),
                ),
        ),
      ),
    );
  }
}
