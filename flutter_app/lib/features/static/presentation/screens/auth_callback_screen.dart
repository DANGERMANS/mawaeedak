import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// صفحة استدعاء المصادقة
class AuthCallbackScreen extends StatefulWidget {
  const AuthCallbackScreen({super.key});

  @override
  State<AuthCallbackScreen> createState() => _AuthCallbackScreenState();
}

class _AuthCallbackScreenState extends State<AuthCallbackScreen> {
  String _status = 'جاري التحقق...';

  @override
  void initState() {
    super.initState();
    _processCallback();
  }

  Future<void> _processCallback() async {
    // Simulate OAuth callback processing
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _status = 'تم التحقق بنجاح!');
      // Navigate to home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: AppColors.gold),
            const SizedBox(height: AppSpacing.lg),
            Text(
              _status,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}