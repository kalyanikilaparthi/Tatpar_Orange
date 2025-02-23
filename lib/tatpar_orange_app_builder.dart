import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:djangoflow_app_links/djangoflow_app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tatpar_orange/features/app/presentation/builders/app_responsive_layout_builder.dart';
import 'package:tatpar_orange/features/authentication/blocs/auth_cubit.dart';
import 'package:tatpar_orange/features/authentication/data/repo/auth_repo.dart';
import 'package:tatpar_orange/features/authentication/presentation/listeners/login_listener_wrapper.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/case/blocs/case_list_cubit.dart';
import 'package:tatpar_orange/features/case/blocs/source_cubit.dart';
import 'package:tatpar_orange/features/case/data/case_models/case_model.dart';
import 'package:tatpar_orange/features/case/data/repos/case_repo.dart';
import 'package:tatpar_orange/features/case/data/repos/source_repo.dart';
import 'package:tatpar_orange/features/referral/repository/referraldetails_repository.dart';
import 'package:tatpar_orange/l10n/l10n.dart';
import 'package:tatpar_orange/l10n/language_provider.dart';

import 'configurations/configurations.dart';

class TatparAcfAppBuilder extends AppBuilder {
  TatparAcfAppBuilder({
    super.key,
    super.onDispose,
    required AppRouter appRouter,
    required AppLinksRepository appLinksRepository,
    required LanguageProvider provider,
    final String? initialDeepLink,
  }) : super(
          onInitState: (context) {},
          repositoryProviders: [
            RepositoryProvider<AppLinksRepository>.value(
              value: appLinksRepository,
            ),
            RepositoryProvider<CaseRepo>(
              create: (context) => CaseRepo(),
            ),
            RepositoryProvider<SourceRepo>(
              create: (context) => SourceRepo(),
            ),
            RepositoryProvider<AuthRepo>(
              create: (context) => AuthRepo(),
            ),
            RepositoryProvider<ReferralDetailsRepository>(
              create: (context) => ReferralDetailsRepository(),
            )
          ],
          blocProviders: [
            BlocProvider<AppCubit>(
              create: (context) => AppCubit.instance,
            ),
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit.instance
                ..init(
                  context.read<AuthRepo>(),
                ),
              lazy: false,
            ),
            BlocProvider<AppLinksCubit>(
              create: (context) => AppLinksCubit(
                null,
                context.read<AppLinksRepository>(),
              ),
              lazy: false,
            ),
            BlocProvider<SourceCubit>(
              create: (context) => SourceCubit(
                context.read<SourceRepo>(),
              ),
            ),
            BlocProvider<CaseListCubit>(
              create: (context) => CaseListCubit(
                caseRepo: context.read<CaseRepo>(),
              ),
            ),
            BlocProvider<CaseCubit>(
              create: (context) => CaseCubit(
                  caseRepo: context.read<CaseRepo>(), caseModel: const Case()),
            )
          ],
          builder: (context) => LoginListenerWrapper(
            initialUser: context.read<AuthCubit>().state.user,
            onLogin: (context, user) {
              ///For performing tasks after login
              context.read<AuthCubit>().loadUserDetails();

              context.read<SourceCubit>().loadDistricts();
              context.read<SourceCubit>().loadDiagnosisData();

              context.read<CaseListCubit>().getCasesForHealthWorker();
            },
            onLogout: (context) {},
            child: AppCubitConsumer(
                listenWhen: (previous, current) =>
                    previous.environment != current.environment,
                listener: (context, state) async {},
                builder: (context, appState) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    scaffoldMessengerKey:
                        DjangoflowAppSnackbar.scaffoldMessengerKey,
                    title: appName,
                    routeInformationParser: appRouter.defaultRouteParser(),
                    theme: AppTheme.light,
                    darkTheme: AppTheme.dark,
                    themeMode: appState.themeMode,
                    // locale: Locale(appState.locale, ''),
                    locale: provider.locale,
                    supportedLocales: L10n.all,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    routerDelegate: appRouter.delegate(
                      deepLinkBuilder: (_) => initialDeepLink != null
                          ? DeepLink.path(initialDeepLink)
                          : const DeepLink(
                              [
                                AppHomeRoute(),
                              ],
                            ),
                      // List of global navigation obsersers here
                      // SentryNavigationObserver
                      // navigatorObservers: () => {RouteObserver()},
                    ),
                    builder: (context, child) => AppResponsiveLayoutBuilder(
                      child: SandboxBanner(
                        isSandbox:
                            appState.environment == AppEnvironment.sandbox,
                        child: child != null
                            ? kIsWeb
                                ? child
                                : AppLinksCubitListener(
                                    listenWhen: (previous, current) =>
                                        current != null,
                                    listener: (context, appLink) {
                                      final path = appLink?.path;
                                      if (path != null) {
                                        appRouter.navigateNamed(
                                          path,
                                          onFailure: (failure) {
                                            appRouter.navigate(
                                              const AppHomeRoute(),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: child,
                                  )
                            : const Offstage(),
                      ),
                    ),
                  );
                }),
          ),
        );
}
