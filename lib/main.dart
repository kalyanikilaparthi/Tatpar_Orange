import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:djangoflow_app_links/djangoflow_app_links.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tatpar_orange/configurations/network/application_error.dart';
import 'package:tatpar_orange/features/appProvider/app_provider.dart';
import 'package:tatpar_orange/features/case/data/case_models/case_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/diagnosis_data.dart';
import 'package:tatpar_orange/features/case/data/source_models/diagnosis_data_fields.dart';
import 'package:tatpar_orange/features/case/data/source_models/caste_category_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/data_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/key_population_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/referral_districts_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/referrer_source_model.dart';
import 'package:tatpar_orange/features/case/data/source_models/trimester_model.dart';
import 'package:tatpar_orange/features/conducttbscreening/model/tb_screening_model.dart';
import 'package:tatpar_orange/features/contacttracing/models/contact_tracing_model.dart';
import 'package:tatpar_orange/features/diagnosis/model/diagnosis_model.dart';
import 'package:tatpar_orange/features/faochecklist/models/faq_checklist_model.dart';
import 'package:tatpar_orange/features/mentalhealthscreening/model/mental_health_screening_model.dart';
import 'package:tatpar_orange/features/mentalhealthscreening/model/who_srq_model.dart';
import 'package:tatpar_orange/features/outcome/model/outcome_model.dart';
import 'package:tatpar_orange/features/referral/model/referral_details_model.dart';
import 'package:tatpar_orange/features/treatment/model/treatment_model.dart';
import 'package:tatpar_orange/firebase_options.dart';
import 'package:tatpar_orange/l10n/language_provider.dart';
import 'package:tatpar_orange/tatpar_orange_app_builder.dart';
import 'package:tatpar_orange/utils/extensions/app_dio_exception.dart';
import 'package:tatpar_orange/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'configurations/configurations.dart';

late Box box;
Future<void> main() async {
  DjangoflowAppRunner.run(onException: (exception, stackTrace) {
    if (exception is FirebaseAuthException) {
      DjangoflowAppSnackbar.showError(exception.userFriendlyMessage);
    } else if (exception is DioException) {
      DjangoflowAppSnackbar.showError(exception.userFriendlyMessage);
    } else if (exception is ApplicationError) {
      DjangoflowAppSnackbar.showError(exception.errorMsg);
    } else {
      log(exception.toString(), stackTrace: stackTrace);
    }
  }, rootWidgetBuilder: (appBuilder) async {
    String? initialDeepLink;
    final appLinksRepository = AppLinksRepository();
    AppCubit.initialState = const AppState(
      themeMode: ThemeMode.light,
    );

    await Hive.initFlutter();

    ///ReferralDetailsGetApi
    Hive.registerAdapter(CasteCategoryAdapter());
    Hive.registerAdapter(KeyPopulationAdapter());
    Hive.registerAdapter(ReferrerSourceAdapter());
    Hive.registerAdapter(TrimesterAdapter());
    Hive.registerAdapter(DistrictAdapter());
    Hive.registerAdapter(BlockAdapter());
    Hive.registerAdapter(PanchayatAdapter());
    Hive.registerAdapter(DataModelAdapter());
    await Hive.openBox<DataModel>('dataModel');

    ///diagnosisGetAPI
    Hive.registerAdapter(AFBResultAdapter());
    Hive.registerAdapter(NaatMachineAdapter());
    Hive.registerAdapter(MTBResultAdapter());
    Hive.registerAdapter(TPTRegimenAdapter());
    Hive.registerAdapter(TreatmentOutcomeAdapter());
    Hive.registerAdapter(TreatmentHistoryAdapter());
    Hive.registerAdapter(DiagnosisDataAdapter());
    await Hive.openBox<DiagnosisData>('diagnosisData');

    ///caseListGetAPI -14
    Hive.registerAdapter(CaseAdapter());
    await Hive.openBox<Case>('caseList');
    // await Hive.deleteBoxFromDisk('caseList');

    ///ReferralDetailsUpdateAPI
    Hive.registerAdapter(ReferralDetailsModelAdapter());
    await Hive.openBox<ReferralDetailsModel>('referralDetailsModel');
    // await Hive.deleteBoxFromDisk('referralDetailsModel');

    ///TBScreeningUpdateAPI
    Hive.registerAdapter(TBScreeningModelAdapter());
    await Hive.openBox<TBScreeningModel>('tbScreeningModel');
    // await Hive.deleteBoxFromDisk('tbScreeningModel');

    ///MentalHealthScreeningUpdateAPI
    Hive.registerAdapter(MentalHealthScreeningModelAdapter());
    Hive.registerAdapter(WHOSrqModelAdapter());
    // await Hive.openBox<WHOSrqModel>('whoSrqModel');

    await Hive.openBox<MentalHealthScreeningModel>(
        'mentalHealthScreeningModel');
    // await Hive.deleteBoxFromDisk('mentalHealthScreeningModel');

    ///DiagnosisUpdateAPI
    Hive.registerAdapter(DiagnosisModelAdapter());
    await Hive.openBox<DiagnosisModel>('diagnosisModel');
    // await Hive.deleteBoxFromDisk('diagnosisModel');

    ///TreatmentUpdateAPI
    Hive.registerAdapter(TreatmentModelAdapter());
    await Hive.openBox<TreatmentModel>('treatmentModel');
    //await Hive.deleteBoxFromDisk('treatmentModel');

    ///ContactTracingUpdateAPI
    Hive.registerAdapter(ContactTracingModelAdapter());
    await Hive.openBox<ContactTracingModel>('contactTracingModel');
    //await Hive.deleteBoxFromDisk('contactTracingModel');

    ///OutcomeUpdateAPI
    Hive.registerAdapter(OutcomeModelAdapter());
    await Hive.openBox<OutcomeModel>('outcomeModel');
    // await Hive.deleteBoxFromDisk('outcomeModel');

    ///FaqChecklistUpdateAPI
    Hive.registerAdapter(FaqChecklistModelAdapter());
    await Hive.openBox<FaqChecklistModel>('faqCheckListModel');
    // await Hive.deleteBoxFromDisk('faqCheckListModel');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    const fatalError = true;
    // Non-async exceptions
    FlutterError.onError = (errorDetails) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };
    final router = AppRouter(navigatorKey: navigatorKey);
    if (!kIsWeb) {
      initialDeepLink = (await appLinksRepository.getInitialLink())?.path;
    }
    final savedLocale = await LanguageProvider.getSavedLocale();

    return ChangeNotifierProvider(create: (_) {
      return LanguageProvider(savedLocale);
    }, builder: (context, child) {
      final provider = Provider.of<LanguageProvider>(context);

      return ChangeNotifierProvider<AppProvider>(create: (_) {
        return AppProvider();
      }, builder: (context, child) {
        Provider.of<AppProvider>(context);
        return TatparAcfAppBuilder(
          appRouter: router,
          initialDeepLink: initialDeepLink,
          appLinksRepository: appLinksRepository,
          provider: provider,
        );
      });
    });
  });
}
