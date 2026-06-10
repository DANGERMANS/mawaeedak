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
import '../features/centers/presentation/screens/screens.dart';
import '../features/notifications/presentation/screens/notifications_screen.dart';
import '../features/story/presentation/screens/story_screen.dart';
import '../features/admin/presentation/screens/screens.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/welcome/presentation/screens/welcome_screen.dart';
import '../features/static/presentation/screens/not_found_screen.dart';
import '../features/static/presentation/screens/splash_screen.dart';
import '../features/static/presentation/screens/disclaimer_screen.dart';
import '../features/static/presentation/screens/terms_screen.dart';
import '../features/static/presentation/screens/privacy_screen.dart';
import '../features/static/presentation/screens/support_screen.dart';
import '../features/static/presentation/screens/auth_callback_screen.dart';
import '../features/static/presentation/screens/reference_clone_screen.dart';
import '../features/static/presentation/screens/reset_password_screen.dart';
import '../core/widgets/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
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
    GoRoute(
      path: '/daily-card',
      name: 'daily-card',
      builder: (context, state) => const DailyCardScreen(),
    ),
    GoRoute(
      path: '/account',
      name: 'account',
      builder: (context, state) => const AccountScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    // Centers Routes
    GoRoute(
      path: '/centers',
      name: 'centers',
      builder: (context, state) => const CentersScreen(),
    ),
    GoRoute(
      path: '/centers/work',
      name: 'centers-work',
      builder: (context, state) => const CentersWorkScreen(),
    ),
    GoRoute(
      path: '/centers/study',
      name: 'centers-study',
      builder: (context, state) => const CentersStudyScreen(),
    ),
    GoRoute(
      path: '/centers/travel',
      name: 'centers-travel',
      builder: (context, state) => const CentersTravelScreen(),
    ),
    GoRoute(
      path: '/centers/news',
      name: 'centers-news',
      builder: (context, state) => const CentersNewsScreen(),
    ),
    GoRoute(
      path: '/centers/greetings',
      name: 'centers-greetings',
      builder: (context, state) => const CentersGreetingsScreen(),
    ),
    GoRoute(
      path: '/centers/complaints',
      name: 'centers-complaints',
      builder: (context, state) => const CentersComplaintsScreen(),
    ),
    GoRoute(
      path: '/centers/jobs',
      name: 'centers-jobs',
      builder: (context, state) => const CentersJobsScreen(),
    ),
    // Notifications & Story
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/story',
      name: 'story',
      builder: (context, state) => const StoryScreen(),
    ),
    // Admin Routes
    GoRoute(
      path: '/admin',
      name: 'admin',
      builder: (context, state) => const AdminLayoutScreen(),
    ),
    GoRoute(
      path: '/admin/dashboard',
      name: 'admin-dashboard',
      builder: (context, state) => const AdminDashboardScreen(),
    ),
    GoRoute(
      path: '/admin/events',
      name: 'admin-events',
      builder: (context, state) => const AdminEventsScreen(),
    ),
    GoRoute(
      path: '/admin/members',
      name: 'admin-members',
      builder: (context, state) => const AdminMembersScreen(),
    ),
    GoRoute(
      path: '/admin/finance',
      name: 'admin-finance',
      builder: (context, state) => const AdminFinanceScreen(),
    ),
    GoRoute(
      path: '/admin/settings',
      name: 'admin-settings',
      builder: (context, state) => const AdminSettingsScreen(),
    ),
    GoRoute(
      path: '/admin/automation',
      name: 'admin-automation',
      builder: (context, state) => const AdminAutomationScreen(),
    ),
    GoRoute(
      path: '/admin/complaints',
      name: 'admin-complaints',
      builder: (context, state) => const AdminComplaintsScreen(),
    ),
    GoRoute(
      path: '/admin/data',
      name: 'admin-data',
      builder: (context, state) => const AdminDataLayerScreen(),
    ),
    GoRoute(
      path: '/admin/messages',
      name: 'admin-messages',
      builder: (context, state) => const AdminMessagesScreen(),
    ),
    GoRoute(
      path: '/admin/news',
      name: 'admin-news',
      builder: (context, state) => const AdminNewsJobsScreen(),
    ),
    GoRoute(
      path: '/admin/notifications',
      name: 'admin-notifications',
      builder: (context, state) => const AdminNotificationsScreen(),
    ),
    GoRoute(
      path: '/admin/finance/official',
      name: 'admin-finance-official',
      builder: (context, state) => const AdminOfficialFinancialScreen(),
    ),
    GoRoute(
      path: '/admin/prayer',
      name: 'admin-prayer',
      builder: (context, state) => const AdminOfficialPrayerScreen(),
    ),
    GoRoute(
      path: '/admin/permissions',
      name: 'admin-permissions',
      builder: (context, state) => const AdminPermissionsScreen(),
    ),
    GoRoute(
      path: '/admin/reports',
      name: 'admin-reports',
      builder: (context, state) => const AdminReportsScreen(),
    ),
    GoRoute(
      path: '/admin/social',
      name: 'admin-social',
      builder: (context, state) => const AdminSocialScreen(),
    ),
    GoRoute(
      path: '/admin/story',
      name: 'admin-story',
      builder: (context, state) => const AdminStoryScreen(),
    ),
    GoRoute(
      path: '/admin/support',
      name: 'admin-support',
      builder: (context, state) => const AdminSupportScreen(),
    ),
    GoRoute(
      path: '/admin/themes',
      name: 'admin-themes',
      builder: (context, state) => const AdminThemesScreen(),
    ),
    GoRoute(
      path: '/admin/guide',
      name: 'admin-guide',
      builder: (context, state) => const AdminVisualGuideScreen(),
    ),
    GoRoute(
      path: '/admin/boundary',
      name: 'admin-boundary',
      builder: (context, state) => const AdminRuntimeBoundaryScreen(),
    ),
    // Auth & Welcome Routes
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      name: 'reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    // Static Pages
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/disclaimer',
      name: 'disclaimer',
      builder: (context, state) => const DisclaimerScreen(),
    ),
    GoRoute(
      path: '/terms',
      name: 'terms',
      builder: (context, state) => const TermsScreen(),
    ),
    GoRoute(
      path: '/privacy',
      name: 'privacy',
      builder: (context, state) => const PrivacyScreen(),
    ),
    GoRoute(
      path: '/support',
      name: 'support',
      builder: (context, state) => const SupportScreen(),
    ),
    GoRoute(
      path: '/auth/callback',
      name: 'auth-callback',
      builder: (context, state) => const AuthCallbackScreen(),
    ),
    GoRoute(
      path: '/reference',
      name: 'reference',
      builder: (context, state) => const ReferenceCloneScreen(),
    ),
    // 404 Not Found
    GoRoute(
      path: '*',
      name: 'not-found',
      builder: (context, state) => const NotFoundScreen(),
    ),
  ],
);

/// Route names for type-safe navigation
class AppRoutes {
  static const String home = 'home';
  static const String salary = 'salary';
  static const String services = 'services';
  static const String calendar = 'calendar';
  static const String more = 'more';
  static const String dailyCard = 'daily-card';
  static const String account = 'account';
  static const String settings = 'settings';
  static const String centers = 'centers';
  static const String notifications = 'notifications';
  static const String story = 'story';
  static const String admin = 'admin';
  static const String welcome = 'welcome';
  static const String auth = 'auth';
}