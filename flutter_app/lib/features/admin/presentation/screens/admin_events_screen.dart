import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة الأحداث - الأدمن
class AdminEventsScreen extends StatefulWidget {
  const AdminEventsScreen({super.key});

  @override
  State<AdminEventsScreen> createState() => _AdminEventsScreenState();
}

class _AdminEventsScreenState extends State<AdminEventsScreen> {
  final List<_EventItem> _events = [
    _EventItem(
      id: '1',
      title: 'اجتماع الفريق',
      date: '2026-06-15',
      time: '10:00 ص',
      type: 'اجتماع',
      status: 'active',
    ),
    _EventItem(
      id: '2',
      title: 'محاضرة تعليمية',
      date: '2026-06-16',
      time: '02:00 م',
      type: 'تعليم',
      status: 'active',
    ),
    _EventItem(
      id: '3',
      title: 'حدث خاص',
      date: '2026-06-20',
      time: '06:00 م',
      type: 'خاص',
      status: 'completed',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الأحداث'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          return _EventCard(
            event: event,
            onEdit: () => _editEvent(event),
            onDelete: () => _deleteEvent(event.id),
          );
        },
      ),
    );
  }

  void _addEvent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _EventFormSheet(),
    );
  }

  void _editEvent(_EventItem event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _EventFormSheet(event: event),
    );
  }

  void _deleteEvent(String id) {
    setState(() {
      _events.removeWhere((e) => e.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حذف الحدث'),
        backgroundColor: AppColors.error,
      ),
    );
  }
}

class _EventItem {
  final String id;
  final String title;
  final String date;
  final String time;
  final String type;
  final String status;

  const _EventItem({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
  });
}

class _EventCard extends StatelessWidget {
  final _EventItem event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _EventCard({
    required this.event,
    required this.onEdit,
    required this.onDelete,
  });

  Color get _typeColor {
    switch (event.type) {
      case 'اجتماع':
        return const Color(0xFF4A90A4);
      case 'تعليم':
        return const Color(0xFF7B68EE);
      case 'خاص':
        return AppColors.gold;
      default:
        return AppColors.brown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _typeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    event.type,
                    style: TextStyle(color: _typeColor, fontSize: 12),
                  ),
                ),
                const Spacer(),
                if (event.status == 'completed')
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: const Text(
                      'مكتمل',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 12,
                      ),
                    ),
                  ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') onEdit();
                    if (value == 'delete') onDelete();
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('تعديل'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: AppColors.error),
                          SizedBox(width: 8),
                          Text('حذف', style: TextStyle(color: AppColors.error)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              event.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: AppColors.brown),
                const SizedBox(width: 4),
                Text(event.date, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: AppSpacing.md),
                Icon(Icons.access_time, size: 16, color: AppColors.brown),
                const SizedBox(width: 4),
                Text(event.time, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EventFormSheet extends StatefulWidget {
  final _EventItem? event;

  const _EventFormSheet({this.event});

  @override
  State<_EventFormSheet> createState() => _EventFormSheetState();
}

class _EventFormSheetState extends State<_EventFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;
  String _selectedType = 'اجتماع';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event?.title);
    _dateController = TextEditingController(text: widget.event?.date);
    _timeController = TextEditingController(text: widget.event?.time);
    _selectedType = widget.event?.type ?? 'اجتماع';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
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
                widget.event == null ? 'إضافة حدث' : 'تعديل حدث',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'العنوان'),
                validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(labelText: 'التاريخ'),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          _dateController.text =
                              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: TextFormField(
                      controller: _timeController,
                      decoration: const InputDecoration(labelText: 'الوقت'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'النوع'),
                items: ['اجتماع', 'تعليم', 'خاص', 'أخرى']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedType = v!),
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.event == null ? 'إضافة' : 'حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ الحدث'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}