import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/salary/presentation/screens/salary_screen.dart';
import '../features/services/presentation/screens/services_screen.dart';
import '../features/calendar/presentation/screens/calendar_screen.dart';
import '../features/more/presentation/screens/more_screen.dart';
import '../features/daily_card/presentation/screens/daily_card_screen.dart';
import '../features/account/presentation/screens/account_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/permissions/presentation/screens/permissions_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/notifications/presentation/screens/notifications_screen.dart';
import '../features/admin/presentation/screens/admin_panel_screen.dart';
import '../core/widgets/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// App state for onboarding flow
bool _hasCompletedOnboarding = false;
bool _isInitialized = false;

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => SplashScreen(
          onComplete: () {
            if (_hasCompletedOnboarding) {
              context.go('/home');
            } else {
              context.go('/permissions');
            }
          },
        ),
      ),
      // Permissions Screen
      GoRoute(
        path: '/permissions',
        name: 'permissions',
        builder: (context, state) => PermissionsScreen(
          onComplete: () {
            _hasCompletedOnboarding = true;
            context.go('/home');
          },
        ),
      ),
      // Login Screen
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      // Notifications Screen
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      // Admin Panel Screen
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const AdminPanelScreen(),
      ),
      // Daily Card Screen (outside shell for full screen)
      GoRoute(
        path: '/daily-card',
        name: 'daily-card',
        builder: (context, state) => const DailyCardScreen(),
      ),
      // Account Screen
      GoRoute(
        path: '/account',
        name: 'account',
        builder: (context, state) => const AccountScreen(),
      ),
      // Settings Screen
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      // Shell Route with Bottom Navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/salary',
            name: 'salary',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SalaryScreen(),
            ),
          ),
          GoRoute(
            path: '/services',
            name: 'services',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ServicesScreen(),
            ),
          ),
          GoRoute(
            path: '/calendar',
            name: 'calendar',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CalendarScreen(),
            ),
          ),
          GoRoute(
            path: '/more',
            name: 'more',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MoreScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}

// Global router instance
final appRouter = createAppRouter();

/// Route names for type-safe navigation
class AppRoutes {
  static const String splash = 'splash';
  static const String permissions = 'permissions';
  static const String home = 'home';
  static const String salary = 'salary';
  static const String services = 'services';
  static const String calendar = 'calendar';
  static const String more = 'more';
  static const String dailyCard = 'daily-card';
  static const String account = 'account';
  static const String settings = 'settings';
  static const String login = 'login';
  static const String notifications = 'notifications';
  static const String admin = 'admin';
}