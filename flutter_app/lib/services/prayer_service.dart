import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PrayerService {
  static const String _base = 'https://api.aladhan.com/v1';
  static const int _method = 4; // Umm Al-Qura

  static Future<Map<String, dynamic>> getByLocation({
    required double lat,
    required double lng,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    final cachedDate = prefs.getString('prayer_date');
    final cachedLat = prefs.getDouble('prayer_lat');
    final cachedLng = prefs.getDouble('prayer_lng');
    final cachedData = prefs.getString('prayer_data');

    // إذا الموقع تغير أو التاريخ تغير → تجاهل الكاش
    if (cachedDate == today &&
        cachedLat == lat &&
        cachedLng == lng &&
        cachedData != null) {
      return Map<String, dynamic>.from(jsonDecode(cachedData));
    }

    final url = Uri.parse(
      '$_base/timings?latitude=$lat&longitude=$lng&method=$_method',
    );

    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception('Failed to load prayer times');
    }

    final data = jsonDecode(res.body)['data']['timings'];

    // تخزين الكاش
    prefs.setString('prayer_date', today);
    prefs.setDouble('prayer_lat', lat);
    prefs.setDouble('prayer_lng', lng);
    prefs.setString('prayer_data', jsonEncode(data));

    return Map<String, dynamic>.from(data);
  }
}
