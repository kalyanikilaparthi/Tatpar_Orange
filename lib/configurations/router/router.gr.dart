// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i30;
import 'package:flutter/material.dart' as _i31;
import 'package:tatpar_orange/features/app/presentation/pages/app_home_page.dart'
    deferred as _i1;
import 'package:tatpar_orange/features/app/presentation/pages/success_dialog.dart'
    deferred as _i24;
import 'package:tatpar_orange/features/app/presentation/pages/unknown_page.dart'
    deferred as _i28;
import 'package:tatpar_orange/features/authentication/presentation/pages/auth_router_page.dart'
    deferred as _i2;
import 'package:tatpar_orange/features/authentication/presentation/pages/login_page.dart'
    deferred as _i15;
import 'package:tatpar_orange/features/authentication/presentation/pages/phone_login_page.dart'
    deferred as _i19;
import 'package:tatpar_orange/features/authentication/presentation/pages/register_page.dart'
    deferred as _i22;
import 'package:tatpar_orange/features/basicdetails/presentation/pages/basicdetails_page.dart'
    deferred as _i3;
import 'package:tatpar_orange/features/case/data/case_models/case_model.dart'
    as _i32;
import 'package:tatpar_orange/features/case/presentation/pages/case_profile_page.dart'
    deferred as _i5;
import 'package:tatpar_orange/features/case/presentation/pages/case_router_page.dart'
    deferred as _i6;
import 'package:tatpar_orange/features/conducttbscreening/presentation/pages/tb_screening_page.dart'
    deferred as _i25;
import 'package:tatpar_orange/features/contacttracing/models/contact_tracing_model.dart'
    as _i33;
import 'package:tatpar_orange/features/contacttracing/presentation/pages/contact_tracing_list_page.dart'
    deferred as _i9;
import 'package:tatpar_orange/features/contacttracing/presentation/pages/contact_tracing_page.dart'
    deferred as _i10;
import 'package:tatpar_orange/features/contacttracing/presentation/pages/contact_tracing_router_page.dart'
    deferred as _i11;
import 'package:tatpar_orange/features/diagnosis/presentation/pages/diagnosis_page.dart'
    deferred as _i12;
import 'package:tatpar_orange/features/faochecklist/presentation/faq_checklist_page.dart'
    deferred as _i13;
import 'package:tatpar_orange/features/home/presentation/pages/case_filter_right_page.dart'
    deferred as _i4;
import 'package:tatpar_orange/features/home/presentation/pages/cases_filter_dialog_page.dart'
    deferred as _i7;
import 'package:tatpar_orange/features/home/presentation/pages/cases_page.dart'
    deferred as _i8;
import 'package:tatpar_orange/features/home/presentation/pages/home_page.dart'
    deferred as _i14;
import 'package:tatpar_orange/features/mentalhealthscreening/presentation/pages/mental_health_router_page.dart'
    deferred as _i16;
import 'package:tatpar_orange/features/mentalhealthscreening/presentation/pages/mental_health_screening_page.dart'
    deferred as _i17;
import 'package:tatpar_orange/features/mentalhealthscreening/presentation/pages/who_srq_page.dart'
    deferred as _i29;
import 'package:tatpar_orange/features/outcome/presentation/pages/outcome_page.dart'
    deferred as _i18;
import 'package:tatpar_orange/features/profile/presentation/pages/profile_page.dart'
    deferred as _i20;
import 'package:tatpar_orange/features/referral/presentation/pages/referraldetails.dart'
    deferred as _i21;
import 'package:tatpar_orange/features/settings/presentation/pages/settings_page.dart'
    deferred as _i23;
import 'package:tatpar_orange/features/tasks/presentation/pages/tasks_page.dart'
    deferred as _i26;
import 'package:tatpar_orange/features/treatment/presentation/pages/treatment_page.dart'
    deferred as _i27;

abstract class $AppRouter extends _i30.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i30.PageFactory> pagesMap = {
    AppHomeRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i1.loadLibrary,
          () => _i30.WrappedRoute(child: _i1.AppHomePage()),
        ),
      );
    },
    AuthRouter.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.AuthRouterPage(),
        ),
      );
    },
    BasicDetails.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.BasicDetails(),
        ),
      );
    },
    CaseFilterRightRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.CaseFilterRightPage(),
        ),
      );
    },
    CaseProfileRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.CaseProfilePage(),
        ),
      );
    },
    CaseRouter.name: (routeData) {
      final args = routeData.argsAs<CaseRouterArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.CaseRouterPage(
            key: args.key,
            caseModel: args.caseModel,
          ),
        ),
      );
    },
    CasesFilterDialogRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.CasesFilterDialogPage(),
        ),
      );
    },
    CasesRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.CasesPage(),
        ),
      );
    },
    ContactTracingListRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i9.loadLibrary,
          () => _i9.ContactTracingListPage(),
        ),
      );
    },
    ContactTracingRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i10.loadLibrary,
          () => _i10.ContactTracingPage(),
        ),
      );
    },
    ContactTracingRouter.name: (routeData) {
      final args = routeData.argsAs<ContactTracingRouterArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i11.loadLibrary,
          () => _i11.ContactTracingRouterPage(
            key: args.key,
            contactTracingModel: args.contactTracingModel,
          ),
        ),
      );
    },
    DiagnosisRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i12.loadLibrary,
          () => _i12.DiagnosisPage(),
        ),
      );
    },
    FaqChecklistRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i13.loadLibrary,
          () => _i13.FaqChecklistPage(),
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i14.loadLibrary,
          () => _i14.HomePage(),
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i15.loadLibrary,
          () => _i15.LoginPage(),
        ),
      );
    },
    MentalHealthRouterRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i16.loadLibrary,
          () => _i16.MentalHealthRouterPage(),
        ),
      );
    },
    MentalHealthScreeningRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i17.loadLibrary,
          () => _i17.MentalHealthScreeningPage(),
        ),
      );
    },
    OutcomeRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i18.loadLibrary,
          () => _i18.OutcomePage(),
        ),
      );
    },
    PhoneLoginRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i19.loadLibrary,
          () => _i19.PhoneLoginPage(),
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i20.loadLibrary,
          () => _i20.ProfilePage(),
        ),
      );
    },
    ReferralDetailsRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i21.loadLibrary,
          () => _i21.ReferralDetailsPage(),
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i22.loadLibrary,
          () => _i22.RegisterPage(key: args.key),
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i23.loadLibrary,
          () => _i23.SettingsPage(),
        ),
      );
    },
    SuccessDialogRoute.name: (routeData) {
      final args = routeData.argsAs<SuccessDialogRouteArgs>();
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i24.loadLibrary,
          () => _i24.SuccessDialogPage(
            key: args.key,
            message: args.message,
            actionText: args.actionText,
          ),
        ),
      );
    },
    TBScreeningRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i25.loadLibrary,
          () => _i25.TBScreeningPage(),
        ),
      );
    },
    TasksRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i26.loadLibrary,
          () => _i26.TasksPage(),
        ),
      );
    },
    TreatmentRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i27.loadLibrary,
          () => _i27.TreatmentPage(),
        ),
      );
    },
    UnknownRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i28.loadLibrary,
          () => _i28.UnknownPage(),
        ),
      );
    },
    WHOSRQRoute.name: (routeData) {
      return _i30.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.DeferredWidget(
          _i29.loadLibrary,
          () => _i29.WHOSRQPage(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AppHomePage]
class AppHomeRoute extends _i30.PageRouteInfo<void> {
  const AppHomeRoute({List<_i30.PageRouteInfo>? children})
      : super(
          AppHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppHomeRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AuthRouterPage]
class AuthRouter extends _i30.PageRouteInfo<void> {
  const AuthRouter({List<_i30.PageRouteInfo>? children})
      : super(
          AuthRouter.name,
          initialChildren: children,
        );

  static const String name = 'AuthRouter';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BasicDetails]
class BasicDetails extends _i30.PageRouteInfo<void> {
  const BasicDetails({List<_i30.PageRouteInfo>? children})
      : super(
          BasicDetails.name,
          initialChildren: children,
        );

  static const String name = 'BasicDetails';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CaseFilterRightPage]
class CaseFilterRightRoute extends _i30.PageRouteInfo<void> {
  const CaseFilterRightRoute({List<_i30.PageRouteInfo>? children})
      : super(
          CaseFilterRightRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaseFilterRightRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CaseProfilePage]
class CaseProfileRoute extends _i30.PageRouteInfo<void> {
  const CaseProfileRoute({List<_i30.PageRouteInfo>? children})
      : super(
          CaseProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'CaseProfileRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CaseRouterPage]
class CaseRouter extends _i30.PageRouteInfo<CaseRouterArgs> {
  CaseRouter({
    _i31.Key? key,
    required _i32.Case caseModel,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          CaseRouter.name,
          args: CaseRouterArgs(
            key: key,
            caseModel: caseModel,
          ),
          initialChildren: children,
        );

  static const String name = 'CaseRouter';

  static const _i30.PageInfo<CaseRouterArgs> page =
      _i30.PageInfo<CaseRouterArgs>(name);
}

class CaseRouterArgs {
  const CaseRouterArgs({
    this.key,
    required this.caseModel,
  });

  final _i31.Key? key;

  final _i32.Case caseModel;

  @override
  String toString() {
    return 'CaseRouterArgs{key: $key, caseModel: $caseModel}';
  }
}

/// generated route for
/// [_i7.CasesFilterDialogPage]
class CasesFilterDialogRoute extends _i30.PageRouteInfo<void> {
  const CasesFilterDialogRoute({List<_i30.PageRouteInfo>? children})
      : super(
          CasesFilterDialogRoute.name,
          initialChildren: children,
        );

  static const String name = 'CasesFilterDialogRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i8.CasesPage]
class CasesRoute extends _i30.PageRouteInfo<void> {
  const CasesRoute({List<_i30.PageRouteInfo>? children})
      : super(
          CasesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CasesRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ContactTracingListPage]
class ContactTracingListRoute extends _i30.PageRouteInfo<void> {
  const ContactTracingListRoute({List<_i30.PageRouteInfo>? children})
      : super(
          ContactTracingListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactTracingListRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ContactTracingPage]
class ContactTracingRoute extends _i30.PageRouteInfo<void> {
  const ContactTracingRoute({List<_i30.PageRouteInfo>? children})
      : super(
          ContactTracingRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactTracingRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ContactTracingRouterPage]
class ContactTracingRouter
    extends _i30.PageRouteInfo<ContactTracingRouterArgs> {
  ContactTracingRouter({
    _i31.Key? key,
    required _i33.ContactTracingModel contactTracingModel,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          ContactTracingRouter.name,
          args: ContactTracingRouterArgs(
            key: key,
            contactTracingModel: contactTracingModel,
          ),
          initialChildren: children,
        );

  static const String name = 'ContactTracingRouter';

  static const _i30.PageInfo<ContactTracingRouterArgs> page =
      _i30.PageInfo<ContactTracingRouterArgs>(name);
}

class ContactTracingRouterArgs {
  const ContactTracingRouterArgs({
    this.key,
    required this.contactTracingModel,
  });

  final _i31.Key? key;

  final _i33.ContactTracingModel contactTracingModel;

  @override
  String toString() {
    return 'ContactTracingRouterArgs{key: $key, contactTracingModel: $contactTracingModel}';
  }
}

/// generated route for
/// [_i12.DiagnosisPage]
class DiagnosisRoute extends _i30.PageRouteInfo<void> {
  const DiagnosisRoute({List<_i30.PageRouteInfo>? children})
      : super(
          DiagnosisRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiagnosisRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i13.FaqChecklistPage]
class FaqChecklistRoute extends _i30.PageRouteInfo<void> {
  const FaqChecklistRoute({List<_i30.PageRouteInfo>? children})
      : super(
          FaqChecklistRoute.name,
          initialChildren: children,
        );

  static const String name = 'FaqChecklistRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i14.HomePage]
class HomeRoute extends _i30.PageRouteInfo<void> {
  const HomeRoute({List<_i30.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i15.LoginPage]
class LoginRoute extends _i30.PageRouteInfo<void> {
  const LoginRoute({List<_i30.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i16.MentalHealthRouterPage]
class MentalHealthRouterRoute extends _i30.PageRouteInfo<void> {
  const MentalHealthRouterRoute({List<_i30.PageRouteInfo>? children})
      : super(
          MentalHealthRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'MentalHealthRouterRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i17.MentalHealthScreeningPage]
class MentalHealthScreeningRoute extends _i30.PageRouteInfo<void> {
  const MentalHealthScreeningRoute({List<_i30.PageRouteInfo>? children})
      : super(
          MentalHealthScreeningRoute.name,
          initialChildren: children,
        );

  static const String name = 'MentalHealthScreeningRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i18.OutcomePage]
class OutcomeRoute extends _i30.PageRouteInfo<void> {
  const OutcomeRoute({List<_i30.PageRouteInfo>? children})
      : super(
          OutcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'OutcomeRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i19.PhoneLoginPage]
class PhoneLoginRoute extends _i30.PageRouteInfo<void> {
  const PhoneLoginRoute({List<_i30.PageRouteInfo>? children})
      : super(
          PhoneLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneLoginRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i20.ProfilePage]
class ProfileRoute extends _i30.PageRouteInfo<void> {
  const ProfileRoute({List<_i30.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i21.ReferralDetailsPage]
class ReferralDetailsRoute extends _i30.PageRouteInfo<void> {
  const ReferralDetailsRoute({List<_i30.PageRouteInfo>? children})
      : super(
          ReferralDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReferralDetailsRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i22.RegisterPage]
class RegisterRoute extends _i30.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i31.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i30.PageInfo<RegisterRouteArgs> page =
      _i30.PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i23.SettingsPage]
class SettingsRoute extends _i30.PageRouteInfo<void> {
  const SettingsRoute({List<_i30.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i24.SuccessDialogPage]
class SuccessDialogRoute extends _i30.PageRouteInfo<SuccessDialogRouteArgs> {
  SuccessDialogRoute({
    _i31.Key? key,
    required String message,
    String actionText = 'Okay',
    List<_i30.PageRouteInfo>? children,
  }) : super(
          SuccessDialogRoute.name,
          args: SuccessDialogRouteArgs(
            key: key,
            message: message,
            actionText: actionText,
          ),
          initialChildren: children,
        );

  static const String name = 'SuccessDialogRoute';

  static const _i30.PageInfo<SuccessDialogRouteArgs> page =
      _i30.PageInfo<SuccessDialogRouteArgs>(name);
}

class SuccessDialogRouteArgs {
  const SuccessDialogRouteArgs({
    this.key,
    required this.message,
    this.actionText = 'Okay',
  });

  final _i31.Key? key;

  final String message;

  final String actionText;

  @override
  String toString() {
    return 'SuccessDialogRouteArgs{key: $key, message: $message, actionText: $actionText}';
  }
}

/// generated route for
/// [_i25.TBScreeningPage]
class TBScreeningRoute extends _i30.PageRouteInfo<void> {
  const TBScreeningRoute({List<_i30.PageRouteInfo>? children})
      : super(
          TBScreeningRoute.name,
          initialChildren: children,
        );

  static const String name = 'TBScreeningRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i26.TasksPage]
class TasksRoute extends _i30.PageRouteInfo<void> {
  const TasksRoute({List<_i30.PageRouteInfo>? children})
      : super(
          TasksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i27.TreatmentPage]
class TreatmentRoute extends _i30.PageRouteInfo<void> {
  const TreatmentRoute({List<_i30.PageRouteInfo>? children})
      : super(
          TreatmentRoute.name,
          initialChildren: children,
        );

  static const String name = 'TreatmentRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i28.UnknownPage]
class UnknownRoute extends _i30.PageRouteInfo<void> {
  const UnknownRoute({List<_i30.PageRouteInfo>? children})
      : super(
          UnknownRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnknownRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}

/// generated route for
/// [_i29.WHOSRQPage]
class WHOSRQRoute extends _i30.PageRouteInfo<void> {
  const WHOSRQRoute({List<_i30.PageRouteInfo>? children})
      : super(
          WHOSRQRoute.name,
          initialChildren: children,
        );

  static const String name = 'WHOSRQRoute';

  static const _i30.PageInfo<void> page = _i30.PageInfo<void>(name);
}
