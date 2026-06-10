import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// خدمات الشكاوى
class CentersComplaintsScreen extends StatefulWidget {
  const CentersComplaintsScreen({super.key});

  @override
  State<CentersComplaintsScreen> createState() => _CentersComplaintsScreenState();
}

class _CentersComplaintsScreenState extends State<CentersComplaintsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'شكوى';

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشكاوى والمقترحات'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Type Selection
              Row(
                children: [
                  _TypeChip(
                    label: 'شكوى',
                    isSelected: _selectedType == 'شكوى',
                    onTap: () => setState(() => _selectedType = 'شكوى'),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _TypeChip(
                    label: 'اقتراح',
                    isSelected: _selectedType == 'اقتراح',
                    onTap: () => setState(() => _selectedType = 'اقتراح'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Subject
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'الموضوع',
                  hintText: 'أدخل موضوع الشكوى',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الموضوع';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'الوصف',
                  hintText: 'اكتب تفاصيل الشكوى هنا...',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الوصف';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // Submit Button
              ElevatedButton(
                onPressed: _submitComplaint,
                child: const Text('إرسال الشكوى'),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Previous Complaints
              Text(
                'الشكاوى السابقة',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              _PreviousComplaintCard(
                subject: 'شكوى سابقة 1',
                status: 'قيد المراجعة',
                date: '2026-06-05',
              ),
              _PreviousComplaintCard(
                subject: 'شكوى سابقة 2',
                status: 'تم الحل',
                date: '2026-05-20',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال الشكوى بنجاح'),
          backgroundColor: AppColors.success,
        ),
      );
      _subjectController.clear();
      _descriptionController.clear();
    }
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isSelected ? AppColors.gold : AppColors.brown,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.brown,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _PreviousComplaintCard extends StatelessWidget {
  final String subject;
  final String status;
  final String date;

  const _PreviousComplaintCard({
    required this.subject,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        title: Text(subject),
        subtitle: Text(date),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: status == 'تم الحل'
                ? AppColors.success.withOpacity(0.1)
                : AppColors.gold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: status == 'تم الحل' ? AppColors.success : AppColors.gold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}