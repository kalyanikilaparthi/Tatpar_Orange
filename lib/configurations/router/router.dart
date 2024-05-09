import 'package:flutter/material.dart';
import 'package:tatpar_acf/features/mentalhealthscreening/presentation/pages/mental_health_routes.dart';

import '../../features/app/presentation/pages/app_home_routes.dart';
import '../../features/authentication/presentation/pages/auth_routes.dart';
import '../../features/case/presentation/pages/case_page_routes.dart';
import '../configurations.dart';

export 'package:auto_route/auto_route.dart';

export 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
  deferredLoading: true,
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/home',
      page: HomeRoute.page,
    ),
    AutoRoute(
        path: '/auth',
        page: AuthRouter.page,
        children: authRoutes,
        initial: true),
    AutoRoute(
      path: '*',
      page: UnknownRoute.page,
    ),
    AutoRoute(
      path: '/app_home',
      page: AppHomeRoute.page,
      children: appHomeRoutes,
    ),
    AutoRoute(
      path: '/case',
      page: CaseRouter.page,
      children: caseRoutes,
    ),
    AutoRoute(
      path: '/referral_details',
      page: ReferralDetailsRoute.page,
    ),
    AutoRoute(
      path: '/tb_screening_page',
      page: TBScreeningRoute.page,
    ),
    AutoRoute(
        path: '/mental_health_screening_page',
        page: MentalHealthRouterRoute.page,
        children: mentalHealthRoutes),
    AutoRoute(
      path: '/diagnosis_page',
      page: DiagnosisRoute.page,
    ),
    AutoRoute(
      path: '/treatment_page',
      page: TreatmentRoute.page,
    ),
    AutoRoute(
      path: '/outcome_page',
      page: OutcomeRoute.page,
    ),
    AutoRoute(
      path: '/contact_tracing_page',
      page: ContactTracingRoute.page,
    ),
  ];
}

Route<T> modalSheetBuilder<T>(
        BuildContext context, Widget child, AutoRoutePage<T> page) =>
    ModalBottomSheetRoute(
      settings: page,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: (MediaQuery.of(context).size.height / 10) * 7,
      ),
      builder: (context) => child,
    );

Route<T> dialogRouteBuilder<T>(
        BuildContext context, Widget child, AutoRoutePage<T> page) =>
    DialogRoute(
      settings: page,
      barrierDismissible: true,
      builder: (context) => child,
      context: context,
      useSafeArea: true,
      barrierColor: AppColors.surfaceVariantDark.withOpacity(.1),
    );
