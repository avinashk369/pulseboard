import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pulseboard/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:pulseboard/features/details/presentation/pages/detail_screen.dart';
import 'package:pulseboard/features/settings/presentation/pages/settings_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: DashboardRoute.page, initial: true),
        AutoRoute(page: DetailsRoute.page, path: '/details/:sensorId'),
        AutoRoute(page: SettingsRoute.page),
      ];
}
