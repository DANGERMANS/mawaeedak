import '../data/models/models.dart';

class ScheduleApiSetting {
  final bool enabled;
  final bool showOnHome;

  const ScheduleApiSetting({required this.enabled, required this.showOnHome});
}

class ScheduleItemDefinition {
  final String id;
  final String name;
  final int paymentDay;
  final String type;
  final ScheduleApiSetting setting;

  const ScheduleItemDefinition({
    required this.id,
    required this.name,
    required this.paymentDay,
    required this.type,
    required this.setting,
  });
}

class ScheduleService {
  static const List<ScheduleItemDefinition> definitions = [
    ScheduleItemDefinition(id: 'salary', name: 'الراتب', paymentDay: 27, type: 'salary', setting: ScheduleApiSetting(enabled: true, showOnHome: true)),
    ScheduleItemDefinition(id: 'citizenAccount', name: 'حساب المواطن', paymentDay: 10, type: 'support', setting: ScheduleApiSetting(enabled: true, showOnHome: true)),
    ScheduleItemDefinition(id: 'socialSecurity', name: 'الضمان الاجتماعي', paymentDay: 1, type: 'social', setting: ScheduleApiSetting(enabled: true, showOnHome: true)),
    ScheduleItemDefinition(id: 'hafiz', name: 'حافز', paymentDay: 5, type: 'support', setting: ScheduleApiSetting(enabled: true, showOnHome: true)),
    ScheduleItemDefinition(id: 'reef', name: 'دعم ريف', paymentDay: 1, type: 'support', setting: ScheduleApiSetting(enabled: false, showOnHome: false)),
    ScheduleItemDefinition(id: 'sakani', name: 'الدعم السكني', paymentDay: 24, type: 'housing', setting: ScheduleApiSetting(enabled: false, showOnHome: false)),
    ScheduleItemDefinition(id: 'tamheer', name: 'تمهير', paymentDay: 1, type: 'support', setting: ScheduleApiSetting(enabled: false, showOnHome: false)),
    ScheduleItemDefinition(id: 'productive', name: 'دعم الأسر المنتجة', paymentDay: 1, type: 'support', setting: ScheduleApiSetting(enabled: false, showOnHome: false)),
  ];

  List<FinancialEvent> salaryListItems() {
    final today = DateTime.now();
    final items = definitions.map((definition) => _buildEvent(definition, today)).toList();
    items.sort((a, b) => a.daysRemaining.compareTo(b.daysRemaining));
    return items;
  }

  List<FinancialEvent> homeItems() {
    final today = DateTime.now();
    final items = definitions
        .where((definition) => definition.setting.enabled && definition.setting.showOnHome)
        .map((definition) => _buildEvent(definition, today))
        .toList();
    items.sort((a, b) => a.daysRemaining.compareTo(b.daysRemaining));
    return items;
  }

  FinancialEvent? nearestItem() {
    final items = homeItems();
    if (items.isEmpty) return null;
    return items.first;
  }

  FinancialEvent _buildEvent(ScheduleItemDefinition definition, DateTime today) {
    var target = DateTime(today.year, today.month, definition.paymentDay);
    final todayOnly = DateTime(today.year, today.month, today.day);
    if (target.isBefore(todayOnly)) {
      target = DateTime(today.year, today.month + 1, definition.paymentDay);
    }
    final remaining = target.difference(todayOnly).inDays;
    return FinancialEvent(
      id: definition.id,
      name: definition.name,
      nameAr: definition.name,
      date: target.toIso8601String().split('T').first,
      type: definition.setting.enabled ? definition.type : 'disabled',
      daysRemaining: remaining,
    );
  }
}
