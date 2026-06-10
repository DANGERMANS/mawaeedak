import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة المالية الرسمية - الأدمن
class AdminOfficialFinancialScreen extends StatelessWidget {
  const AdminOfficialFinancialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final officialItems = [
      _FinancialOfficialItem(
        title: 'الراتب الشهري',
        amount: 15000,
        type: 'income',
        lastUpdated: '2026-06-01',
      ),
      _FinancialOfficialItem(
        title: 'التأمين الاجتماعي',
        amount: 1200,
        type: 'expense',
        lastUpdated: '2026-06-05',
      ),
      _FinancialOfficialItem(
        title: 'ضريبة الدخل',
        amount: 2500,
        type: 'expense',
        lastUpdated: '2026-06-05',
      ),
      _FinancialOfficialItem(
        title: 'دعم حكومي',
        amount: 5000,
        type: 'income',
        lastUpdated: '2026-06-10',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('المالية الرسمية'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Summary
          Container(
            margin: const EdgeInsets.all(AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('إجمالي الدخل'),
                    Text(
                      '20,000 ر.س',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.border,
                ),
                Column(
                  children: [
                    const Text('إجمالي المصروفات'),
                    Text(
                      '3,700 ر.س',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: officialItems.length,
              itemBuilder: (context, index) {
                final item = officialItems[index];
                final isIncome = item.type == 'income';
                return Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (isIncome ? AppColors.success : AppColors.error)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(
                        isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isIncome ? AppColors.success : AppColors.error,
                      ),
                    ),
                    title: Text(item.title),
                    subtitle: Text('آخر تحديث: ${item.lastUpdated}'),
                    trailing: Text(
                      '${isIncome ? '+' : '-'}${item.amount} ر.س',
                      style: TextStyle(
                        color: isIncome ? AppColors.success : AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FinancialOfficialItem {
  final String title;
  final double amount;
  final String type;
  final String lastUpdated;

  const _FinancialOfficialItem({
    required this.title,
    required this.amount,
    required this.type,
    required this.lastUpdated,
  });
}