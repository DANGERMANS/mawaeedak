import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة المالية - الأدمن
class AdminFinanceScreen extends StatefulWidget {
  const AdminFinanceScreen({super.key});

  @override
  State<AdminFinanceScreen> createState() => _AdminFinanceScreenState();
}

class _AdminFinanceScreenState extends State<AdminFinanceScreen> {
  final List<_FinanceItem> _items = [
    _FinanceItem(
      id: '1',
      title: 'راتب شهر يونيو',
      amount: 15000,
      type: 'income',
      category: 'راتب',
      date: '2026-06-01',
    ),
    _FinanceItem(
      id: '2',
      title: 'دعم حكومي',
      amount: 5000,
      type: 'income',
      category: 'دعم',
      date: '2026-06-05',
    ),
    _FinanceItem(
      id: '3',
      title: 'فواتير كهرباء',
      amount: -800,
      type: 'expense',
      category: 'فواتير',
      date: '2026-06-10',
    ),
    _FinanceItem(
      id: '4',
      title: 'إنترنت',
      amount: -200,
      type: 'expense',
      category: 'فواتير',
      date: '2026-06-15',
    ),
  ];

  double get _totalIncome =>
      _items.where((i) => i.type == 'income').fold(0, (s, i) => s + i.amount);

  double get _totalExpense =>
      _items.where((i) => i.type == 'expense').fold(0, (s, i) => s + i.amount);

  double get _balance => _totalIncome + _totalExpense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المالية'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Summary Cards
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'الإيرادات',
                    value: '$_totalIncome',
                    color: AppColors.success,
                    icon: Icons.arrow_downward,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _SummaryCard(
                    title: 'المصروفات',
                    value: '$_totalExpense',
                    color: AppColors.error,
                    icon: Icons.arrow_upward,
                  ),
                ),
              ],
            ),
          ),

          // Balance
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('الرصيد'),
                Text(
                  '$_balance ر.س',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: _balance >= 0 ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return _FinanceCard(
                  item: item,
                  onEdit: () => _editItem(item),
                  onDelete: () => _deleteItem(item.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _FinanceFormSheet(
        onSave: (item) => setState(() => _items.add(item)),
      ),
    );
  }

  void _editItem(_FinanceItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _FinanceFormSheet(
        item: item,
        onSave: (newItem) {
          setState(() {
            final index = _items.indexWhere((i) => i.id == item.id);
            if (index != -1) _items[index] = newItem;
          });
        },
      ),
    );
  }

  void _deleteItem(String id) {
    setState(() {
      _items.removeWhere((i) => i.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حذف العنصر'),
        backgroundColor: AppColors.error,
      ),
    );
  }
}

class _FinanceItem {
  final String id;
  final String title;
  final double amount;
  final String type;
  final String category;
  final String date;

  const _FinanceItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 4),
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '$value ر.س',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _FinanceCard extends StatelessWidget {
  final _FinanceItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _FinanceCard({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = item.type == 'income';

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: (isIncome ? AppColors.success : AppColors.error).withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            color: isIncome ? AppColors.success : AppColors.error,
          ),
        ),
        title: Text(item.title),
        subtitle: Text('${item.category} - ${item.date}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isIncome ? '+' : ''}${item.amount.toStringAsFixed(0)} ر.س',
              style: TextStyle(
                color: isIncome ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') onEdit();
                if (value == 'delete') onDelete();
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('حذف', style: TextStyle(color: AppColors.error)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FinanceFormSheet extends StatefulWidget {
  final _FinanceItem? item;
  final Function(_FinanceItem) onSave;

  const _FinanceFormSheet({this.item, required this.onSave});

  @override
  State<_FinanceFormSheet> createState() => _FinanceFormSheetState();
}

class _FinanceFormSheetState extends State<_FinanceFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  String _selectedType = 'income';
  String _selectedCategory = 'راتب';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item?.title);
    _amountController = TextEditingController(
      text: widget.item?.amount.abs().toString(),
    );
    _selectedType = widget.item?.type ?? 'income';
    _selectedCategory = widget.item?.category ?? 'راتب';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.item == null ? 'إضافة عنصر' : 'تعديل عنصر',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'العنوان'),
                validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'المبلغ'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v?.isEmpty == true) return 'مطلوب';
                  if (double.tryParse(v!) == null) return 'رقم غير صحيح';
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedType,
                      decoration: const InputDecoration(labelText: 'النوع'),
                      items: const [
                        DropdownMenuItem(value: 'income', child: Text('إيراد')),
                        DropdownMenuItem(value: 'expense', child: Text('مصروف')),
                      ],
                      onChanged: (v) => setState(() => _selectedType = v!),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'الفئة'),
                      items: const [
                        DropdownMenuItem(value: 'راتب', child: Text('راتب')),
                        DropdownMenuItem(value: 'دعم', child: Text('دعم')),
                        DropdownMenuItem(value: 'فواتير', child: Text('فواتير')),
                        DropdownMenuItem(value: 'أخرى', child: Text('أخرى')),
                      ],
                      onChanged: (v) => setState(() => _selectedCategory = v!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.item == null ? 'إضافة' : 'حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final finalAmount = _selectedType == 'expense' ? -amount : amount;

      widget.onSave(_FinanceItem(
        id: widget.item?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        amount: finalAmount,
        type: _selectedType,
        category: _selectedCategory,
        date: DateTime.now().toIso8601String().split('T')[0],
      ));

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم الحفظ'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}