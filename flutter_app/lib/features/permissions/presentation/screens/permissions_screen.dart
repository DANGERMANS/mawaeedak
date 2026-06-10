import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class PermissionsScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const PermissionsScreen({super.key, required this.onComplete});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _locationPermissionGranted = false;
  bool _notificationPermissionGranted = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5EFE4),
              Color(0xFFFAF7F2),
              Color(0xFFF5EFE4),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Header
                _buildHeader(),
                const SizedBox(height: 48),
                // Permissions List
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildPermissionCard(
                          icon: '📍',
                          title: 'الموقع الدقيق',
                          description:
                              'نستخدم موقعك لعرض مواقيت الصلاة الدقيقة حسب مدينتك.',
                          isGranted: _locationPermissionGranted,
                          onRequest: _requestLocationPermission,
                        ),
                        const SizedBox(height: 20),
                        _buildPermissionCard(
                          icon: '🔔',
                          title: 'الإشعارات',
                          description:
                              'نرسل لك تنبيهات الصلاة، المواعيد، الرواتب، والرحلات في وقتها.',
                          isGranted: _notificationPermissionGranted,
                          onRequest: _requestNotificationPermission,
                        ),
                        const SizedBox(height: 40),
                        // Skip Info
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: AppColors.brown,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'يمكنك تفعيل هذه الأذونات لاحقاً من الإعدادات',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _continue,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.gold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'متابعة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.gold,
              width: 2,
            ),
          ),
          child: const Center(
            child: Text(
              '🕌',
              style: TextStyle(fontSize: 48),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'أذونات التطبيق',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'لتحسين تجربتك معنا',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionCard({
    required String icon,
    required String title,
    required String description,
    required bool isGranted,
    required VoidCallback onRequest,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isGranted ? AppColors.success : AppColors.border,
          width: isGranted ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brown.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isGranted
                      ? AppColors.success.withOpacity(0.15)
                      : AppColors.paper,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 32)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isGranted)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '✓ مفعل',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isGranted) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onRequest,
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('تفعيل'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.gold,
                  side: const BorderSide(color: AppColors.gold),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _requestLocationPermission() async {
    setState(() => _isLoading = true);

    // Simulate permission request (in real app, use permission_handler)
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _locationPermissionGranted = true;
        _isLoading = false;
      });
    }
  }

  Future<void> _requestNotificationPermission() async {
    setState(() => _isLoading = true);

    // Simulate permission request (in real app, use permission_handler)
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _notificationPermissionGranted = true;
        _isLoading = false;
      });
    }
  }

  void _continue() {
    // Save permission state (in real app, use local storage)
    widget.onComplete();
  }
}