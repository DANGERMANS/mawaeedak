import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/models.dart';
import '../../../data/services/api_service.dart';
import '../../../core/constants/app_constants.dart';

/// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

/// Prayer Times Provider - Real API with local fallback
final prayerTimesProvider = StateNotifierProvider<PrayerTimesNotifier, PrayerTimes>((ref) {
  return PrayerTimesNotifier(ref);
});

class PrayerTimesNotifier extends StateNotifier<PrayerTimes> {
  final Ref _ref;

  PrayerTimesNotifier(this._ref) : super(PrayerTimes.mock) {
    _loadPrayerTimes();
  }

  Future<void> _loadPrayerTimes() async {
    try {
      final api = _ref.read(apiServiceProvider);
      final times = await api.getPrayerTimes(
        city: AppConstants.defaultCityKey,
        date: DateTime.now().toIso8601String().split('T')[0],
      );
      state = times;
    } catch (e) {
      state = PrayerTimes.mock;
    }
  }

  void updateTimes(PrayerTimes times) {
    state = times;
  }
}

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
  static const Map<String, ScheduleApiSetting> apiSettings = {
    'salary': ScheduleApiSetting(enabled: true, showOnHome: true),
    'citizenAccount': ScheduleApiSetting(enabled: true, showOnHome: true),
    'socialSecurity': ScheduleApiSetting(enabled: true, showOnHome: true),
    'hafiz': ScheduleApiSetting(enabled: true, showOnHome: true),
    'reef': ScheduleApiSetting(enabled: false, showOnHome: false),
    'sakani': ScheduleApiSetting(enabled: false, showOnHome: false),
    'tamheer': ScheduleApiSetting(enabled: false, showOnHome: false),
    'productive': ScheduleApiSetting(enabled: false, showOnHome: false),
  };

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

  List<FinancialEvent> activeItems() {
    final today = DateTime.now();
    final items = definitions
        .where((definition) => definition.setting.enabled)
        .map((definition) => _buildEvent(definition, today))
        .toList();
    items.sort((a, b) => a.daysRemaining.compareTo(b.daysRemaining));
    return items;
  }

  List<FinancialEvent> homeItems() {
    final allowed = definitions
        .where((definition) => definition.setting.enabled && definition.setting.showOnHome)
        .map((definition) => definition.id)
        .toSet();
    return activeItems().where((event) => allowed.contains(event.id)).toList();
  }

  FinancialEvent? nearestItem() {
    final items = activeItems();
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
      type: definition.type,
      daysRemaining: remaining,
    );
  }
}

final scheduleServiceProvider = Provider<ScheduleService>((ref) {
  return ScheduleService();
});

/// Financial Events Provider - unified salary/support schedule
final financialEventsProvider = StateNotifierProvider<FinancialEventsNotifier, List<FinancialEvent>>((ref) {
  return FinancialEventsNotifier(ref);
});

final financialHomeEventsProvider = Provider<List<FinancialEvent>>((ref) {
  return ref.watch(scheduleServiceProvider).homeItems();
});

final nearestFinancialEventProvider = Provider<FinancialEvent?>((ref) {
  return ref.watch(scheduleServiceProvider).nearestItem();
});

class FinancialEventsNotifier extends StateNotifier<List<FinancialEvent>> {
  final Ref _ref;

  FinancialEventsNotifier(this._ref) : super(const []) {
    _loadFinancialEvents();
  }

  Future<void> _loadFinancialEvents() async {
    state = _ref.read(scheduleServiceProvider).activeItems();
  }

  void refresh() {
    state = _ref.read(scheduleServiceProvider).activeItems();
  }
}

/// Appointments Provider - Real API with local fallback
final appointmentsProvider = StateNotifierProvider<AppointmentsNotifier, List<Appointment>>((ref) {
  return AppointmentsNotifier(ref);
});

class AppointmentsNotifier extends StateNotifier<List<Appointment>> {
  final Ref _ref;

  AppointmentsNotifier(this._ref) : super(_mockAppointments) {
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    try {
      final api = _ref.read(apiServiceProvider);
      final appointments = await api.getAppointments();
      state = appointments;
    } catch (e) {}
  }

  void addAppointment(Appointment appointment) {
    state = [...state, appointment];
    _ref.read(apiServiceProvider).createAppointment(appointment);
  }

  void removeAppointment(String id) {
    state = state.where((a) => a.id != id).toList();
    _ref.read(apiServiceProvider).deleteAppointment(id);
  }

  void updateAppointment(Appointment appointment) {
    state = state.map((a) => a.id == appointment.id ? appointment : a).toList();
  }
}

final _mockAppointments = [
  const Appointment(
    id: '1',
    title: 'زيارة الطبيب',
    date: '2026-06-12',
    time: '10:00',
    type: 'medical',
    notes: 'فحص دوري',
  ),
  const Appointment(
    id: '2',
    title: 'تجديد الإقامة',
    date: '2026-06-15',
    time: '14:00',
    type: 'official',
  ),
  const Appointment(
    id: '3',
    title: 'اجتماع عمل',
    date: '2026-06-18',
    time: '09:00',
    type: 'personal',
    notes: 'فندق الريتز',
  ),
];

/// Service Centers Provider - Real API with local fallback
final serviceCentersProvider = StateNotifierProvider<ServiceCentersNotifier, List<ServiceCenter>>((ref) {
  return ServiceCentersNotifier(ref);
});

class ServiceCentersNotifier extends StateNotifier<List<ServiceCenter>> {
  final Ref _ref;

  ServiceCentersNotifier(this._ref) : super([]) {
    _loadServiceCenters();
  }

  Future<void> _loadServiceCenters() async {
    final localCenters = AppConstants.serviceCenters.map((center) {
      return ServiceCenter(
        id: center['id'] as int,
        name: center['name'] as String,
        icon: center['icon'] as String,
        services: List<String>.from(center['services'] as List),
      );
    }).toList();

    state = localCenters;

    try {
      final api = _ref.read(apiServiceProvider);
      final centers = await api.getServiceCenters();
      if (centers.isNotEmpty) {
        state = centers;
      }
    } catch (e) {}
  }
}

/// User Provider - Real API with local fallback
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier(ref);
});

class UserNotifier extends StateNotifier<User> {
  final Ref _ref;

  UserNotifier(this._ref) : super(User.empty) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final api = _ref.read(apiServiceProvider);
      final user = await api.getUserProfile();
      state = user;
    } catch (e) {}
  }

  void updateUser(User user) {
    state = user;
    _ref.read(apiServiceProvider).updateUserProfile(user);
  }

  void updateName(String name) {
    final newUser = User(
      id: state.id,
      name: name,
      email: state.email,
      city: state.city,
      cityKey: state.cityKey,
      timezone: state.timezone,
      role: state.role,
      onboardingComplete: state.onboardingComplete,
    );
    state = newUser;
    _ref.read(apiServiceProvider).updateUserProfile(newUser);
  }

  void updateCity(String city, String cityKey) {
    final newUser = User(
      id: state.id,
      name: state.name,
      email: state.email,
      city: city,
      cityKey: cityKey,
      timezone: state.timezone,
      role: state.role,
      onboardingComplete: state.onboardingComplete,
    );
    state = newUser;
    _ref.read(apiServiceProvider).updateUserProfile(newUser);
  }
}

/// Settings Provider
class AppSettings {
  final bool prayerNotifications;
  final bool financialNotifications;
  final bool appointmentNotifications;
  final bool dailyCardNotifications;
  final bool hapticFeedback;
  final bool autoLocation;

  const AppSettings({
    this.prayerNotifications = true,
    this.financialNotifications = true,
    this.appointmentNotifications = true,
    this.dailyCardNotifications = false,
    this.hapticFeedback = true,
    this.autoLocation = true,
  });

  AppSettings copyWith({
    bool? prayerNotifications,
    bool? financialNotifications,
    bool? appointmentNotifications,
    bool? dailyCardNotifications,
    bool? hapticFeedback,
    bool? autoLocation,
  }) {
    return AppSettings(
      prayerNotifications: prayerNotifications ?? this.prayerNotifications,
      financialNotifications: financialNotifications ?? this.financialNotifications,
      appointmentNotifications: appointmentNotifications ?? this.appointmentNotifications,
      dailyCardNotifications: dailyCardNotifications ?? this.dailyCardNotifications,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      autoLocation: autoLocation ?? this.autoLocation,
    );
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(const AppSettings());

  void togglePrayerNotifications() {
    state = state.copyWith(prayerNotifications: !state.prayerNotifications);
  }

  void toggleFinancialNotifications() {
    state = state.copyWith(financialNotifications: !state.financialNotifications);
  }

  void toggleAppointmentNotifications() {
    state = state.copyWith(appointmentNotifications: !state.appointmentNotifications);
  }

  void toggleDailyCardNotifications() {
    state = state.copyWith(dailyCardNotifications: !state.dailyCardNotifications);
  }

  void toggleHapticFeedback() {
    state = state.copyWith(hapticFeedback: !state.hapticFeedback);
  }

  void toggleAutoLocation() {
    state = state.copyWith(autoLocation: !state.autoLocation);
  }
}

/// Selected Date Provider for Calendar
final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

/// Current Tab Index Provider
final currentTabIndexProvider = StateProvider<int>((ref) => 0);

/// Daily Message Provider
final dailyMessageProvider = Provider<String>((ref) {
  return AppConstants.defaultDailyMessage;
});
