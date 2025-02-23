import 'package:tatpar_orange/configurations/configurations.dart';

final authRoutes = [
  AutoRoute(
    initial: true,
    path: 'login',
    page: LoginRoute.page,
    children: [
      AutoRoute(
        path: 'phone',
        page: PhoneLoginRoute.page,
        initial: true,
      ),
    ],
  ),
  AutoRoute(
    path: 'register',
    page: RegisterRoute.page,
  ),
];
