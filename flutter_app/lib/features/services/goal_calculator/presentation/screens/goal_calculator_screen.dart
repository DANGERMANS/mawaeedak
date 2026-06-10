import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_theme.dart';

/// احسب هدفك - Goal Calculator Service
/// الحالة: Demo - يحتاج ربط API
class GoalCalculatorScreen extends ConsumerStatefulWidget {
  const GoalCalculatorScreen({super.key});

  @override
  ConsumerState<GoalCalculatorScreen> createState() => _GoalCalculatorScreenState();
}

class _GoalCalculatorScreenState extends ConsumerState<GoalCalculatorScreen> {
  final _goalNameController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _currentAmountController = TextEditingController();
  String _selectedType = 'ادخار';
  double _progress = 0.0;

  @override
  void dispose() {
    _goalNameController.dispose();
    _targetAmountController.dispose();
    _currentAmountController.dispose();
    super.dispose();
  }

  void _calculateProgress() {
    final target = double.tryParse(_targetAmountController.text) ?? 0;
    final current = double.tryParse(_currentAmountController.text) ?? 0;
    if (target > 0) {
      setState(() {
        _progress = (current / target).clamp(0.0, 1.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildFormCard(),
                      const SizedBox(height: 16),
                      if (_progress > 0) _buildProgressCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFCF7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x3DC9A063)),
                boxShadow: const [BoxShadow(color: Color(0x1A8A6B3D), blurRadius: 20, offset: Offset(0, 8))],
              ),
              child: const Icon(Icons.arrow_forward_rounded, color: AppColors.ink, size: 22),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('احسب هدفك', style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink)),
                Text('حدد أهدافك وتابع تقدمك', style: GoogleFonts.cairo(fontSize: 12, color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0x3DC9A063)),
        boxShadow: const [BoxShadow(color: Color(0x1A8A6B3D), blurRadius: 30, offset: Offset(0, 12))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.track_changes_rounded, color: AppColors.gold, size: 24),
              ),
              const SizedBox(width: 12),
              Text('إنشاء هدف جديد', style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink)),
            ],
          ),
          const SizedBox(height: 20),
          Text('اسم الهدف', style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink)),
          const SizedBox(height: 8),
          TextField(
            controller: _goalNameController,
            style: GoogleFonts.cairo(),
            decoration: _inputDecoration('مثال: سيارة جديدة'),
          ),
          const SizedBox(height: 16),
          Text('نوع الهدف', style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink)),
          const SizedBox(height: 8),
          Row(
            children: ['ادخار', 'استثمار', 'شراء', 'سفر'].map((type) {
              final isSelected = _selectedType == type;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedType = type),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.gold : AppColors.paper,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? AppColors.gold : AppColors.border),
                    ),
                    child: Center(
                      child: Text(type, style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.ink)),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('المبلغ المستهدف', style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _targetAmountController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.cairo(),
                      onChanged: (_) => _calculateProgress(),
                      decoration: _inputDecoration('0 ر.س'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('المبلغ الحالي', style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _currentAmountController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.cairo(),
                      onChanged: (_) => _calculateProgress(),
                      decoration: _inputDecoration('0 ر.س'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: AppColors.goldGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Color(0x1A8A6B3D), blurRadius: 20, offset: Offset(0, 8))],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text('حفظ الهدف', style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    final remaining = (double.tryParse(_targetAmountController.text) ?? 0) - (double.tryParse(_currentAmountController.text) ?? 0);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0x3DC9A063)),
        boxShadow: const [BoxShadow(color: Color(0x1A8A6B3D), blurRadius: 30, offset: Offset(0, 12))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('التقدم', style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink)),
          const SizedBox(height: 16),
          // Progress Bar
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: AppColors.paper,
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text('${(_progress * 100).toStringAsFixed(1)}%', style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.gold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('المتبقي', '${remaining.toStringAsFixed(0)} ر.س'),
              _buildStatItem('يومياً', '${(remaining / 30).toStringAsFixed(0)} ر.س'),
              _buildStatItem('أسبوعياً', '${(remaining / 4).toStringAsFixed(0)} ر.س'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.goldDark)),
        Text(label, style: GoogleFonts.cairo(fontSize: 12, color: AppColors.muted)),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.cairo(color: AppColors.muted),
      filled: true,
      fillColor: AppColors.paper,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.gold, width: 2)),
    );
  }
}
