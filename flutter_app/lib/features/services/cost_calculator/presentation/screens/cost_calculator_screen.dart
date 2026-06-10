import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_theme.dart';

/// حساب التكاليف - Cost Calculator Service
class CostCalculatorScreen extends ConsumerStatefulWidget {
  const CostCalculatorScreen({super.key});
  @override
  ConsumerState<CostCalculatorScreen> createState() => _CostCalculatorScreenState();
}

class _CostCalculatorScreenState extends ConsumerState<CostCalculatorScreen> {
  final List<Map<String, dynamic>> _items = [];
  final _itemNameController = TextEditingController();
  final _itemCostController = TextEditingController();
  String _selectedStatus = 'غير مدفوع';

  double get _totalCost => _items.fold(0, (sum, item) => sum + (item['cost'] as double));
  double get _paidCost => _items.where((i) => i['status'] == 'مدفوع').fold(0, (sum, item) => sum + (item['cost'] as double));
  double get _remaining => _totalCost - _paidCost;

  void _addItem() {
    if (_itemNameController.text.isEmpty || _itemCostController.text.isEmpty) return;
    setState(() {
      _items.add({
        'name': _itemNameController.text,
        'cost': double.tryParse(_itemCostController.text) ?? 0,
        'status': _selectedStatus,
      });
      _itemNameController.clear();
      _itemCostController.clear();
    });
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
                      _buildProjectSummary(),
                      const SizedBox(height: 16),
                      _buildAddItemForm(),
                      const SizedBox(height: 16),
                      _buildItemsList(),
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
              width: 44, height: 44,
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
                Text('حساب التكاليف', style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink)),
                Text('تكييف هدفك المالي', style: GoogleFonts.cairo(fontSize: 12, color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.goldGradient,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [BoxShadow(color: Color(0x2E8A6B3D), blurRadius: 45, offset: Offset(0, 18))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('الإجمالي', '${_totalCost.toStringAsFixed(0)}', Colors.white),
          Container(width: 1, height: 40, color: Colors.white.withValues(alpha: 0.3)),
          _buildSummaryItem('المدفوع', '${_paidCost.toStringAsFixed(0)}', Colors.white.withValues(alpha: 0.8)),
          Container(width: 1, height: 40, color: Colors.white.withValues(alpha: 0.3)),
          _buildSummaryItem('المتبقي', '${_remaining.toStringAsFixed(0)}', Colors.white),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w800, color: color)),
        Text(label, style: GoogleFonts.cairo(fontSize: 12, color: color.withValues(alpha: 0.8))),
      ],
    );
  }

  Widget _buildAddItemForm() {
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
              Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.add_circle_rounded, color: AppColors.success, size: 24),
            ),
            const SizedBox(width: 12),
              Text('إضافة بند جديد', style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink)),
          ],
          const SizedBox(height: 16),
          TextField(
            controller: _itemNameController,
            style: GoogleFonts.cairo(),
            decoration: InputDecoration(
              hintText: 'اسم البند',
              hintStyle: GoogleFonts.cairo(color: AppColors.muted),
              filled: true,
              fillColor: AppColors.paper,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.gold, width: 2)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _itemCostController,
            keyboardType: TextInputType.number,
            style: GoogleFonts.cairo(),
            decoration: InputDecoration(
              hintText: 'التكلفة (ر.س)',
              hintStyle: GoogleFonts.cairo(color: AppColors.muted),
              filled: true,
              fillColor: AppColors.paper,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.gold, width: 2)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: ['غير مدفوع', 'جزئي', 'مدفوع', 'مجدول'].map((status) {
              final isSelected = _selectedStatus == status;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedStatus = status),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.gold : AppColors.paper,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: isSelected ? AppColors.gold : AppColors.border),
                    ),
                    child: Center(child: Text(status, style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.ink))),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _addItem,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text('إضافة', style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    if (_items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: const Color(0xFFFFFCF7), borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0x3DC9A063))),
        child: Column(
          children: [
            Icon(Icons.list_alt_rounded, color: AppColors.gold, size: 40),
            const SizedBox(height: 12),
            Text('لا توجد بنود', style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink)),
            Text('أضف بنود جديدة لحساب التكاليف', style: GoogleFonts.cairo(fontSize: 13, color: AppColors.muted)),
          ],
        ),
      );
    }
    return Column(
      children: _items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x3DC9A063)),
          ),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: (item['status'] == 'مدفوع' ? AppColors.success : item['status'] == 'جزئي' ? AppColors.warning : AppColors.muted).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  item['status'] == 'مدفوع' ? Icons.check_circle_rounded : item['status'] == 'جزئي' ? Icons.pending_rounded : Icons.circle_outlined,
                  color: item['status'] == 'مدفوع' ? AppColors.success : item['status'] == 'جزئي' ? AppColors.warning : AppColors.muted,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name'], style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.ink)),
                    Text('${item['cost']} ر.س', style: GoogleFonts.cairo(fontSize: 12, color: AppColors.muted)),
                  ],
                ),
              ),
              Text(item['status'], style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w600, color: item['status'] == 'مدفوع' ? AppColors.success : AppColors.muted)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
