import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة مواقيت الصلاة الرسمية - الأدمن
class AdminOfficialPrayerScreen extends StatefulWidget {
  const AdminOfficialPrayerScreen({super.key});

  @override
  State<AdminOfficialPrayerScreen> createState() =>
      _AdminOfficialPrayerScreenState();
}

class _AdminOfficialPrayerScreenState
    extends State<AdminOfficialPrayerScreen> {
  String _selectedCity = 'الرياض';

  final List<_PrayerTime> _prayerTimes = [
    _PrayerTime(name: 'الفجر', time: '04:15', isActive: true),
    _PrayerTime(name: 'الشروق', time: '05:45', isActive: true),
    _PrayerTime(name: 'الظهر', time: '11:50', isActive: true),
    _PrayerTime(name: 'العصر', time: '15:15', isActive: true),
    _PrayerTime(name: 'المغرب', time: '18:45', isActive: true),
    _PrayerTime(name: 'العشاء', time: '20:15', isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مواقيت الصلاة'),
      ),
      body: Column(
        children: [
          // City Selector
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: DropdownButtonFormField<String>(
              value: _selectedCity,
              decoration: const InputDecoration(
                labelText: 'المدينة',
              ),
              items: ['الرياض', 'جدة', 'مكة', 'المدينة', 'الدمام']
                  .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (city) {
                if (city != null) setState(() => _selectedCity = city);
              },
            ),
          ),

          // Prayer Times
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _prayerTimes.length,
              itemBuilder: (context, index) {
                final prayer = _prayerTimes[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Icon(Icons.mosque, color: AppColors.gold),
                    ),
                    title: Text(prayer.name),
                    subtitle: Text(prayer.isActive ? 'مفعّل' : 'معطّل'),
                    trailing: Text(
                      prayer.time,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.gold,
                      ),
                    ),
                    onTap: () => _editPrayerTime(prayer),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editPrayerTime(_PrayerTime prayer) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تعديل وقت ${prayer.name}')),
    );
  }
}

class _PrayerTime {
  final String name;
  final String time;
  final bool isActive;

  const _PrayerTime({
    required this.name,
    required this.time,
    required this.isActive,
  });
}