import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/salary/presentation/screens/salary_screen.dart';
import '../../features/services/presentation/screens/services_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/more/presentation/screens/more_screen.dart';
import '../../features/drawer/presentation/screens/drawer_screen.dart';
import '../../features/notification/presentation/screens/notification_screen.dart';
import '../../features/services/goal_calculator/presentation/screens/goal_calculator_screen.dart';
import '../../features/services/cost_calculator/presentation/screens/cost_calculator_screen.dart';
import '../../features/services/reminder/presentation/screens/reminder_screen.dart';
import '../../features/services/athkar/presentation/screens/athkar_screen.dart';
import '../../features/services/voice/presentation/screens/voice_screen.dart';
import '../../features/services/news_jobs/presentation/screens/news_jobs_screen.dart';
import '../../features/services/daily_card/presentation/screens/daily_card_screen.dart';
import '../../features/services/travel/presentation/screens/travel_screen.dart';
import '../../features/services/study/presentation/screens/study_screen.dart';
import '../../features/static/presentation/screens/splash_screen.dart';
import '../widgets/main_scaffold.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

CustomTransitionPage<void> _slidePage(Widget child, Offset begin) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: child,
      );
    },
  );
}

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(path: '/home', name: 'home', pageBuilder: (context, state) => const NoTransitionPage(child: HomeScreen())),
        GoRoute(path: '/salary', name: 'salary', pageBuilder: (context, state) => const NoTransitionPage(child: SalaryScreen())),
        GoRoute(path: '/services', name: 'services', pageBuilder: (context, state) => const NoTransitionPage(child: ServicesScreen())),
        GoRoute(path: '/calendar', name: 'calendar', pageBuilder: (context, state) => const NoTransitionPage(child: CalendarScreen())),
        GoRoute(path: '/more', name: 'more', pageBuilder: (context, state) => const NoTransitionPage(child: MoreScreen())),
      ],
    ),
    GoRoute(path: '/drawer', name: 'drawer', pageBuilder: (context, state) => _slidePage(const DrawerScreen(), const Offset(-1, 0))),
    GoRoute(path: '/notifications', name: 'notifications', pageBuilder: (context, state) => _slidePage(const NotificationScreen(), const Offset(1, 0))),
    GoRoute(path: '/goal-calculator', name: 'goal-calculator', pageBuilder: (context, state) => _slidePage(const GoalCalculatorScreen(), const Offset(0, 1))),
    GoRoute(path: '/cost-calculator', name: 'cost-calculator', pageBuilder: (context, state) => _slidePage(const CostCalculatorScreen(), const Offset(0, 1))),
    GoRoute(path: '/reminder', name: 'reminder', pageBuilder: (context, state) => _slidePage(const ReminderScreen(), const Offset(0, 1))),
    GoRoute(path: '/athkar', name: 'athkar', pageBuilder: (context, state) => _slidePage(const AthkarScreen(), const Offset(0, 1))),
    GoRoute(path: '/voice', name: 'voice', pageBuilder: (context, state) => _slidePage(const VoiceScreen(), const Offset(0, 1))),
    GoRoute(path: '/news-jobs', name: 'news-jobs', pageBuilder: (context, state) => _slidePage(const NewsJobsScreen(), const Offset(0, 1))),
    GoRoute(path: '/daily-card', name: 'daily-card', pageBuilder: (context, state) => _slidePage(const DailyCardScreen(), const Offset(0, 1))),
    GoRoute(path: '/travel', name: 'travel', pageBuilder: (context, state) => _slidePage(const TravelScreen(), const Offset(0, 1))),
    GoRoute(path: '/study', name: 'study', pageBuilder: (context, state) => _slidePage(const StudyScreen(), const Offset(0, 1))),
  ],
);
