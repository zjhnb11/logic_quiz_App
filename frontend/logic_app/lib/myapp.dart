import 'package:flutter/material.dart';
import 'dart:core';
import 'package:go_router/go_router.dart';
import 'package:log_app/myhomepage.dart';
import 'package:log_app/screen/ExplainationScreen.dart';
import 'package:log_app/screen/SettingScreen.dart';
import 'package:log_app/screen/StatisticalScreen.dart';
import 'package:log_app/screen/QuizScreen.dart';
import 'package:log_app/screen/login_subscreen/LoginScreen.dart';
import 'package:log_app/screen/setting_subscreen/profilescreen.dart';
import 'package:log_app/screen/setting_subscreen/infoscreen.dart';
import 'package:log_app/screen/quiz_subscreen/quiz_processScreen.dart';
import 'package:log_app/screen/login_subscreen/RegisterScreen.dart';
import 'package:log_app/screen/login_subscreen/ForotpasswordScreen.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/explaination',
        icon: Icon(Icons.book_outlined),
        label: 'Explaination',
      ),
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/quiz',
        icon: Icon(Icons.playlist_add_check_outlined),
        label: 'Quiz',
      ),
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/statistics',
        icon: Icon(Icons.bar_chart_outlined),
        label: 'Statistics',
      ),
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/settings',
        icon: Icon(Icons.settings_outlined),
        label: 'Settings',
      ),
    ];

    late GoRouter goRouter;

    goRouter = GoRouter(
      initialLocation: '/login',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return ScaffoldWithBottomNavBar(tabs: tabs, child: child);
          },
          routes: [
            GoRoute(
              path: '/explaination',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ExplainationScreen(),
              ),
            ),
            // Shopping Cart
            GoRoute(
                path: '/quiz',
                pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const QuizScreen(),
                    ),
                routes: [
                  GoRoute(
                    path: 'quiz_process',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const QuizProcessScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'quiz_process',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const QuizScreen(),
                    ),
                  ),
                ]),
            GoRoute(
              path: '/statistics',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const StatisticialScreen(),
              ),
            ),
            GoRoute(
                path: '/settings',
                pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const SettingScreen(),
                    ),
                routes: [
                  GoRoute(
                    path: 'profile',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const ProfileScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'info',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const InfoScreen(),
                    ),
                  ),
                ]),
            GoRoute(
                path: '/login',
                pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const LoginScreen(),
                    ),
                routes: [
                  GoRoute(
                    path: 'register',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const RegisterScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'forgotpassword',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const ForgotpasswordScreen(),
                    ),
                  ),
                ]),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'Log App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(236, 0, 228, 1)),
      ),
    );
  }
}
