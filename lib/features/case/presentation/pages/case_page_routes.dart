import 'package:tatpar_orange/features/mentalhealthscreening/presentation/pages/mental_health_routes.dart';

import '../../../../configurations/configurations.dart';

final caseRoutes = [
  AutoRoute(
    initial: true,
    path: 'case_profile',
    page: CaseProfileRoute.page,
  ),
  AutoRoute(
    path: 'referral_details',
    page: ReferralDetailsRoute.page,
  ),
  AutoRoute(
    path: 'tb_screening_page',
    page: TBScreeningRoute.page,
  ),
  AutoRoute(
    path: 'mental_health_screening_page',
    page: MentalHealthRouterRoute.page,
    children: mentalHealthRoutes,
  ),
  AutoRoute(
    path: 'diagnosis_page',
    page: DiagnosisRoute.page,
  ),
  AutoRoute(
    path: 'treatment_page',
    page: TreatmentRoute.page,
  ),
  AutoRoute(
    path: 'faq_checklist_page',
    page: FaqChecklistRoute.page,
  ),
  AutoRoute(
    path: 'outcome_page',
    page: OutcomeRoute.page,
  ),
  AutoRoute(
    path: 'contact_tracing_list_page',
    page: ContactTracingListRoute.page,
  ),
  AutoRoute(
    path: 'contact_tracing_page',
    page: ContactTracingRouter.page,
  ),
];
