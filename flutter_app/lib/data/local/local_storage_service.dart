import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Local Storage Service for persisting all app data
class LocalStorageService {
  static LocalStorageService? _instance;
  late SharedPreferences _prefs;

  LocalStorageService._();

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._();
      _instance!._prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // Keys
  static const String _keyUserProfile = 'user_profile';
  static const String _keySession = 'session';
  static const String _keyPermissions = 'permissions';
  static const String _keyNotifications = 'notifications';
  static const String _keyFinancialEvents = 'financial_events';
  static const String _keyAppointments = 'appointments';
  static const String _keyTrips = 'trips';
  static const String _keyTripChecklistItems = 'trip_checklist_items';
  static const String _keyComplaints = 'complaints';
  static const String _keyGreetings = 'greetings';
  static const String _keyContactMessages = 'contact_messages';
  static const String _keyNews = 'news';
  static const String _keyJobs = 'jobs';
  static const String _keyCalendarEvents = 'calendar_events';
  static const String _keyDailyMessages = 'daily_messages';
  static const String _keyDailyCardTemplates = 'daily_card_templates';
  static const String _keyCostGoals = 'cost_goals';
  static const String _keyCostItems = 'cost_items';
  static const String _keySettings = 'settings';
  static const String _keyOnboardingComplete = 'onboarding_complete';

  // Generic CRUD operations
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    await _prefs.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getJson(String key) {
    final str = _prefs.getString(key);
    if (str == null) return null;
    return jsonDecode(str) as Map<String, dynamic>;
  }

  Future<void> setJsonList(String key, List<Map<String, dynamic>> value) async {
    await _prefs.setString(key, jsonEncode(value));
  }

  List<Map<String, dynamic>> getJsonList(String key) {
    final str = _prefs.getString(key);
    if (str == null) return [];
    final decoded = jsonDecode(str) as List;
    return decoded.cast<Map<String, dynamic>>();
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  // Onboarding
  Future<void> setOnboardingComplete(bool value) async {
    await _prefs.setBool(_keyOnboardingComplete, value);
  }

  bool isOnboardingComplete() {
    return _prefs.getBool(_keyOnboardingComplete) ?? false;
  }

  // Permissions
  Future<void> savePermissions(Map<String, dynamic> permissions) async {
    await setJson(_keyPermissions, permissions);
  }

  Map<String, dynamic>? getPermissions() {
    return getJson(_keyPermissions);
  }

  // Notifications
  Future<void> saveNotifications(List<Map<String, dynamic>> notifications) async {
    await setJsonList(_keyNotifications, notifications);
  }

  List<Map<String, dynamic>> getNotifications() {
    return getJsonList(_keyNotifications);
  }

  // Financial Events
  Future<void> saveFinancialEvents(List<Map<String, dynamic>> events) async {
    await setJsonList(_keyFinancialEvents, events);
  }

  List<Map<String, dynamic>> getFinancialEvents() {
    return getJsonList(_keyFinancialEvents);
  }

  // Appointments
  Future<void> saveAppointments(List<Map<String, dynamic>> appointments) async {
    await setJsonList(_keyAppointments, appointments);
  }

  List<Map<String, dynamic>> getAppointments() {
    return getJsonList(_keyAppointments);
  }

  // Trips
  Future<void> saveTrips(List<Map<String, dynamic>> trips) async {
    await setJsonList(_keyTrips, trips);
  }

  List<Map<String, dynamic>> getTrips() {
    return getJsonList(_keyTrips);
  }

  // Trip Checklist Items
  Future<void> saveTripChecklistItems(List<Map<String, dynamic>> items) async {
    await setJsonList(_keyTripChecklistItems, items);
  }

  List<Map<String, dynamic>> getTripChecklistItems() {
    return getJsonList(_keyTripChecklistItems);
  }

  // Complaints
  Future<void> saveComplaints(List<Map<String, dynamic>> complaints) async {
    await setJsonList(_keyComplaints, complaints);
  }

  List<Map<String, dynamic>> getComplaints() {
    return getJsonList(_keyComplaints);
  }

  // Greetings
  Future<void> saveGreetings(List<Map<String, dynamic>> greetings) async {
    await setJsonList(_keyGreetings, greetings);
  }

  List<Map<String, dynamic>> getGreetings() {
    return getJsonList(_keyGreetings);
  }

  // Contact Messages
  Future<void> saveContactMessages(List<Map<String, dynamic>> messages) async {
    await setJsonList(_keyContactMessages, messages);
  }

  List<Map<String, dynamic>> getContactMessages() {
    return getJsonList(_keyContactMessages);
  }

  // News
  Future<void> saveNews(List<Map<String, dynamic>> news) async {
    await setJsonList(_keyNews, news);
  }

  List<Map<String, dynamic>> getNews() {
    return getJsonList(_keyNews);
  }

  // Jobs
  Future<void> saveJobs(List<Map<String, dynamic>> jobs) async {
    await setJsonList(_keyJobs, jobs);
  }

  List<Map<String, dynamic>> getJobs() {
    return getJsonList(_keyJobs);
  }

  // Calendar Events
  Future<void> saveCalendarEvents(List<Map<String, dynamic>> events) async {
    await setJsonList(_keyCalendarEvents, events);
  }

  List<Map<String, dynamic>> getCalendarEvents() {
    return getJsonList(_keyCalendarEvents);
  }

  // Daily Messages
  Future<void> saveDailyMessages(List<Map<String, dynamic>> messages) async {
    await setJsonList(_keyDailyMessages, messages);
  }

  List<Map<String, dynamic>> getDailyMessages() {
    return getJsonList(_keyDailyMessages);
  }

  // Daily Card Templates
  Future<void> saveDailyCardTemplates(List<Map<String, dynamic>> templates) async {
    await setJsonList(_keyDailyCardTemplates, templates);
  }

  List<Map<String, dynamic>> getDailyCardTemplates() {
    return getJsonList(_keyDailyCardTemplates);
  }

  // Cost Goals
  Future<void> saveCostGoals(List<Map<String, dynamic>> goals) async {
    await setJsonList(_keyCostGoals, goals);
  }

  List<Map<String, dynamic>> getCostGoals() {
    return getJsonList(_keyCostGoals);
  }

  // Cost Items
  Future<void> saveCostItems(List<Map<String, dynamic>> items) async {
    await setJsonList(_keyCostItems, items);
  }

  List<Map<String, dynamic>> getCostItems() {
    return getJsonList(_keyCostItems);
  }

  // Session/User
  Future<void> saveSession(Map<String, dynamic> session) async {
    await setJson(_keySession, session);
  }

  Map<String, dynamic>? getSession() {
    return getJson(_keySession);
  }

  Future<void> clearSession() async {
    await remove(_keySession);
  }

  // User Profile
  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await setJson(_keyUserProfile, profile);
  }

  Map<String, dynamic>? getUserProfile() {
    return getJson(_keyUserProfile);
  }

  // Settings
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    await setJson(_keySettings, settings);
  }

  Map<String, dynamic>? getSettings() {
    return getJson(_keySettings);
  }
}