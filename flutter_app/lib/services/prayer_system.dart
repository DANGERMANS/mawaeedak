import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'location_service.dart';
import 'prayer_service.dart';

class PrayerData {
  final Map<String, DateTime> timings;
  final String currentPrayer;
  final String nextPrayer;
  final DateTime sunrise;
  final Duration countdownToNext;
  final DateTime nextPrayerTime;

  PrayerData({
    required this.timings,
    required this.currentPrayer,
    required this.nextPrayer,
    required this.sunrise,
    required this.countdownToNext,
    required this.nextPrayerTime,
  });
}

class PrayerSystem {
  static const String _lastScheduleKey = 'prayer_system_last_schedule_key';
  static const String _lastWidgetDataKey = 'prayer_system_widget_data';

  Future<PrayerData> getPrayerData() async {
    final position = await LocationService.getLocation();
    final rawTimings = await PrayerService.getByLocation(
      lat: position.latitude,
      lng: position.longitude,
    );

    final timings = parsePrayerTimes(rawTimings);
    final currentPrayer = getCurrentPrayer(timings);
    final nextPrayerEntry = getNextPrayer(timings);
    final sunrise = getSunrise(timings);
    final countdown = getCountdownToNext(nextPrayerEntry.value);

    final data = PrayerData(
      timings: timings,
      currentPrayer: currentPrayer,
      nextPrayer: nextPrayerEntry.key,
      sunrise: sunrise,
      countdownToNext: countdown,
      nextPrayerTime: nextPrayerEntry.value,
    );

    await _refreshSystemStateIfNeeded(
      latitude: position.latitude,
      longitude: position.longitude,
      timings: timings,
      data: data,
    );

    return data;
  }

  Map<String, DateTime> parsePrayerTimes(Map<String, dynamic> rawTimings) {
    final now = DateTime.now();
    return <String, DateTime>{
      'الفجر': normalizeTime(rawTimings['Fajr']?.toString() ?? '', now),
      'الشروق': normalizeTime(rawTimings['Sunrise']?.toString() ?? '', now),
      'الظهر': normalizeTime(rawTimings['Dhuhr']?.toString() ?? '', now),
      'العصر': normalizeTime(rawTimings['Asr']?.toString() ?? '', now),
      'المغرب': normalizeTime(rawTimings['Maghrib']?.toString() ?? '', now),
      'العشاء': normalizeTime(rawTimings['Isha']?.toString() ?? '', now),
    };
  }

  String getCurrentPrayer(Map<String, DateTime> timings) {
    final now = DateTime.now();
    final ordered = _orderedPrayerEntries(timings);

    if (ordered.isEmpty) return '';

    for (var i = ordered.length - 1; i >= 0; i--) {
      if (!now.isBefore(ordered[i].value)) {
        return ordered[i].key;
      }
    }

    return ordered.last.key;
  }

  MapEntry<String, DateTime> getNextPrayer(Map<String, DateTime> timings) {
    final now = DateTime.now();
    final ordered = _orderedPrayerEntries(timings);

    for (final entry in ordered) {
      if (entry.value.isAfter(now)) {
        return entry;
      }
    }

    final fajr = timings['الفجر'];
    if (fajr != null) {
      return MapEntry('الفجر', fajr.add(const Duration(days: 1)));
    }

    return MapEntry('', now);
  }

  DateTime getSunrise(Map<String, DateTime> timings) {
    return timings['الشروق'] ?? DateTime.now();
  }

  Duration getCountdownToNext(DateTime nextPrayerTime) {
    final diff = nextPrayerTime.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  DateTime normalizeTime(String value, [DateTime? date]) {
    final base = date ?? DateTime.now();
    final clean = value.split(' ').first.trim();
    final parts = clean.split(':');
    final hour = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 0 : 0;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    final second = parts.length > 2 ? int.tryParse(parts[2]) ?? 0 : 0;

    return DateTime(base.year, base.month, base.day, hour, minute, second);
  }

  Future<Map<String, dynamic>> getWidgetData() async {
    final data = await getPrayerData();
    return <String, dynamic>{
      'currentPrayer': data.currentPrayer,
      'nextPrayer': getWidgetNextPrayer(data),
      'countdown': getWidgetCountdown(data),
      'timings': data.timings.map((key, value) => MapEntry(key, value.toIso8601String())),
      'sunrise': data.sunrise.toIso8601String(),
      'nextPrayerTime': data.nextPrayerTime.toIso8601String(),
    };
  }

  String getWidgetNextPrayer([PrayerData? data]) {
    if (data != null) return data.nextPrayer;
    return '';
  }

  Duration getWidgetCountdown([PrayerData? data]) {
    if (data != null) return getCountdownToNext(data.nextPrayerTime);
    return Duration.zero;
  }

  Future<void> _refreshSystemStateIfNeeded({
    required double latitude,
    required double longitude,
    required Map<String, DateTime> timings,
    required PrayerData data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final scheduleKey = jsonEncode(<String, dynamic>{
      'date': today,
      'lat': latitude.toStringAsFixed(5),
      'lng': longitude.toStringAsFixed(5),
      'timings': timings.map((key, value) => MapEntry(key, value.toIso8601String())),
    });

    final lastScheduleKey = prefs.getString(_lastScheduleKey);
    if (lastScheduleKey != scheduleKey) {
      final notificationService = PrayerNotificationService();
      await notificationService.clearOldNotifications();
      await notificationService.schedulePrayerNotifications(timings);
      await prefs.setString(_lastScheduleKey, scheduleKey);
    }

    await prefs.setString(
      _lastWidgetDataKey,
      jsonEncode(<String, dynamic>{
        'currentPrayer': data.currentPrayer,
        'nextPrayer': data.nextPrayer,
        'countdownSeconds': data.countdownToNext.inSeconds,
        'sunrise': data.sunrise.toIso8601String(),
        'nextPrayerTime': data.nextPrayerTime.toIso8601String(),
        'timings': data.timings.map((key, value) => MapEntry(key, value.toIso8601String())),
      }),
    );
  }

  List<MapEntry<String, DateTime>> _orderedPrayerEntries(Map<String, DateTime> timings) {
    final names = ['الفجر', 'الشروق', 'الظهر', 'العصر', 'المغرب', 'العشاء'];
    final entries = <MapEntry<String, DateTime>>[];
    for (final name in names) {
      final value = timings[name];
      if (value != null) {
        entries.add(MapEntry(name, value));
      }
    }
    entries.sort((a, b) => a.value.compareTo(b.value));
    return entries;
  }
}

class PrayerNotificationService {
  static const String _scheduledKey = 'prayer_system_scheduled_notifications';
  final List<Timer> _timers = <Timer>[];

  Future<void> initNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('prayer_notifications_initialized', true);
  }

  Future<void> schedulePrayerNotifications(Map<String, DateTime> timings) async {
    await initNotifications();
    await clearOldNotifications();

    var id = 1000;
    for (final entry in timings.entries) {
      if (entry.key == 'الشروق') continue;

      await scheduleSinglePrayer(
        id: id++,
        title: 'اقترب موعد أذان ${entry.key}',
        body: 'تبقى 10 دقائق على أذان ${entry.key}.',
        time: entry.value.subtract(const Duration(minutes: 10)),
      );

      await scheduleSinglePrayer(
        id: id++,
        title: 'حان الآن أذان ${entry.key}',
        body: 'حان الآن موعد أذان ${entry.key}.',
        time: entry.value,
      );
    }
  }

  Future<void> scheduleSinglePrayer({
    required int id,
    required String title,
    required String body,
    required DateTime time,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_scheduledKey) ?? <String>[];
    final payload = jsonEncode(<String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'time': time.toIso8601String(),
      'scheduledAt': DateTime.now().toIso8601String(),
    });

    existing.removeWhere((item) {
      final decoded = jsonDecode(item) as Map<String, dynamic>;
      return decoded['id'] == id;
    });
    existing.add(payload);
    await prefs.setStringList(_scheduledKey, existing);

    final delay = time.difference(DateTime.now());
    if (!delay.isNegative) {
      _timers.add(Timer(delay, () async {
        final updatedPrefs = await SharedPreferences.getInstance();
        final delivered = updatedPrefs.getStringList('prayer_system_delivered_notifications') ?? <String>[];
        delivered.add(payload);
        await updatedPrefs.setStringList('prayer_system_delivered_notifications', delivered);
      }));
    }
  }

  Future<void> clearOldNotifications() async {
    for (final timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scheduledKey);
  }
}
