import 'package:tatpar_orange/configurations/configurations.dart';

final appHomeRoutes = [
  AutoRoute(
    initial: true,
    path: 'home',
    page: HomeRoute.page,
  ),
  AutoRoute(
    path: 'cases',
    page: CasesRoute.page,
  ),
  // AutoRoute(
  //   path: 'tasks',
  //   page: TasksRoute.page,
  // ),
  AutoRoute(
    path: 'settings',
    page: SettingsRoute.page,
  ),
  AutoRoute(
    path: 'profile',
    page: ProfileRoute.page,
  ),
];
