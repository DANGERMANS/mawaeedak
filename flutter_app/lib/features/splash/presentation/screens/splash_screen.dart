import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        child: Stack(
          children: [
            // Decorative Saudi Pattern - Top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildDecorativePattern(isTop: true),
            ),
            // Decorative Saudi Pattern - Bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildDecorativePattern(isTop: false),
            ),
            // Main Content
            SafeArea(
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      _buildLogo(),
                      const SizedBox(height: 32),
                      // App Name
                      const Text(
                        'مواعيدك',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Tagline
                      const Text(
                        'كل مواعيدك في مكان واحد',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.brown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Duas
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.borderGold,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              '❁',
                              style: TextStyle(fontSize: 28),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'صلِّ على رسول الله',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.gold.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const Text(
                              'عليه الصلاة والسلام',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.brown,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Loading Indicator
                      _buildLoadingIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cream,
        border: Border.all(
          color: AppColors.gold,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '🕌',
          style: TextStyle(fontSize: 64),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.gold.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'جاري التحميل...',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDecorativePattern({required bool isTop}) {
    return SizedBox(
      height: 120,
      child: CustomPaint(
        painter: _SaudiPatternPainter(isTop: isTop),
        size: Size.infinite,
      ),
    );
  }
}

class _SaudiPatternPainter extends CustomPainter {
  final bool isTop;

  _SaudiPatternPainter({required this.isTop});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final fillPaint = Paint()
      ..color = AppColors.gold.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Draw geometric patterns inspired by Saudi architecture
    const double patternSize = 30;
    final int count = (size.width / patternSize).ceil() + 1;

    for (int i = 0; i < count; i++) {
      final x = i * patternSize;
      final y = isTop ? 0.0 : size.height;

      canvas.save();
      if (!isTop) {
        canvas.translate(0, size.height);
        canvas.scale(1, -1);
      }

      // Draw palm tree silhouette
      _drawPalmSilhouette(canvas, Offset(x, y), paint, fillPaint);

      canvas.restore();
    }
  }

  void _drawPalmSilhouette(Canvas canvas, Offset offset, Paint stroke, Paint fill) {
    // Simple palm tree shape
    final path = Path();
    
    // Trunk
    path.moveTo(offset.dx + 5, offset.dy);
    path.lineTo(offset.dx + 8, offset.dy - 60);
    path.lineTo(offset.dx + 5, offset.dy - 60);
    path.lineTo(offset.dx + 2, offset.dy);
    path.close();

    // Fronds
    for (int i = 0; i < 5; i++) {
      final angle = -60 + (i * 30);
      final radians = angle * 3.14159 / 180;
      final endX = offset.dx + 5 + 40 * (i == 2 ? 0 : 1) * 
          (i < 2 ? -1 : 1) * (1 - (i - 2).abs() * 0.2);
      final endY = offset.dy - 60 - 20 - (i - 2).abs() * 5;

      path.moveTo(offset.dx + 5, offset.dy - 55);
      path.quadraticBezierTo(
        offset.dx + 5 + (endX - offset.dx - 5) * 0.5,
        offset.dy - 70,
        endX,
        endY,
      );
    }

    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}