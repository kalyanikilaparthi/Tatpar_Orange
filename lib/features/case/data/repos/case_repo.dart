import 'dart:developer';

import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tatpar_acf/configurations/configurations.dart';
import 'package:tatpar_acf/configurations/network/api_constants.dart';
import 'package:tatpar_acf/configurations/network/api_response.dart';
import 'package:tatpar_acf/configurations/network/application_error.dart';
import 'package:tatpar_acf/configurations/network/network_manager.dart';
import 'package:tatpar_acf/configurations/network/network_request.dart';
import 'package:tatpar_acf/features/authentication/blocs/auth_cubit.dart';
import 'package:tatpar_acf/features/case/blocs/source_cubit.dart';
import 'package:tatpar_acf/features/case/data/case_models/case_model.dart';
import 'package:tatpar_acf/features/case/data/source_models/diagnosis_data_fields.dart';
import 'package:tatpar_acf/features/case/data/source_models/referral_districts_model.dart';
import 'package:tatpar_acf/features/conducttbscreening/model/tb_screening_model.dart';
import 'package:tatpar_acf/features/contacttracing/models/contact_tracing_model.dart';
import 'package:tatpar_acf/features/diagnosis/model/diagnosis_model.dart';
import 'package:tatpar_acf/features/faochecklist/models/faq_checklist_model.dart';
import 'package:tatpar_acf/features/mentalhealthscreening/model/mental_health_screening_model.dart';
import 'package:tatpar_acf/features/mentalhealthscreening/model/who_srq_model.dart';
import 'package:tatpar_acf/features/outcome/model/outcome_model.dart';
import 'package:tatpar_acf/features/referral/model/referral_details_model.dart';
import 'package:tatpar_acf/features/treatment/model/treatment_model.dart';

class CaseRepo {
  Future<ReferralDetailsModel> saveReferralDetails(
      {required ReferralDetailsModel referralDetailsModel,
      required int? id,
      required String referralId}) async {
    Box<ReferralDetailsModel> dataBox =
        Hive.box<ReferralDetailsModel>('referralDetailsModel');
    final existingModelIndex =
        dataBox.values.toList().indexWhere((model) => model.id == id);

    ///checking for inernet connection
    bool hasInternet = await InternetConnection().hasInternetAccess;
    if ((referralDetailsModel.isCaseUpdated == false ||
            referralDetailsModel.isCaseUpdated == null) &&
        hasInternet &&
        existingModelIndex != -1) {
      log('Pushing data to Server because network is available while trying to update in Local Storage${referralDetailsModel.toString()}');

      log('Deleting ReferralModel: ${dataBox.getAt(existingModelIndex)}');
      // Delete the old model in local storage
      await dataBox.deleteAt(existingModelIndex);

      deleteCaseLocal(referralDetailsModel.caseId);
      id = null;
    }
    final request = NetworkRequest(
      '$referralDetailsUrl${id == null ? '' : '/$id'}',
      id == null ? RequestMethod.post : RequestMethod.patch,
      isAuthorized: true,
      data: {
        ...referralDetailsModel.toJson(),
        'logged_in_user': AuthCubit.instance.state.user!.mobileNumber,
      },
    );

    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final savedModel = ReferralDetailsModel.fromJson(result.data['data']);

      /// save the model to local storage with its new server id
      await dataBox.put(savedModel.id.toString(), savedModel);

      ///push the locally stored data
      pushPendingReferralDetails();

      AuthCubit.instance.caseId = result.data['data']['case_id'];

      return savedModel;
    } else {
      if (result.error != null && result.error?.type is NetworkError) {
        final userMobile = AuthCubit.instance.state.user!.mobileNumber;

        // Retrieve all stored models
        final modelsList = dataBox.values.toList();
        ReferralDetailsModel updateModel = referralDetailsModel;

        // Check if referral form ID already exists in the list and id is not null
        final existingModelIndex = modelsList.indexWhere(
          (model) => id != null && model.id == id,
        );

        if (existingModelIndex != -1) {
          // If the model exists, update it
          await dataBox.put(updateModel.id.toString(), updateModel);

          // DjangoflowAppSnackbar.showInfo('Updated data Locally');

          /// Update the case model of local storage

          updateCaseBox(
              model: updateModel,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: null);

          return updateModel;
        } else {
          await CounterManager.instance.initialize();
          int counter = await CounterManager.instance.getNextCounter();

          final userMobilePrefix = userMobile.substring(0, 5);
          final modelToSave = updateModel.copyWith(
            isCaseUpdated: false,
            caseId: int.tryParse('$userMobilePrefix$counter'),
            id: int.tryParse(
                '$userMobilePrefix$counter'), // Assign unique referral form id
          );

          // Save the new model to Hive
          await dataBox.put(modelToSave.id.toString(), modelToSave);
          updateCaseBox(
              model: modelToSave,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              contactTracingModel: null,
              diagnosisModel: null,
              outcomeModel: null,
              treatmentModel: null,
              faqCheckListModel: null);

          // DjangoflowAppSnackbar.showInfo('Stored data Locally');
          AuthCubit.instance.caseId = modelToSave.caseId;
          log('OFFLINE CASEiD=========${AuthCubit.instance.workingCaseId}');
          return modelToSave;
        }
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<TBScreeningModel> saveTbScreeningData(
      {required TBScreeningModel tbScreeningModel,
      required int? id,
      required int? caseId}) async {
    Box<TBScreeningModel> tbdatabox =
        Hive.box<TBScreeningModel>('tbScreeningModel');
    final existingModelIndex =
        tbdatabox.values.toList().indexWhere((model) => model.id == id);

    bool hasInternet = await InternetConnection().hasInternetAccess;

    if ((tbScreeningModel.isFormIDAssigned == null ||
            tbScreeningModel.isFormIDAssigned == false) &&
        hasInternet &&
        existingModelIndex != -1) {
      await tbdatabox.put(tbScreeningModel.id.toString(), tbScreeningModel);

      updateCaseBox(
          model: null,
          tbModel: tbScreeningModel,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: null);
      log('TB Data Box Contains:${tbdatabox.values.toList().toString()}');
      log('Updating data to local Server because network is available while trying to update in Local${tbScreeningModel.toString()}');
      if (hasInternet) {
        await pushPendingReferralDetails();
      }
      return tbdatabox.getAt(existingModelIndex)!;
    }
    if (hasInternet) {
      await pushPendingReferralDetails();
    }
    final request = NetworkRequest(
      '$tbScreeningUrl${id == null ? '' : '/$id'}',
      id == null ? RequestMethod.post : RequestMethod.patch,
      isAuthorized: true,
      data: {
        ...tbScreeningModel.toJson(),
        'case_id': caseId ?? AuthCubit.instance.workingCaseId,
      },
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final savedModel = TBScreeningModel.fromJson(result.data['data']);

      await tbdatabox.put(savedModel.id.toString(), savedModel);

      updateCaseBox(
          model: null,
          tbModel: savedModel,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: null);
      log('TB Data Box Contains:${tbdatabox.values.toList().toString()}');

      return savedModel;
    } else {
      if (result.error != null && result.error?.type is NetworkError) {
        final modelsList = tbdatabox.values.toList();
        TBScreeningModel updateModel =
            tbScreeningModel.copyWith(caseId: caseId);

        final existingModelIndex = modelsList.indexWhere(
          (model) => id != null && model.id == id,
        );

        if (existingModelIndex != -1) {
          await tbdatabox.put(updateModel.id.toString(), updateModel);

          // DjangoflowAppSnackbar.showInfo('Updated data Locally');
          updateCaseBox(
              model: null,
              tbModel: updateModel,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: null);
          log('TB Data Box Contains:${modelsList.toString()}');

          return updateModel;
        } else {
          final modelToSave = updateModel.copyWith(
              id: caseId ?? AuthCubit.instance.workingCaseId,
              caseId: caseId ?? AuthCubit.instance.workingCaseId,
              isFormIDAssigned: false);

          // Save the new model to Hive
          await tbdatabox.put(modelToSave.id.toString(), modelToSave);
          updateCaseBox(
              model: null,
              tbModel: modelToSave,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: null);

          // DjangoflowAppSnackbar.showInfo('Stored data Locally');
          log('TB Data Box Contains:${tbdatabox.values.toList().toString()}');

          return modelToSave;
        }
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<MentalHealthScreeningModel> saveWHOSRQData(
      {required MentalHealthScreeningModel mentalHealthScreeningModel,
      required WHOSrqModel? whoSrqModel,
      required WHOSrqModel? ipfuWhoSrqModel,
      required WHOSrqModel? cpWhoSrqModel,
      required int? id,
      required int? caseId}) async {
    Box<MentalHealthScreeningModel> whodatabox =
        Hive.box<MentalHealthScreeningModel>('mentalHealthScreeningModel');
    final existingModelIndex =
        whodatabox.values.toList().indexWhere((model) => model.id == id);

    bool hasInternet = await InternetConnection().hasInternetAccess;

    if ((mentalHealthScreeningModel.isFormIDAssigned == null ||
            mentalHealthScreeningModel.isFormIDAssigned == false) &&
        hasInternet &&
        existingModelIndex != -1) {
      await whodatabox.put(
          mentalHealthScreeningModel.id.toString(), mentalHealthScreeningModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: null);
      log('Mental Health Screening Data Box Contains:${whodatabox.values.toList().toString()}');
      log('Updating data to local Server because network is available while trying to update in Local${mentalHealthScreeningModel.toString()}');
      if (hasInternet) {
        await pushPendingReferralDetails();
      }
      return whodatabox.getAt(existingModelIndex)!;
    }
    if (hasInternet) {
      await pushPendingReferralDetails();
    }

    final request = NetworkRequest(
      '$whoSrqUrl${id == null ? '' : '/$id'}',
      id == null ? RequestMethod.post : RequestMethod.patch,
      isAuthorized: true,
      data: {
        ...mentalHealthScreeningModel.toJson(),
        if (whoSrqModel != null) ...whoSrqModel.toJson(),
        if (ipfuWhoSrqModel != null) ...ipfuWhoSrqModel.toJson(),
        if (cpWhoSrqModel != null) ...cpWhoSrqModel.toJson(),
        'case_id': caseId ?? AuthCubit.instance.workingCaseId,
      },
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final savedModel =
          MentalHealthScreeningModel.fromJson(result.data['data']);
      await whodatabox.put(savedModel.id.toString(), savedModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: savedModel,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: null);
      log('Mental Health Screening Data Box Contains:${whodatabox.values.toList().toString()}');

      return savedModel;
    } else {
      if (result.error != null && result.error?.type is NetworkError) {
        final modelsList = whodatabox.values.toList();
        MentalHealthScreeningModel updateModel =
            mentalHealthScreeningModel.copyWith(caseId: caseId);

        final existingModelIndex = modelsList.indexWhere(
          (model) => id != null && model.id == id,
        );

        if (existingModelIndex != -1) {
          await whodatabox.put(updateModel.id.toString(), updateModel);

          // DjangoflowAppSnackbar.showInfo('Updated data Locally');
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: updateModel,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: null);
          log('MentalHealthScreening Data Box Contains:${modelsList.toString()}');

          return updateModel;
        } else {
          final modelToSave = updateModel.copyWith(
              id: caseId ?? AuthCubit.instance.workingCaseId,
              caseId: caseId ?? AuthCubit.instance.workingCaseId,
              isFormIDAssigned: false);

          // Save the new model to Hive
          await whodatabox.put(modelToSave.id.toString(), modelToSave);
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: modelToSave,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: null);

          // DjangoflowAppSnackbar.showInfo('Stored data Locally');
          log('Mental Health Data Box Contains:${whodatabox.values.toList().toString()}');

          return modelToSave;
        }
      } else {
        throw ApplicationError(
          errorMsg: 'Error Submitting data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<DiagnosisModel> saveDiagnosisData(
      {required DiagnosisModel diagnosisModel,
      required int? id,
      required int? caseId}) async {
    Box<DiagnosisModel> diagnosisDataBox =
        Hive.box<DiagnosisModel>('diagnosisModel');
    final existingModelIndex =
        diagnosisDataBox.values.toList().indexWhere((model) => model.id == id);

    bool hasInternet = await InternetConnection().hasInternetAccess;

    if ((diagnosisModel.isFormIDAssigned == null ||
            diagnosisModel.isFormIDAssigned == false) &&
        hasInternet &&
        existingModelIndex != -1) {
      await diagnosisDataBox.put(diagnosisModel.id.toString(), diagnosisModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: diagnosisModel,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: null);
      log('Diagnosis DataBox Contains:${diagnosisDataBox.values.toList().toString()}');
      log('Updating data to local Server because network is available while trying to update in Local${diagnosisModel.toString()}');
      if (hasInternet) {
        await pushPendingReferralDetails();
      }
      return diagnosisDataBox.getAt(existingModelIndex)!;
    }
    if (hasInternet) {
      await pushPendingReferralDetails();
    }
    final request = NetworkRequest(
      '$diagnosisUrl${id == null ? '' : '/$id'}',
      id == null ? RequestMethod.post : RequestMethod.patch,
      isAuthorized: true,
      data: {
        ...diagnosisModel.toJson(),
        'case_id': caseId ?? AuthCubit.instance.workingCaseId,
      },
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final savedModel = DiagnosisModel.fromJson(result.data['data']);

      await diagnosisDataBox.put(savedModel.id.toString(), savedModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: savedModel,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: null);
      log('Diagnosis DataBox Contains:${diagnosisDataBox.values.toList().toString()}');

      return savedModel;
    } else {
      if (result.error != null && result.error?.type is NetworkError) {
        final modelsList = diagnosisDataBox.values.toList();
        DiagnosisModel updateModel = diagnosisModel.copyWith(caseId: caseId);

        final existingModelIndex = modelsList.indexWhere(
          (model) => id != null && model.id == id,
        );

        if (existingModelIndex != -1) {
          await diagnosisDataBox.put(updateModel.id.toString(), updateModel);

          // DjangoflowAppSnackbar.showInfo('Updated data Locally');
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: updateModel,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: null);
          log('Diagnosis DataBox Contains:${modelsList.toString()}');

          return updateModel;
        } else {
          final modelToSave = updateModel.copyWith(
              id: caseId ?? AuthCubit.instance.workingCaseId,
              caseId: caseId ?? AuthCubit.instance.workingCaseId,
              isFormIDAssigned: false);

          // Save the new model to Hive
          await diagnosisDataBox.put(modelToSave.id.toString(), modelToSave);
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: modelToSave,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: null);

          // DjangoflowAppSnackbar.showInfo('Stored data Locally');
          log('Diagnosis DataBox Contains:${diagnosisDataBox.values.toList().toString()}');

          return modelToSave;
        }
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<TreatmentModel> saveTreatmentData(
      {required TreatmentModel treatmentModel,
      required int? id,
      required int? caseId}) async {
    Box<TreatmentModel> treatmentDataBox =
        Hive.box<TreatmentModel>('treatmentModel');
    final existingModelIndex =
        treatmentDataBox.values.toList().indexWhere((model) => model.id == id);

    bool hasInternet = await InternetConnection().hasInternetAccess;

    if ((treatmentModel.isFormIDAssigned == null ||
            treatmentModel.isFormIDAssigned == false) &&
        hasInternet &&
        existingModelIndex != -1) {
      await treatmentDataBox.put(treatmentModel.id.toString(), treatmentModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: treatmentModel,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: null);
      log('Treatment Data Box Contains:${treatmentDataBox.values.toList().toString()}');
      log('Updating data to local Server because network is available while trying to update in Local${treatmentModel.toString()}');
      if (hasInternet) {
        await pushPendingReferralDetails();
      }
      return treatmentDataBox.getAt(existingModelIndex)!;
    }
    if (hasInternet) {
      await pushPendingReferralDetails();
    }
    final request = NetworkRequest(
      '$treatmentUrl${id == null ? '' : '/$id'}',
      id == null ? RequestMethod.post : RequestMethod.patch,
      isAuthorized: true,
      data: {
        ...treatmentModel.toJson(),
        'case_id': caseId ?? AuthCubit.instance.workingCaseId,
      },
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final savedModel = TreatmentModel.fromJson(result.data['data']);

      await treatmentDataBox.put(savedModel.id.toString(), savedModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: savedModel,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: null);
      log('Treatment Data Box Contains:${treatmentDataBox.values.toList().toString()}');

      return savedModel;
    } else {
      if (result.error != null && result.error?.type is NetworkError) {
        final modelsList = treatmentDataBox.values.toList();
        TreatmentModel updateModel = treatmentModel.copyWith(caseId: caseId);

        final existingModelIndex = modelsList.indexWhere(
          (model) => id != null && model.id == id,
        );

        if (existingModelIndex != -1) {
          await treatmentDataBox.put(updateModel.id.toString(), updateModel);

          // DjangoflowAppSnackbar.showInfo('Updated data Locally');
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: updateModel,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: null);
          log('Treatment Data Box Contains:${modelsList.toString()}');

          return updateModel;
        } else {
          final modelToSave = updateModel.copyWith(
              id: caseId ?? AuthCubit.instance.workingCaseId,
              caseId: caseId ?? AuthCubit.instance.workingCaseId,
              isFormIDAssigned: false);

          // Save the new model to Hive
          await treatmentDataBox.put(modelToSave.id.toString(), modelToSave);
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: modelToSave,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: null);

          // DjangoflowAppSnackbar.showInfo('Stored data Locally');
          log('TreatmentData Box Contains:${treatmentDataBox.values.toList().toString()}');

          return modelToSave;
        }
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<ContactTracingModel> saveContactTracingData(
      {required ContactTracingModel contactTracingModel,
      required int? id,
      required int? caseId}) async {
    Box<ContactTracingModel> contactTracingDataBox =
        Hive.box<ContactTracingModel>('contactTracingModel');
    final existingModelIndex = contactTracingDataBox.values
        .toList()
        .indexWhere((model) => model.id == id);

    bool hasInternet = await InternetConnection().hasInternetAccess;

    if ((contactTracingModel.isFormIDAssigned == null ||
            contactTracingModel.isFormIDAssigned == false) &&
        hasInternet &&
        existingModelIndex != -1) {
      await contactTracingDataBox.put(
          contactTracingModel.id.toString(), contactTracingModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: contactTracingModel,
          outcomeModel: null,
          faqCheckListModel: null);
      log('Contact Tracing Data Box Contains:${contactTracingDataBox.values.toList().toString()}');
      log('Updating data to local Server because network is available while trying to update in Local${contactTracingModel.toString()}');
      if (hasInternet) {
        await pushPendingReferralDetails();
      }
      return contactTracingDataBox.getAt(existingModelIndex)!;
    }
    if (hasInternet) {
      await pushPendingReferralDetails();
    }
    final request = NetworkRequest(
      '$contactTracingUrl${id == null ? '' : '/$id'}',
      id == null ? RequestMethod.post : RequestMethod.patch,
      isAuthorized: true,
      data: {
        ...contactTracingModel.toJson(),
        'case_id': caseId ?? AuthCubit.instance.workingCaseId,
      },
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final savedModel = ContactTracingModel.fromJson(result.data['data']);

      await contactTracingDataBox.put(savedModel.id.toString(), savedModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: savedModel,
          outcomeModel: null,
          faqCheckListModel: null);
      log('Contact Tracing Data Box Contains:${contactTracingDataBox.values.toList().toString()}');

      return savedModel;
    } else {
      if (result.error != null && result.error?.type is NetworkError) {
        final modelsList = contactTracingDataBox.values.toList();
        ContactTracingModel updateModel =
            contactTracingModel.copyWith(caseId: caseId);

        final existingModelIndex = modelsList.indexWhere(
          (model) => id != null && model.id == id,
        );

        if (existingModelIndex != -1) {
          await contactTracingDataBox.putAt(existingModelIndex, updateModel);

          // DjangoflowAppSnackbar.showInfo('Updated data Locally');
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: updateModel,
              outcomeModel: null,
              faqCheckListModel: null);
          log('Contact Tracing Data Box Contains:${modelsList.toString()}');

          return updateModel;
        } else {
          ///Assigning new id for evey new model
          await CounterManager.instance.initialize();
          int counter = await CounterManager.instance.getNextCounter();
          final userMobilePrefix =
              AuthCubit.instance.state.user!.mobileNumber.substring(0, 5);
          final modelToSave = updateModel.copyWith(
              id: int.tryParse('$userMobilePrefix$counter'),
              caseId: caseId ?? AuthCubit.instance.workingCaseId,
              isFormIDAssigned: false);

          // Save the new model to Hive
          await contactTracingDataBox.put(
              modelToSave.id.toString(), modelToSave);
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: modelToSave,
              outcomeModel: null,
              faqCheckListModel: null);

          // DjangoflowAppSnackbar.showInfo('Stored data Locally');
          log('Contact Tracing Data Box Contains:${contactTracingDataBox.values.toList().toString()}');

          return modelToSave;
        }
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<OutcomeModel> saveOutcomeData(
      {required OutcomeModel outcomeModel,
      required int? id,
      required int? caseId}) async {
    Box<OutcomeModel> outcomeDataBox = Hive.box<OutcomeModel>('outcomeModel');
    final existingModelIndex =
        outcomeDataBox.values.toList().indexWhere((model) => model.id == id);

    bool hasInternet = await InternetConnection().hasInternetAccess;

    if ((outcomeModel.isFormIDAssigned == null ||
            outcomeModel.isFormIDAssigned == false) &&
        hasInternet &&
        existingModelIndex != -1) {
      await outcomeDataBox.put(outcomeModel.id.toString(), outcomeModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: outcomeModel,
          faqCheckListModel: null);
      log('Outcome Data Box Contains:${outcomeDataBox.values.toList().toString()}');
      log('Updating data to local Server because network is available while trying to update in Local${outcomeModel.toString()}');
      if (hasInternet) {
        await pushPendingReferralDetails();
      }
      return outcomeDataBox.getAt(existingModelIndex)!;
    }
    if (hasInternet) {
      await pushPendingReferralDetails();
    }
    final request = NetworkRequest(
      '$outcomeUrl${id == null ? '' : '/$id'}',
      id == null ? RequestMethod.post : RequestMethod.patch,
      isAuthorized: true,
      data: {
        ...outcomeModel.toJson(),
        'case_id': caseId ?? AuthCubit.instance.workingCaseId,
      },
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final savedModel = OutcomeModel.fromJson(result.data['data']);

      await outcomeDataBox.put(savedModel.id.toString(), savedModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: savedModel,
          faqCheckListModel: null);
      log('Outcome Data Box Contains:${outcomeDataBox.values.toList().toString()}');

      return savedModel;
    } else {
      if (result.error != null && result.error?.type is NetworkError) {
        final modelsList = outcomeDataBox.values.toList();
        OutcomeModel updateModel = outcomeModel.copyWith(caseId: caseId);

        final existingModelIndex = modelsList.indexWhere(
          (model) => id != null && model.id == id,
        );

        if (existingModelIndex != -1) {
          await outcomeDataBox.put(updateModel.id.toString(), updateModel);

          // DjangoflowAppSnackbar.showInfo('Updated data Locally');
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: updateModel,
              faqCheckListModel: null);
          log('Outcome Data Box Contains:${modelsList.toString()}');

          return updateModel;
        } else {
          final modelToSave = updateModel.copyWith(
              id: caseId ?? AuthCubit.instance.workingCaseId,
              caseId: caseId ?? AuthCubit.instance.workingCaseId,
              isFormIDAssigned: false);

          // Save the new model to Hive
          await outcomeDataBox.put(modelToSave.id.toString(), modelToSave);
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: modelToSave,
              faqCheckListModel: null);

          // DjangoflowAppSnackbar.showInfo('Stored data Locally');
          log('Outcome Data Box Contains:${outcomeDataBox.values.toList().toString()}');

          return modelToSave;
        }
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<FaqChecklistModel> saveFaqChecklistData(
      {required FaqChecklistModel model,
      required int? id,
      required int? caseId}) async {
    Box<FaqChecklistModel> faqChecklistDataBox =
        Hive.box<FaqChecklistModel>('faqChecklistModel');
    final existingModelIndex = faqChecklistDataBox.values
        .toList()
        .indexWhere((model) => model.id == id);

    bool hasInternet = await InternetConnection().hasInternetAccess;

    if ((model.isFormIdAssigned == null || model.isFormIdAssigned == false) &&
        hasInternet &&
        existingModelIndex != -1) {
      await faqChecklistDataBox.put(model.id.toString(), model);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: model);
      log('FaqChecklist Data Box Contains:${faqChecklistDataBox.values.toList().toString()}');
      log('Updating data to local Server because network is available while trying to update in Local${model.toString()}');
      if (hasInternet) {
        await pushPendingReferralDetails();
      }
      return faqChecklistDataBox.getAt(existingModelIndex)!;
    }
    if (hasInternet) {
      await pushPendingReferralDetails();
    }
    final request = NetworkRequest(
      '$faqUrl${id == null ? '' : '/$id'}',
      id == null ? RequestMethod.post : RequestMethod.patch,
      isAuthorized: true,
      data: {
        ...model.toJson(),
        'case_id': caseId ?? AuthCubit.instance.workingCaseId,
      },
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final savedModel = FaqChecklistModel.fromJson(result.data['data']);

      await faqChecklistDataBox.put(savedModel.id.toString(), savedModel);

      updateCaseBox(
          model: null,
          tbModel: null,
          caseModel: null,
          mentalHealthScreeningModel: null,
          diagnosisModel: null,
          treatmentModel: null,
          contactTracingModel: null,
          outcomeModel: null,
          faqCheckListModel: savedModel);
      log('FaqChecklist Data Box Contains:${faqChecklistDataBox.values.toList().toString()}');

      return savedModel;
    } else {
      if (result.error != null && result.error?.type is NetworkError) {
        final modelsList = faqChecklistDataBox.values.toList();
        FaqChecklistModel updateModel = model.copyWith(caseId: caseId);

        final existingModelIndex = modelsList.indexWhere(
          (model) => id != null && model.id == id,
        );

        if (existingModelIndex != -1) {
          await faqChecklistDataBox.put(updateModel.id.toString(), updateModel);

          // DjangoflowAppSnackbar.showInfo('Updated data Locally');
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: updateModel);
          log('FaqChecklist Data Box Contains:${modelsList.toString()}');

          return updateModel;
        } else {
          final modelToSave = updateModel.copyWith(
              id: caseId ?? AuthCubit.instance.workingCaseId,
              caseId: caseId ?? AuthCubit.instance.workingCaseId,
              isFormIdAssigned: false);

          // Save the new model to Hive
          await faqChecklistDataBox.put(modelToSave.id.toString(), modelToSave);
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: null,
              outcomeModel: null,
              faqCheckListModel: modelToSave);

          // DjangoflowAppSnackbar.showInfo('Stored data Locally');
          log('FaqChecklist Data Box Contains:${faqChecklistDataBox.values.toList().toString()}');

          return modelToSave;
        }
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<Case?> getCaseModel({
    required int? caseId,
  }) async {
    Box<Case> dataBox = Hive.box<Case>('caseList');

    final request = NetworkRequest(
      '$getSingleCaseUrl/$caseId',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final newCase = Case.fromJson(result.data['data']);
      final existingCaseIndex = dataBox.values
          .toList()
          .indexWhere((existingCase) => existingCase.id == newCase.id);
      if (existingCaseIndex != -1) {
        log('Updating Server Case Model=======================${newCase.toString()}');

        dataBox.putAt(existingCaseIndex, newCase);
      } else {
        log('Creating Server Case Model=======================${newCase.toString()}');
        dataBox.add(newCase);
      }
      return newCase;
    } else {
      if (result.error != null && result.error?.type is NetworkError) {
        final existingCase = dataBox.get(dataBox.keyAt(dataBox.values
            .toList()
            .indexWhere((existingCase) => existingCase.id == caseId)));
        if (existingCase != null) {
          log('Getting Case Model=======================${existingCase.toString()}');

          return existingCase;
        } else {
          throw ApplicationError(
            errorMsg: 'Error Retrieving data',
            type: Unauthorized(),
          );
        }
      } else {
        throw ApplicationError(
          errorMsg: 'Error Retrieving data',
          type: Unauthorized(),
        );
      }
    }
  }

  Future<ReferralDetailsModel> getReferralDetails({
    required int? id,
  }) async {
    Box<ReferralDetailsModel> dataBox =
        Hive.box<ReferralDetailsModel>('referralDetailsModel');
    log(' ReferralModel Box Contains======================${dataBox.values.toList()}'
        .toString());

    final request = NetworkRequest(
      '$referralDetailsUrl/$id',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);

    if (result.status == Status.ok) {
      return ReferralDetailsModel.fromJson(result.data['data']);
    } else if (result.error != null && result.error?.type is NetworkError) {
      log(dataBox.values.toString());
      final model = dataBox.get(dataBox.keyAt(dataBox.values
          .toList()
          .indexWhere((existingCase) => existingCase.id == id)));
      if (model != null) {
        log('Retrieving ReferralModel======================$model'.toString());

        return model;
      } else {
        throw ApplicationError(
          errorMsg: 'Error Retrieving Referral Form data',
          type: Unauthorized(),
        );
      }
    } else {
      throw ApplicationError(
        errorMsg: 'Error Retrieving Referral Form data',
        type: Unauthorized(),
      );
    }
  }

  Future<TBScreeningModel> getTBScreening({
    required int? id,
  }) async {
    Box<TBScreeningModel> tbdataBox =
        Hive.box<TBScreeningModel>('tbScreeningModel');
    log(' TBScreening Box Contains======================${tbdataBox.values.toList()}'
        .toString());
    final request = NetworkRequest(
      '$tbScreeningUrl/$id',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      return TBScreeningModel.fromJson(result.data['data']);
    } else if (result.error != null && result.error?.type is NetworkError) {
      log(tbdataBox.values.toString());
      final model = tbdataBox.get(tbdataBox.keyAt(tbdataBox.values
          .toList()
          .indexWhere((existingCase) => existingCase.id == id)));
      if (model != null) {
        log('Retrieving TB Screening Model======================$model'
            .toString());

        return model;
      } else {
        throw ApplicationError(
          errorMsg: 'Error Retrieving TB Screening Form data',
          type: Unauthorized(),
        );
      }
    } else {
      throw ApplicationError(
        errorMsg: 'Error Retrieving TB Screening Form data',
        type: Unauthorized(),
      );
    }
  }

  Future<MentalHealthScreeningModel> getWhoSrq({
    required int? id,
  }) async {
    Box<MentalHealthScreeningModel> whodatabox =
        Hive.box<MentalHealthScreeningModel>('mentalHealthScreeningModel');
    log(' Mental Health Screening Box Contains======================${whodatabox.values.toList()}'
        .toString());
    final request = NetworkRequest(
      '$whoSrqUrl/$id',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      return MentalHealthScreeningModel.fromJson(result.data['data']);
    } else if (result.error != null && result.error?.type is NetworkError) {
      log(whodatabox.values.toString());
      final model = whodatabox.get(whodatabox.keyAt(whodatabox.values
          .toList()
          .indexWhere((existingCase) => existingCase.id == id)));
      if (model != null) {
        log('Retrieving Mental Health Screening Model======================$model'
            .toString());

        return model;
      } else {
        throw ApplicationError(
          errorMsg: 'Error Retrieving Mental Health Screening Form data',
          type: Unauthorized(),
        );
      }
    } else {
      throw ApplicationError(
        errorMsg: 'Error Retrieving Mental Health Screening Form data',
        type: Unauthorized(),
      );
    }
  }

  Future<DiagnosisModel> getDiagnosis({
    required int? id,
  }) async {
    Box<DiagnosisModel> diagnosisDataBox =
        Hive.box<DiagnosisModel>('diagnosisModel');
    log('Diagnosis Box Contains======================${diagnosisDataBox.values.toList()}'
        .toString());
    final request = NetworkRequest(
      '$diagnosisUrl/$id',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok && result.data['data'] != null) {
      return DiagnosisModel.fromJson(result.data['data']);
    } else if (result.error != null && result.error?.type is NetworkError) {
      log(diagnosisDataBox.values.toString());
      final model = diagnosisDataBox.get(diagnosisDataBox.keyAt(diagnosisDataBox
          .values
          .toList()
          .indexWhere((existingCase) => existingCase.id == id)));
      if (model != null) {
        log('Retrieving Diagnosis Model======================$model'
            .toString());

        return model;
      } else {
        throw ApplicationError(
          errorMsg: 'Error Retrieving Diagnosis Form data',
          type: Unauthorized(),
        );
      }
    } else {
      throw ApplicationError(
        errorMsg: 'Error Retrieving Diagnosis Form data',
        type: Unauthorized(),
      );
    }
  }

  Future<TreatmentModel> getTreatment({
    required int? id,
  }) async {
    Box<TreatmentModel> treatmentDataBox =
        Hive.box<TreatmentModel>('treatmentModel');
    log(' Treatment Box Contains======================${treatmentDataBox.values.toList()}'
        .toString());
    final request = NetworkRequest(
      '$treatmentUrl/$id',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      return TreatmentModel.fromJson(result.data['data']);
    } else if (result.error != null && result.error?.type is NetworkError) {
      log(treatmentDataBox.values.toString());
      final model = treatmentDataBox.get(treatmentDataBox.keyAt(treatmentDataBox
          .values
          .toList()
          .indexWhere((existingCase) => existingCase.id == id)));
      if (model != null) {
        log('Retrieving Treatment Model======================$model'
            .toString());

        return model;
      } else {
        throw ApplicationError(
          errorMsg: 'Error Retrieving Treatment Form data',
          type: Unauthorized(),
        );
      }
    } else {
      throw ApplicationError(
        errorMsg: 'Error Retrieving Treatment Form data',
        type: Unauthorized(),
      );
    }
  }

  Future<OutcomeModel> getOutcome({
    required int? id,
  }) async {
    Box<OutcomeModel> outcomeDataBox = Hive.box<OutcomeModel>('outcomeModel');
    log(' Outcome Box Contains======================${outcomeDataBox.values.toList()}'
        .toString());
    final request = NetworkRequest(
      '$outcomeUrl/$id',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      return OutcomeModel.fromJson(result.data['data']);
    } else if (result.error != null && result.error?.type is NetworkError) {
      log(outcomeDataBox.values.toString());
      final model = outcomeDataBox.get(outcomeDataBox.keyAt(outcomeDataBox
          .values
          .toList()
          .indexWhere((existingCase) => existingCase.id == id)));
      if (model != null) {
        log('Retrieving Outcome Model======================$model'.toString());

        return model;
      } else {
        throw ApplicationError(
          errorMsg: 'Error Retrieving Outcome Form data',
          type: Unauthorized(),
        );
      }
    } else {
      throw ApplicationError(
        errorMsg: 'Error Retrieving Outcome Form data',
        type: Unauthorized(),
      );
    }
  }

  Future<FaqChecklistModel> getFaqChecklist({
    required int? id,
  }) async {
    log('ID======================$id'.toString());

    Box<FaqChecklistModel> faqDataBox =
        Hive.box<FaqChecklistModel>('faqCheckListModel');
    log(' FaqCheckList Box Contains======================${faqDataBox.values.toList()}'
        .toString());
    final request = NetworkRequest(
      '$faqUrl/$id',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      return FaqChecklistModel.fromJson(result.data['data']);
    } else if (result.error != null && result.error?.type is NetworkError) {
      log(faqDataBox.values.toString());
      final model = faqDataBox.get(faqDataBox.keyAt(faqDataBox.values
          .toList()
          .indexWhere((existingCase) => existingCase.id == id)));
      if (model != null) {
        log('Retrieving FaqChecklist Model======================$model'
            .toString());

        return model;
      } else {
        throw ApplicationError(
          errorMsg: 'Error Retrieving Outcome Form data',
          type: Unauthorized(),
        );
      }
    } else {
      throw ApplicationError(
        errorMsg: 'Error Retrieving Outcome Form data',
        type: Unauthorized(),
      );
    }
  }

  Future<List<ContactTracingModel>> getContactTracingList({
    required int? caseId,
  }) async {
    Box<ContactTracingModel> contactTracingDataBox =
        Hive.box<ContactTracingModel>('contactTracingModel');
    final request = NetworkRequest(
      '$contactTracingListUrl/$caseId',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final List<dynamic> contactData = result.data['data'];
      final List<ContactTracingModel> contactDataList = contactData
          .map<ContactTracingModel>((e) => ContactTracingModel.fromJson(e))
          .toList();
      contactDataList.sort((a, b) => b.id!.compareTo(a.id!));
      // Iterate through the cases fetched from the network
      for (final contact in contactDataList) {
        // Check if the case with the same ID already exists in the Hive box
        final existingCaseIndex = contactTracingDataBox.values
            .toList()
            .indexWhere((existingCase) => existingCase.id == contact.id);
        if (existingCaseIndex != -1) {
          // If case with the same ID exists, update it
          contactTracingDataBox.putAt(existingCaseIndex, contact);
        } else {
          // If case with the same ID doesn't exist, add it
          contactTracingDataBox.add(contact);
        }
      }

      return contactDataList;
    } else {
      final List<ContactTracingModel> storedData =
          contactTracingDataBox.values.toList();

      if (result.error != null && result.error?.type is NetworkError) {
        final caseIdToFilter = caseId ?? AuthCubit.instance.workingCaseId;

        // Filter the stored data based on the caseId
        final filteredData = storedData
            .where((model) => model.caseId == caseIdToFilter)
            .toList();

        return filteredData.reversed.toList();
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching Contact Tracing List data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<ContactTracingModel> getContactTracing({
    required int? id,
  }) async {
    Box<ContactTracingModel> contactTracingDataBox =
        Hive.box<ContactTracingModel>('contactTracingModel');
    log(' Contact Tracing Box Contains======================${contactTracingDataBox.values.toList()}'
        .toString());
    final request = NetworkRequest(
      '$contactTracingUrl/$id',
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final newModel = ContactTracingModel.fromJson(result.data['data']);
      final existingCaseIndex = contactTracingDataBox.values
          .toList()
          .indexWhere((existingCase) => existingCase.id == newModel.id);
      if (existingCaseIndex != -1) {
        log('Updating Server ContactTracing Model=======================${newModel.toString()}');

        contactTracingDataBox.putAt(existingCaseIndex, newModel);
      } else {
        log('Creating Server Contact Tracing Model=======================${newModel.toString()}');
        contactTracingDataBox.add(newModel);
      }
      return newModel;
    } else if (result.error != null && result.error?.type is NetworkError) {
      log(contactTracingDataBox.values.toString());
      final model = contactTracingDataBox.get(contactTracingDataBox.keyAt(
          contactTracingDataBox.values
              .toList()
              .indexWhere((existingCase) => existingCase.id == id)));
      if (model != null) {
        log('Retrieving Contact Tracing Model======================$model'
            .toString());

        return model;
      } else {
        throw ApplicationError(
          errorMsg: 'Error Retrieving Contact Tracing Form data',
          type: Unauthorized(),
        );
      }
    } else {
      throw ApplicationError(
        errorMsg: 'Error Retrieving Contact Tracing Form data',
        type: Unauthorized(),
      );
    }
  }

  Future<List<Case>> getCasesForHealthWorker() async {
    Box<Case> dataBox = Hive.box<Case>('caseList');

    final request = NetworkRequest(
      '$casesForHealthWorkerUrl${AuthCubit.instance.state.user!.mobileNumber}',
      RequestMethod.get,
      isAuthorized: true,
      data: {
        'logged_in_user': AuthCubit.instance.state.user!.mobileNumber,
      },
    );
    final result = await NetworkManager.instance.perform(request);
    if (result.status == Status.ok) {
      final List<dynamic> caseDataList = result.data['data']['cases'];
      final cases = caseDataList.map<Case>((e) => Case.fromJson(e)).toList();

      // Iterate through the cases fetched from the network
      for (final caseItem in cases) {
        // Check if the case with the same ID already exists in the Hive box
        final existingCaseIndex = dataBox.values
            .toList()
            .indexWhere((existingCase) => existingCase.id == caseItem.id);
        if (existingCaseIndex != -1) {
          // If case with the same ID exists, update it
          dataBox.putAt(existingCaseIndex, caseItem);
        } else {
          // If case with the same ID doesn't exist, add it
          dataBox.add(caseItem);
        }
      }

      return dataBox.values.toList();
    } else {
      final List<Case> storedData = dataBox.values.toList();

      if (result.error != null && result.error?.type is NetworkError) {
        return storedData;
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching Case List data',
          type: UnExpected(),
        );
      }
    }
  }

  //Returns whether any referral details were pushed to the server
  Future<bool> pushPendingReferralDetails() async {
    Box<ReferralDetailsModel> dataBox =
        Hive.box<ReferralDetailsModel>('referralDetailsModel');
    // Get all referral details models from the box
    List<ReferralDetailsModel> referralList = dataBox.values.toList();

    int updateCount = 0;

    for (var referral in referralList) {
      final isUpdated = referral.isUpdated ?? false;
      if (!isUpdated) {
        final model = !(referral.isCaseUpdated ?? false)
            ? referral.copyWith(caseId: null, id: null)
            : referral;
        try {
          log('Pushing ReferralModel to the Server:${model.toString()}');
          // Attempt to push the referral details to the server
          final request = NetworkRequest(
            '$referralDetailsUrl${model.id == null ? '' : '/${model.id}'}',
            model.id == null
                //&& (model.referralID != referral.referralID)
                ? RequestMethod.post
                : RequestMethod.patch,
            isAuthorized: true,
            data: {
              ...model.toJson(),
              'logged_in_user': AuthCubit.instance.state.user!.mobileNumber,
            },
          );
          final result = await NetworkManager.instance.perform(request);

          if (result.status == Status.ok) {
            ReferralDetailsModel updatedModel =
                ReferralDetailsModel.fromJson(result.data['data']);
            if ((referral.isCaseUpdated == null) ||
                (referral.isCaseUpdated == false)) {
              // Get the key of the existing model
              final modelIndex = dataBox.values
                  .toList()
                  .indexWhere((existingCase) => existingCase.id == referral.id);
              if (modelIndex != -1) {
                final modelKey = dataBox.keyAt(modelIndex);
                log('Retrieving Referral Model Key: ${dataBox.get(modelKey)}');
                await dataBox.delete(modelKey);
                deleteCaseLocal(referral.caseId);
              }

              // var key =
              //     dataBox.keyAt(dataBox.values.toList().indexOf(referral));
              // // Print the details of the record being deleted
              // // Delete the old model
              // await dataBox.delete(key);
            }
            // Add the new model with the server-assigned ID
            await dataBox.put(updatedModel.id.toString(), updatedModel);

            log('ReferralModel DataBox Contains===========${dataBox.values.toList().toString()}');
            AuthCubit.instance.caseId = result.data['data']['case_id'];
            //getCaseModel(caseId: AuthCubit.instance.workingCaseId);
            updateCaseBox(
                model: updatedModel,
                tbModel: null,
                caseModel: null,
                mentalHealthScreeningModel: null,
                diagnosisModel: null,
                treatmentModel: null,
                contactTracingModel: null,
                outcomeModel: null,
                faqCheckListModel: null);
            // getCaseModel(caseId: updatedModel.caseId);
            DjangoflowAppSnackbar.showInfo(
                'Successfully updated offline referral models');

            await updateTBDataBox(
                referral.id, AuthCubit.instance.workingCaseId);
            await updateWHODataBox(
                referral.id, AuthCubit.instance.workingCaseId);
            await updateDiagnosisDataBox(
                referral.id, AuthCubit.instance.workingCaseId);
            await updateTreatmentDataBox(
                referral.id, AuthCubit.instance.workingCaseId);
            await updateContactTracingDataBox(
                referral.id, AuthCubit.instance.workingCaseId);
            await updateOutcomeDataBox(
                referral.id, AuthCubit.instance.workingCaseId);
            await updateFaqCheckListDataBox(
                referral.id, AuthCubit.instance.workingCaseId);

            // await updateDataBox<TBScreeningModel>(
            //   boxName: 'tbScreeningModel',
            //   modelID: referral.id,
            //   caseId: AuthCubit.instance.workingCaseId,
            //   updateModelCallback: (model, caseId) =>
            //       model.copyWith(caseId: caseId),
            // );

            // await updateDataBox<MentalHealthScreeningModel>(
            //   boxName: 'mentalHealthScreeningModel',
            //   modelID: referral.id,
            //   caseId: AuthCubit.instance.workingCaseId,
            //   updateModelCallback: (model, caseId) =>
            //       model.copyWith(caseId: caseId),
            // );
            updateCount++;
          } else {
            // Handle error if need
            //
            throw Exception(
                'Failed to push referral details from Local Storage');
          }
        } catch (e, stackTrace) {
          log('Error pushing referral details: $e\nStackTrace: $stackTrace');
          continue; // Exit the loop if there's an error
        }
      }
    }
    updateCount += await pushPendingTBScreeningDetails();
    updateCount += await pushPendingWhoSrqDetails();
    updateCount += await pushPendingDiagnosisDetails();
    updateCount += await pushPendingTreatmentDetails();
    updateCount += await pushPendingContactTracingDetails();
    updateCount += await pushPendingOutcomeDetails();
    updateCount += await pushPendingFaqCheckListDetails();

    return updateCount > 0;
  }

  Future<int> pushPendingTBScreeningDetails() async {
    Box<TBScreeningModel> tbdataBox =
        Hive.box<TBScreeningModel>('tbScreeningModel');
    List<TBScreeningModel> tbModelsList = tbdataBox.values.toList();
    int updateCount = 0;
    for (var tbModel in tbModelsList) {
      final isUpdated = tbModel.isUpdated ?? false;
      if (!isUpdated) {
        final model = (tbModel.isFormIDAssigned == null) ||
                (tbModel.isFormIDAssigned == false)
            ? tbModel.copyWith(id: null)
            : tbModel;
        try {
          log('Pushing TBModel to the Server:${model.toString()}');
          // Attempt to push the tbModel details to the server
          final request = NetworkRequest(
            '$tbScreeningUrl${model.id == null ? '' : '/${model.id}'}',
            model.id == null ? RequestMethod.post : RequestMethod.patch,
            isAuthorized: true,
            data: {
              ...model.toJson(),
              'case_id': model.caseId ?? AuthCubit.instance.workingCaseId,
            },
          );
          final result = await NetworkManager.instance.perform(request);
          if (result.status == Status.ok) {
            TBScreeningModel updatedModel =
                TBScreeningModel.fromJson(result.data['data']);
            if ((tbModel.isFormIDAssigned == null) ||
                (tbModel.isFormIDAssigned == false)) {
              // Get the key of the existing model
              var key =
                  tbdataBox.keyAt(tbdataBox.values.toList().indexOf(tbModel));
              // Print the details of the record being deleted
              log('Deleting TBScreening Model: ${tbdataBox.get(key)}');
              // Delete the old model
              await tbdataBox.delete(key);
            }
            // Add the new model with the server-assigned ID
            await tbdataBox.put(updatedModel.id.toString(), updatedModel);
            updateCaseBox(
                model: null,
                tbModel: updatedModel,
                caseModel: null,
                mentalHealthScreeningModel: null,
                diagnosisModel: null,
                treatmentModel: null,
                contactTracingModel: null,
                outcomeModel: null,
                faqCheckListModel: null);
            //getCaseModel(caseId: updatedModel.caseId);
            DjangoflowAppSnackbar.showInfo(
                'Succesfully updated offline TB screening Models');
            updateCount++;
            log('TBScreening DataBox Contains===========${tbdataBox.values.toList().toString()}');
          } else {
            // Handle error if needed
            throw Exception(
                'Failed to push tbModel details from Local Storage');
          }
        } catch (e) {
          // Handle the exception if needed
          log('Error pushing tbModel details: $e');
          continue;
        }
      }
    }
    return updateCount;
  }

  Future<int> pushPendingWhoSrqDetails() async {
    Box<MentalHealthScreeningModel> whodatabox =
        Hive.box<MentalHealthScreeningModel>('mentalHealthScreeningModel');
    List<MentalHealthScreeningModel> whoModelsList = whodatabox.values.toList();
    int updateCount = 0;
    for (var mentalHealthModel in whoModelsList) {
      final isUpdated = mentalHealthModel.isUpdated ?? false;

      if (!isUpdated) {
        final model = (mentalHealthModel.isFormIDAssigned == null) ||
                (mentalHealthModel.isFormIDAssigned == false)
            ? mentalHealthModel.copyWith(id: null)
            : mentalHealthModel;
        try {
          log('Pushing MentalHealthScreening Model to the Server:${model.toString()}');
          // Attempt to push the tbModel details to the server
          final request = NetworkRequest(
            '$whoSrqUrl${model.id == null ? '' : '/${model.id}'}',
            model.id == null ? RequestMethod.post : RequestMethod.patch,
            isAuthorized: true,
            data: {
              ...model.toJson(),
              'case_id': model.caseId ?? AuthCubit.instance.workingCaseId,
            },
          );
          final result = await NetworkManager.instance.perform(request);
          if (result.status == Status.ok) {
            MentalHealthScreeningModel updatedModel =
                MentalHealthScreeningModel.fromJson(result.data['data']);
            if ((mentalHealthModel.isFormIDAssigned == null) ||
                (mentalHealthModel.isFormIDAssigned == false)) {
              // Get the key of the existing model
              var key = whodatabox
                  .keyAt(whodatabox.values.toList().indexOf(mentalHealthModel));
              // Print the details of the record being deleted
              log('Deleting MentalHealthScreening Model: ${whodatabox.get(key)}');
              // Delete the old model
              await whodatabox.delete(key);
            }
            // Add the new model with the server-assigned ID
            await whodatabox.put(updatedModel.id.toString(), updatedModel);
            updateCaseBox(
                model: null,
                tbModel: null,
                caseModel: null,
                mentalHealthScreeningModel: updatedModel,
                diagnosisModel: null,
                treatmentModel: null,
                contactTracingModel: null,
                outcomeModel: null,
                faqCheckListModel: null);
            //getCaseModel(caseId: updatedModel.caseId);
            DjangoflowAppSnackbar.showInfo(
                'Succesfully updated offline Mental Health Screening Models');
            log('MentalHealthScreening DataBox Contains===========${whodatabox.values.toList().toString()}');
            updateCount++;
          } else {
            // Handle error if needed
            throw Exception(
                'Failed to push Mental Health details from Local Storage');
          }
        } catch (e) {
          // Handle the exception if needed
          log('Error pushing Mental Health details: $e');
          continue;
        }
      }
    }
    return updateCount;
  }

  Future<int> pushPendingDiagnosisDetails() async {
    Box<DiagnosisModel> diagnosisDataBox =
        Hive.box<DiagnosisModel>('diagnosisModel');
    List<DiagnosisModel> diagnosisModelsList = diagnosisDataBox.values.toList();
    int updateCount = 0;
    for (var diagnosisModel in diagnosisModelsList) {
      final isUpdated = diagnosisModel.isUpdated ?? false;
      if (!isUpdated) {
        final model = (diagnosisModel.isFormIDAssigned == null) ||
                (diagnosisModel.isFormIDAssigned == false)
            ? diagnosisModel.copyWith(id: null)
            : diagnosisModel;
        try {
          log('Pushing Diagnosis Model to the Server:${model.toString()}');
          // Attempt to push the tbModel details to the server
          final request = NetworkRequest(
            '$diagnosisUrl${model.id == null ? '' : '/${model.id}'}',
            model.id == null ? RequestMethod.post : RequestMethod.patch,
            isAuthorized: true,
            data: {
              ...diagnosisModel.toJson(),
              'case_id': model.caseId ?? AuthCubit.instance.workingCaseId,
            },
          );
          final result = await NetworkManager.instance.perform(request);
          if (result.status == Status.ok) {
            DiagnosisModel updatedModel =
                DiagnosisModel.fromJson(result.data['data']);
            if ((diagnosisModel.isFormIDAssigned == null) ||
                (diagnosisModel.isFormIDAssigned == false)) {
              // Get the key of the existing model
              var key = diagnosisDataBox.keyAt(
                  diagnosisDataBox.values.toList().indexOf(diagnosisModel));
              // Print the details of the record being deleted
              log('Deleting Diagnosis Model: ${diagnosisDataBox.get(key)}');
              // Delete the old model
              await diagnosisDataBox.delete(key);
            }
            // Add the new model with the server-assigned ID
            await diagnosisDataBox.put(
                updatedModel.id.toString(), updatedModel);
            updateCaseBox(
                model: null,
                tbModel: null,
                caseModel: null,
                mentalHealthScreeningModel: null,
                diagnosisModel: updatedModel,
                treatmentModel: null,
                contactTracingModel: null,
                outcomeModel: null,
                faqCheckListModel: null);
            //getCaseModel(caseId: updatedModel.caseId);
            DjangoflowAppSnackbar.showInfo(
                'Succesfully updated offline Diagnosis Models');
            log('Diagnosis DataBox Contains===========${diagnosisDataBox.values.toList().toString()}');
            updateCount++;
          } else {
            // Handle error if needed
            throw Exception(
                'Failed to push Diagnosis Details from Local Storage');
          }
        } catch (e) {
          // Handle the exception if needed
          log('Error pushing Diagnosis details: $e');
          continue;
        }
      }
    }
    return updateCount;
  }

  Future<int> pushPendingTreatmentDetails() async {
    Box<TreatmentModel> treatmentDataBox =
        Hive.box<TreatmentModel>('treatmentModel');
    List<TreatmentModel> treatmentModelsList = treatmentDataBox.values.toList();
    int updateCount = 0;
    for (var treatmentModel in treatmentModelsList) {
      final isUpdated = treatmentModel.isUpdated ?? false;
      if (!isUpdated) {
        final model = (treatmentModel.isFormIDAssigned == null) ||
                (treatmentModel.isFormIDAssigned == false)
            ? treatmentModel.copyWith(id: null)
            : treatmentModel;
        try {
          log('Pushing Treatment Model to the Server:${model.toString()}');
          // Attempt to push the tbModel details to the server
          final request = NetworkRequest(
            '$treatmentUrl${model.id == null ? '' : '/${model.id}'}',
            model.id == null ? RequestMethod.post : RequestMethod.patch,
            isAuthorized: true,
            data: {
              ...treatmentModel.toJson(),
              'case_id': model.caseId ?? AuthCubit.instance.workingCaseId,
            },
          );
          final result = await NetworkManager.instance.perform(request);
          if (result.status == Status.ok) {
            TreatmentModel updatedModel =
                TreatmentModel.fromJson(result.data['data']);
            if ((treatmentModel.isFormIDAssigned == null) ||
                (treatmentModel.isFormIDAssigned == false)) {
              // Get the key of the existing model
              var key = treatmentDataBox.keyAt(
                  treatmentDataBox.values.toList().indexOf(treatmentModel));
              // Print the details of the record being deleted
              log('Deleting Treatment Model: ${treatmentDataBox.get(key)}');
              // Delete the old model
              await treatmentDataBox.delete(key);
            }
            // Add the new model with the server-assigned ID
            await treatmentDataBox.put(
                updatedModel.id.toString(), updatedModel);
            updateCaseBox(
                model: null,
                tbModel: null,
                caseModel: null,
                mentalHealthScreeningModel: null,
                diagnosisModel: null,
                treatmentModel: updatedModel,
                contactTracingModel: null,
                outcomeModel: null,
                faqCheckListModel: null);
            //getCaseModel(caseId: updatedModel.caseId);
            DjangoflowAppSnackbar.showInfo(
                'Succesfully updated offline Treatment Models');
            log('Treatment DataBox Contains===========${treatmentDataBox.values.toList().toString()}');
            updateCount++;
          } else {
            // Handle error if needed
            throw Exception(
                'Failed to push Treatment Details from Local Storage');
          }
        } catch (e) {
          // Handle the exception if needed
          log('Error pushing Treatment details: $e');
          continue;
        }
      }
    }
    return updateCount;
  }

  Future<int> pushPendingContactTracingDetails() async {
    Box<ContactTracingModel> contactTracingDataBox =
        Hive.box<ContactTracingModel>('contactTracingModel');
    List<ContactTracingModel> contactTracingModelsList =
        contactTracingDataBox.values.toList();
    int updateCount = 0;
    for (var contactTracingModel in contactTracingModelsList) {
      final isUpdated = contactTracingModel.isUpdated ?? false;
      if (!isUpdated) {
        final model = (contactTracingModel.isFormIDAssigned == null) ||
                (contactTracingModel.isFormIDAssigned == false)
            ? contactTracingModel.copyWith(id: null)
            : contactTracingModel;
        try {
          log('Pushing ContactTracing Model to the Server:${model.toString()}');
          // Attempt to push the tbModel details to the server
          final request = NetworkRequest(
            '$contactTracingUrl${model.id == null ? '' : '/${model.id}'}',
            model.id == null ? RequestMethod.post : RequestMethod.patch,
            isAuthorized: true,
            data: {
              ...contactTracingModel.toJson(),
              'case_id': model.caseId ?? AuthCubit.instance.workingCaseId,
            },
          );
          final result = await NetworkManager.instance.perform(request);
          if (result.status == Status.ok) {
            ContactTracingModel updatedModel =
                ContactTracingModel.fromJson(result.data['data']);
            if ((contactTracingModel.isFormIDAssigned == null) ||
                (contactTracingModel.isFormIDAssigned == false)) {
              // Get the key of the existing model
              var key = contactTracingDataBox.keyAt(contactTracingDataBox.values
                  .toList()
                  .indexOf(contactTracingModel));
              // Print the details of the record being deleted
              log('Deleting ContactTracing Model: ${contactTracingDataBox.get(key)}');
              // Delete the old model
              await contactTracingDataBox.delete(key);
              // Remove the contact tracing model ID from the case after deletion
              updateCaseBox(
                  contactTracingModel: updatedModel.copyWith(id: null),
                  model: null,
                  tbModel: null,
                  caseModel: null,
                  mentalHealthScreeningModel: null,
                  diagnosisModel: null,
                  treatmentModel: null,
                  outcomeModel: null,
                  faqCheckListModel: null);
            }
            // Add the new model with the server-assigned ID
            await contactTracingDataBox.put(
                updatedModel.id.toString(), updatedModel);
            updateCaseBox(
                model: null,
                tbModel: null,
                caseModel: null,
                mentalHealthScreeningModel: null,
                diagnosisModel: null,
                contactTracingModel: updatedModel,
                treatmentModel: null,
                outcomeModel: null,
                faqCheckListModel: null);
            //getCaseModel(caseId: updatedModel.caseId);
            DjangoflowAppSnackbar.showInfo(
                'Succesfully updated offline ContactTracing Models');
            log('ContactTracing DataBox Contains===========${contactTracingDataBox.values.toList().toString()}');
            updateCount++;
          } else {
            // Handle error if needed
            throw Exception(
                'Failed to push ContactTracing Details from Local Storage');
          }
        } catch (e) {
          // Handle the exception if needed
          log('Error pushing ContactTracing details: $e');
          continue;
        }
      }
    }
    return updateCount;
  }

  Future<int> pushPendingOutcomeDetails() async {
    Box<OutcomeModel> outcomeDataBox = Hive.box<OutcomeModel>('outcomeModel');
    List<OutcomeModel> outcomeModelsList = outcomeDataBox.values.toList();
    int updateCount = 0;
    for (var outcomeModel in outcomeModelsList) {
      final isUpdated = outcomeModel.isUpdated ?? false;
      if (!isUpdated) {
        final model = (outcomeModel.isFormIDAssigned == null) ||
                (outcomeModel.isFormIDAssigned == false)
            ? outcomeModel.copyWith(id: null)
            : outcomeModel;
        try {
          log('Pushing Outcome Model to the Server:${model.toString()}');
          // Attempt to push the tbModel details to the server
          final request = NetworkRequest(
            '$outcomeUrl${model.id == null ? '' : '/${model.id}'}',
            model.id == null ? RequestMethod.post : RequestMethod.patch,
            isAuthorized: true,
            data: {
              ...outcomeModel.toJson(),
              'case_id': model.caseId ?? AuthCubit.instance.workingCaseId,
            },
          );
          final result = await NetworkManager.instance.perform(request);
          if (result.status == Status.ok) {
            OutcomeModel updatedModel =
                OutcomeModel.fromJson(result.data['data']);
            if ((outcomeModel.isFormIDAssigned == null) ||
                (outcomeModel.isFormIDAssigned == false)) {
              // Get the key of the existing model
              var key = outcomeDataBox
                  .keyAt(outcomeDataBox.values.toList().indexOf(outcomeModel));
              // Print the details of the record being deleted
              log('Deleting Outcome Model: ${outcomeDataBox.get(key)}');
              // Delete the old model
              await outcomeDataBox.delete(key);
            }
            // Add the new model with the server-assigned ID
            await outcomeDataBox.put(updatedModel.id.toString(), updatedModel);
            updateCaseBox(
                model: null,
                tbModel: null,
                caseModel: null,
                mentalHealthScreeningModel: null,
                diagnosisModel: null,
                contactTracingModel: null,
                treatmentModel: null,
                outcomeModel: updatedModel,
                faqCheckListModel: null);
            //getCaseModel(caseId: updatedModel.caseId);
            DjangoflowAppSnackbar.showInfo(
                'Succesfully updated offline Outcome Models');
            log('Outcome DataBox Contains===========${outcomeDataBox.values.toList().toString()}');
            updateCount++;
          } else {
            // Handle error if needed
            throw Exception(
                'Failed to push Outcome Details from Local Storage');
          }
        } catch (e) {
          // Handle the exception if needed
          log('Error pushing Outcome details: $e');
          continue;
        }
      }
    }
    return updateCount;
  }

  Future<int> pushPendingFaqCheckListDetails() async {
    Box<FaqChecklistModel> faqCheckListData =
        Hive.box<FaqChecklistModel>('faqCheckListModel');
    List<FaqChecklistModel> faqCheckListModels =
        faqCheckListData.values.toList();
    int updateCount = 0;
    for (var faqCheckListModel in faqCheckListModels) {
      final isUpdated = faqCheckListModel.isUpdated ?? false;
      if (!isUpdated) {
        final model = (faqCheckListModel.isFormIdAssigned == null) ||
                (faqCheckListModel.isFormIdAssigned == false)
            ? faqCheckListModel.copyWith(id: null)
            : faqCheckListModel;
        try {
          log('Pushing Outcome Model to the Server:${model.toString()}');
          // Attempt to push the tbModel details to the server
          final request = NetworkRequest(
            '$faqUrl${model.id == null ? '' : '/${model.id}'}',
            model.id == null ? RequestMethod.post : RequestMethod.patch,
            isAuthorized: true,
            data: {
              ...faqCheckListModel.toJson(),
              'case_id': model.caseId ?? AuthCubit.instance.workingCaseId,
            },
          );
          final result = await NetworkManager.instance.perform(request);
          if (result.status == Status.ok) {
            FaqChecklistModel updatedModel =
                FaqChecklistModel.fromJson(result.data['data']);
            if ((faqCheckListModel.isFormIdAssigned == null) ||
                (faqCheckListModel.isFormIdAssigned == false)) {
              // Get the key of the existing model
              var key = faqCheckListData.keyAt(
                  faqCheckListData.values.toList().indexOf(faqCheckListModel));
              // Print the details of the record being deleted
              log('Deleting Outcome Model: ${faqCheckListData.get(key)}');
              // Delete the old model
              await faqCheckListData.delete(key);
            }
            // Add the new model with the server-assigned ID
            await faqCheckListData.put(
                updatedModel.id.toString(), updatedModel);
            updateCaseBox(
                model: null,
                tbModel: null,
                caseModel: null,
                mentalHealthScreeningModel: null,
                diagnosisModel: null,
                contactTracingModel: null,
                treatmentModel: null,
                outcomeModel: null,
                faqCheckListModel: updatedModel);
            //getCaseModel(caseId: updatedModel.caseId);
            DjangoflowAppSnackbar.showInfo(
                'Succesfully updated offline Faq Models');
            log('Faq DataBox Contains===========${faqCheckListData.values.toList().toString()}');
            updateCount++;
          } else {
            // Handle error if needed
            throw Exception('Failed to push Faq Details from Local Storage');
          }
        } catch (e) {
          // Handle the exception if needed
          log('Error pushing Faq details: $e');
          continue;
        }
      }
    }
    return updateCount;
  }

  // Future<void> updateDataBox<T>({
  //   required String boxName,
  //   required int? modelID,
  //   required int? caseId,
  //   required T Function(T model, int? caseId) updateModelCallback,
  // }) async {
  //   Box<T> dataBox = Hive.box<T>(boxName);
  //   T? model;

  //   final key = dataBox.keyAt(
  //     dataBox.values.toList().indexWhere(
  //         (existingCase) => (existingCase as dynamic).id == modelID),
  //   );

  //   if (key != null) {
  //     print('Found this Model: ${dataBox.get(key).toString()}');
  //     model = dataBox.get(key);
  //   }

  //   if (model != null) {
  //     T updatedModel = updateModelCallback(model, caseId);

  //     if ((updatedModel as dynamic).id != null) {
  //       await dataBox.put(
  //           (updatedModel as dynamic).id.toString(), updatedModel);
  //       log('Updated Case ID of the Model: ${updatedModel.toString()}');

  //       updateCaseBox(
  //           model: null,
  //           tbModel: boxName == 'tbScreeningModel'
  //               ? updatedModel as TBScreeningModel
  //               : null,
  //           caseModel: null,
  //           mentalHealthScreeningModel: boxName == 'mentalHealthScreeningModel'
  //               ? updatedModel as MentalHealthScreeningModel
  //               : null);

  //       log('$boxName Data Box Contains: ${dataBox.values.toList().toString()}');
  //     } else {
  //       log('Updated Model ID is null, skipping Hive put operation');
  //     }
  //   } else {
  //     log('$boxName Model is null, skipping update');
  //   }
  // }

  Future<void> updateTBDataBox(int? tbModelID, int? caseId) async {
    Box<TBScreeningModel> tbdataBox =
        Hive.box<TBScreeningModel>('tbScreeningModel');
    TBScreeningModel? tbScreeningModel;

    final indexOfExistingCase = tbdataBox.values.toList().indexWhere(
        (existingCase) =>
            existingCase.id == tbModelID || existingCase.id == caseId);
    if (indexOfExistingCase == -1) {
      return;
    }
    final model = tbdataBox.keyAt(indexOfExistingCase);

    if (model != null) {
      tbScreeningModel = tbdataBox.get(model);
    }

    if (tbScreeningModel != null) {
      TBScreeningModel updateModel = tbScreeningModel.copyWith(caseId: caseId);

      if (updateModel.id != null) {
        await tbdataBox.put(updateModel.id.toString(), updateModel);
        log('Updated Case ID of the TBScreening Model: ${updateModel.toString()}');
        updateCaseBox(
            model: null,
            tbModel: updateModel,
            caseModel: null,
            mentalHealthScreeningModel: null,
            contactTracingModel: null,
            diagnosisModel: null,
            treatmentModel: null,
            outcomeModel: null,
            faqCheckListModel: null);
        // log('Deleting TB Screening Model======================${tbdataBox.get(model)}'
        //     .toString());
        // await tbdataBox.delete(model);
        log('TB Data Box Contains:${tbdataBox.values.toList().toString()}');
      } else {
        log('Update Model ID is null, skipping Hive put operation');
      }
    } else {
      log('TB Screening Model is null, skipping update');
    }
  }

  Future<void> updateWHODataBox(int? whoModelID, int? caseId) async {
    Box<MentalHealthScreeningModel> whodatabox =
        Hive.box<MentalHealthScreeningModel>('mentalHealthScreeningModel');
    MentalHealthScreeningModel? mentalHealthScreeningModel;
    final indexOfExistingCase = whodatabox.values.toList().indexWhere(
        (existingCase) =>
            existingCase.id == whoModelID || existingCase.id == caseId);
    if (indexOfExistingCase == -1) {
      return;
    }
    final model = whodatabox.keyAt(indexOfExistingCase);

    if (model != null) {
      mentalHealthScreeningModel = whodatabox.get(model);
    }

    if (mentalHealthScreeningModel != null) {
      MentalHealthScreeningModel updateModel =
          mentalHealthScreeningModel.copyWith(caseId: caseId);

      if (updateModel.id != null) {
        await whodatabox.put(updateModel.id.toString(), updateModel);
        log('Updated Case ID of the Mental Helath Screening model: ${updateModel.toString()}');
        updateCaseBox(
            model: null,
            tbModel: null,
            caseModel: null,
            mentalHealthScreeningModel: updateModel,
            diagnosisModel: null,
            treatmentModel: null,
            contactTracingModel: null,
            outcomeModel: null,
            faqCheckListModel: null);
        // log('Deleting TB Screening Model======================${whodatabox.get(model)}'
        //     .toString());
        // await whodatabox.delete(model);
        log('WHO Data Box Contains:${whodatabox.values.toList().toString()}');
      } else {
        log('Update Model ID is null, skipping Hive put operation');
      }
    } else {
      log('Mental Health Screening Model is null, skipping update');
    }
  }

  Future<void> updateDiagnosisDataBox(
      int? diagnosisModelID, int? caseId) async {
    Box<DiagnosisModel> diagnosisDataBox =
        Hive.box<DiagnosisModel>('diagnosisModel');
    DiagnosisModel? diagnosisModel;
    final indexOfExistingCase = diagnosisDataBox.values.toList().indexWhere(
        (existingCase) =>
            existingCase.id == diagnosisModelID || existingCase.id == caseId);
    if (indexOfExistingCase == -1) {
      return;
    }
    final model = diagnosisDataBox.keyAt(indexOfExistingCase);

    if (model != null) {
      diagnosisModel = diagnosisDataBox.get(model);
    }

    if (diagnosisModel != null) {
      DiagnosisModel updateModel = diagnosisModel.copyWith(caseId: caseId);

      if (updateModel.id != null) {
        await diagnosisDataBox.put(updateModel.id.toString(), updateModel);
        log('Updated Case ID of the Diagnosis model: ${updateModel.toString()}');
        updateCaseBox(
            model: null,
            tbModel: null,
            caseModel: null,
            mentalHealthScreeningModel: null,
            diagnosisModel: updateModel,
            treatmentModel: null,
            contactTracingModel: null,
            outcomeModel: null,
            faqCheckListModel: null);
        // log('Deleting TB Screening Model======================${diagnosisDataBox.get(model)}'
        //     .toString());
        // await diagnosisDataBox.delete(model);
        log('Diagnosis Data Box Contains:${diagnosisDataBox.values.toList().toString()}');
      } else {
        log('Update Model ID is null, skipping Hive put operation');
      }
    } else {
      log('Diagnosis model is null, skipping update');
    }
  }

  Future<void> updateTreatmentDataBox(int? treatmentID, int? caseId) async {
    Box<TreatmentModel> treatmentDataBox =
        Hive.box<TreatmentModel>('treatmentModel');
    TreatmentModel? treatmentModel;

    final indexOfExistingCase = treatmentDataBox.values.toList().indexWhere(
        (existingCase) =>
            existingCase.id == treatmentID || existingCase.id == caseId);

    if (indexOfExistingCase == -1) {
      return;
    }

    final model = treatmentDataBox.keyAt(indexOfExistingCase);

    if (model != null) {
      treatmentModel = treatmentDataBox.get(model);
    }

    if (treatmentModel != null) {
      TreatmentModel updateModel = treatmentModel.copyWith(caseId: caseId);

      if (updateModel.id != null) {
        await treatmentDataBox.put(updateModel.id.toString(), updateModel);
        log('Updated Case ID of the Treatment model: ${updateModel.toString()}');
        updateCaseBox(
            model: null,
            tbModel: null,
            caseModel: null,
            mentalHealthScreeningModel: null,
            diagnosisModel: null,
            treatmentModel: updateModel,
            contactTracingModel: null,
            outcomeModel: null,
            faqCheckListModel: null);
        // log('Deleting TB Screening Model======================${diagnosisDataBox.get(model)}'
        //     .toString());
        // await diagnosisDataBox.delete(model);
        log('Treatment Data Box Contains:${treatmentDataBox.values.toList().toString()}');
      } else {
        log('Update Model ID is null, skipping Hive put operation');
      }
    } else {
      log('Treatment model is null, skipping update');
    }
  }

  Future<void> updateContactTracingDataBox(
      int? contactTracingID, int? caseId) async {
    Box<ContactTracingModel> contactTracingDataBox =
        Hive.box<ContactTracingModel>('contactTracingModel');

    // Find all models that match the given contactTracingID or caseId
    final matchingModels = contactTracingDataBox.values
        .where((existingCase) =>
            existingCase.caseId == contactTracingID ||
            existingCase.caseId == caseId)
        .toList();

    if (matchingModels.isNotEmpty) {
      for (var existingModel in matchingModels) {
        // Update the caseId of each matching model
        ContactTracingModel updatedModel =
            existingModel.copyWith(caseId: caseId);

        if (updatedModel.id != null) {
          await contactTracingDataBox.put(
              updatedModel.id.toString(), updatedModel);
          log('Updated Case ID of the ContactTracing model: ${updatedModel.toString()}');

          // Assuming `updateCaseBox` function is correctly defined and handles the update
          updateCaseBox(
              model: null,
              tbModel: null,
              caseModel: null,
              mentalHealthScreeningModel: null,
              diagnosisModel: null,
              treatmentModel: null,
              contactTracingModel: updatedModel,
              outcomeModel: null,
              faqCheckListModel: null);

          log('ContactTracing Data Box Contains: ${contactTracingDataBox.values.toList().toString()}');
        } else {
          log('Update Model ID is null, skipping Hive put operation');
        }
      }
    } else {
      log('No matching ContactTracing models found, skipping update');
    }
  }

  Future<void> updateOutcomeDataBox(int? outcomeID, int? caseId) async {
    Box<OutcomeModel> outcomeDataBox = Hive.box<OutcomeModel>('outcomeModel');
    OutcomeModel? outcomeModel;

    final indexOfExistingCase = outcomeDataBox.values.toList().indexWhere(
        (existingCase) =>
            existingCase.id == outcomeID || existingCase.id == caseId);

    if (indexOfExistingCase == -1) {
      return;
    }

    final model = outcomeDataBox.keyAt(indexOfExistingCase);

    if (model != null) {
      outcomeModel = outcomeDataBox.get(model);
    }

    if (outcomeModel != null) {
      OutcomeModel updateModel = outcomeModel.copyWith(caseId: caseId);

      if (updateModel.id != null) {
        await outcomeDataBox.put(updateModel.id.toString(), updateModel);
        log('Updated Case ID of the Outcome model: ${updateModel.toString()}');
        updateCaseBox(
            model: null,
            tbModel: null,
            caseModel: null,
            mentalHealthScreeningModel: null,
            diagnosisModel: null,
            treatmentModel: null,
            contactTracingModel: null,
            outcomeModel: updateModel,
            faqCheckListModel: null);

        log('Outcome Data Box Contains:${outcomeDataBox.values.toList().toString()}');
      } else {
        log('Update Model ID is null, skipping Hive put operation');
      }
    } else {
      log('Outcome model is null, skipping update');
    }
  }

  Future<void> updateFaqCheckListDataBox(int? faqID, int? caseId) async {
    Box<FaqChecklistModel> faqCheckListDataBox =
        Hive.box<FaqChecklistModel>('faqCheckListModel');
    FaqChecklistModel? faqModel;

    final indexOfExistingCase = faqCheckListDataBox.values.toList().indexWhere(
        (existingCase) =>
            existingCase.id == faqID || existingCase.id == caseId);

    if (indexOfExistingCase == -1) {
      return;
    }

    final model = faqCheckListDataBox.keyAt(indexOfExistingCase);

    if (model != null) {
      faqModel = faqCheckListDataBox.get(model);
    }

    if (faqModel != null) {
      FaqChecklistModel updateModel = faqModel.copyWith(caseId: caseId);

      if (updateModel.id != null) {
        await faqCheckListDataBox.put(updateModel.id.toString(), updateModel);
        log('Updated Case ID of the Faq Checklist model: ${updateModel.toString()}');
        updateCaseBox(
            model: null,
            tbModel: null,
            caseModel: null,
            mentalHealthScreeningModel: null,
            diagnosisModel: null,
            treatmentModel: null,
            contactTracingModel: null,
            outcomeModel: null,
            faqCheckListModel: updateModel);

        log('Faq CheckList Data Box Contains:${faqCheckListDataBox.values.toList().toString()}');
      } else {
        log('Update Model ID is null, skipping Hive put operation');
      }
    } else {
      log('Faq Checklist model is null, skipping update');
    }
  }

  Future<void> deleteCaseLocal(int? caseId) async {
    Box<Case> caseBox = Hive.box<Case>('caseList');
    int caseKey = caseBox.keys
        .firstWhere((key) => caseBox.get(key)?.id == caseId, orElse: () => -1);

    if (caseKey != -1) {
      log('Deleting CaseModel: ${caseBox.get(caseKey)}');
      await caseBox.delete(caseKey);
    }
  }

  Future<void> updateCaseBox({
    required ReferralDetailsModel? model,
    required TBScreeningModel? tbModel,
    required MentalHealthScreeningModel? mentalHealthScreeningModel,
    required DiagnosisModel? diagnosisModel,
    required TreatmentModel? treatmentModel,
    required ContactTracingModel? contactTracingModel,
    required OutcomeModel? outcomeModel,
    required FaqChecklistModel? faqCheckListModel,
    required Case? caseModel,
  }) async {
    final context = navigatorKey.currentContext!;
    final sourceCubit = context.read<SourceCubit>();
    final caseBox = Hive.box<Case>('caseList');
    Case caseModelToSave;
    final caseIdToSearch = model?.caseId ??
        tbModel?.caseId ??
        mentalHealthScreeningModel?.caseId ??
        diagnosisModel?.caseId ??
        treatmentModel?.caseId ??
        contactTracingModel?.caseId ??
        outcomeModel?.caseId ??
        faqCheckListModel?.caseId;
    final existingCaseIndex = caseBox.values.toList().indexWhere(
          (existingCase) => existingCase.id == caseIdToSearch,
        );

    log('Existing case index: $existingCaseIndex');

    if (caseModel == null) {
      if (existingCaseIndex == -1) {
        // No existing case, create a new one if model is not null
        if (model != null) {
          final district = model.selectedDistrict;
          final block = model.selectedBlock;

          final panchayat = model.selectedPanchayatCode;
          final districtData =
              sourceCubit.state.dataModel?.districts?.firstWhere(
            (element) => element.id == district,
            orElse: () => const District(district: null),
          );
          final String? districtName = districtData?.district;
          String? panchayatName = _getPanchayatName(
              sourceCubit.state.dataModel?.blocks!, panchayat);
          final blockData = sourceCubit.state.dataModel?.blocks?.firstWhere(
            (element) => element.id == block,
            orElse: () => const Block(block: null),
          );
          final String? blockName = blockData?.block;
          caseModelToSave = Case(
            id: model.caseId,
            referralBlock: blockName,
            referralName: model.referralName,
            gender: model.gender,
            age: model.age,
            panchayat: panchayatName,
            referredBy: model.referredBy,
            district: districtName,
            referralMobileNumber: model.guardianPhoneNumber,
            referralDetails: model.id,
            isUpdated: false,
            createdOn: DateTime.now(),
          );
          caseBox.add(caseModelToSave);
        }
      } else {
        // Existing case found, update the relevant fields
        final existingCase = caseBox.getAt(existingCaseIndex)!;
        log('Existing case: $existingCase');

        if (model != null) {
          final block = model.selectedBlock;

          final district = model.selectedDistrict;
          final panchayat = model.selectedPanchayatCode;
          final districtData =
              sourceCubit.state.dataModel?.districts?.firstWhere(
            (element) => element.id == district,
            orElse: () => const District(district: null),
          );
          final String? districtName = districtData?.district;
          String? panchayatName = _getPanchayatName(
              sourceCubit.state.dataModel?.blocks!, panchayat);
          final blockData = sourceCubit.state.dataModel?.blocks?.firstWhere(
            (element) => element.id == block,
            orElse: () => const Block(block: null),
          );
          final String? blockName = blockData?.block;
          caseModelToSave = existingCase.copyWith(
            id: model.caseId,
            referralBlock: blockName,
            referralName: model.referralName,
            gender: model.gender,
            age: model.age,
            panchayat: panchayatName,
            referredBy: model.referredBy,
            district: districtName,
            referralMobileNumber: model.guardianPhoneNumber,
            referralDetails: model.id,
            isUpdated: false,
            createdOn: DateTime.now(),
          );
          caseBox.putAt(existingCaseIndex, caseModelToSave);
        }

        if (tbModel != null) {
          caseModelToSave = existingCase.copyWith(
            screenedBy: tbModel.screenedBy,
            tbScreeningOutcome: tbModel.screeningOutcome,
            tbScreening: tbModel.id,
          );

          caseBox.putAt(existingCaseIndex, caseModelToSave);
        }
        if (mentalHealthScreeningModel != null) {
          caseModelToSave = existingCase.copyWith(
            whoSrq: mentalHealthScreeningModel.id,
          );

          caseBox.putAt(existingCaseIndex, caseModelToSave);
        }
        if (diagnosisModel != null) {
          caseModelToSave = existingCase.copyWith(
            diagnosis: diagnosisModel.id,
            diagnosisName: diagnosisModel.diagnosis,
          );

          caseBox.putAt(existingCaseIndex, caseModelToSave);
        }
        if (treatmentModel != null) {
          caseModelToSave = existingCase.copyWith(
            treatment: treatmentModel.id,
            statusAfterDx: treatmentModel.diagnosisStatus,
          );

          caseBox.putAt(existingCaseIndex, caseModelToSave);
        }
        if (contactTracingModel != null) {
          Box<ContactTracingModel> contactTracingDataBox =
              Hive.box<ContactTracingModel>('contactTracingModel');

          if (contactTracingModel.id == null) {
            // Remove invalid IDs or null entries
            List<int> updatedContactTracingList = List.from(
              existingCase.contactTracingList ?? [],
            )..removeWhere((id) =>
                contactTracingDataBox.values.every((model) => model.id != id));

            caseModelToSave = existingCase.copyWith(
              contactTracingList: updatedContactTracingList,
            );
            caseBox.putAt(existingCaseIndex, caseModelToSave);
          } else {
            // Add only if ID matches the current case ID and is not already in the list
            List<int> updatedContactTracingList = [
              ...(existingCase.contactTracingList ?? []),
              contactTracingModel.id as int,
            ];

            // Remove duplicates
            updatedContactTracingList =
                updatedContactTracingList.toSet().toList();

            caseModelToSave = existingCase.copyWith(
              contactTracing: contactTracingModel.id,
              contactTracingList: updatedContactTracingList,
            );
            caseBox.putAt(existingCaseIndex, caseModelToSave);
          }
        }
        if (outcomeModel != null) {
          final treatmentOutcome = outcomeModel.selectedtreatmentOutcome;
          final treatmentOutcomeData =
              sourceCubit.state.diagnosisData?.treatmentOutcome?.firstWhere(
            (element) => element.id == treatmentOutcome,
            orElse: () => const TreatmentOutcome(name: null),
          );
          final String? treatmentOutcomeName = treatmentOutcomeData?.name;
          caseModelToSave = existingCase.copyWith(
              outcomeValue: outcomeModel.id,
              treatmentOutcome: treatmentOutcomeName);

          caseBox.putAt(existingCaseIndex, caseModelToSave);
        }
        if (faqCheckListModel != null) {
          caseModelToSave =
              existingCase.copyWith(faqChecklist: faqCheckListModel.id);
          caseBox.putAt(existingCaseIndex, caseModelToSave);
        }
      }
    } else {
      caseModelToSave = caseModel;
      final existingCaseIndex = caseBox.values
          .toList()
          .indexWhere((existingCase) => existingCase.id == caseModel.id);

      if (existingCaseIndex != -1) {
        caseBox.putAt(existingCaseIndex, caseModelToSave);
      } else {
        caseBox.add(caseModelToSave);
      }
    }
  }

  Future<bool> deleteCaseRemote(int caseId) async {
    try {
      final request = NetworkRequest(
        '$getSingleCaseUrl/$caseId',
        RequestMethod.delete,
        isAuthorized: true,
        data: {},
      );
      final result = await NetworkManager.instance.perform(request);
      if (result.status == Status.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

String? _getPanchayatName(List<Block>? blocks, int? panchayat) {
  String? panchayatName;
  if (blocks != null) {
    for (var block in blocks) {
      var panchayatData = block.panchayat?.firstWhere((p) => p.id == panchayat,
          orElse: () => const Panchayat(id: 0));
      if (panchayatData?.id != 0) {
        panchayatName = panchayatData?.panchayat;
        break;
      }
    }
    return panchayatName;
  } else {
    return null;
  }
}

class CounterManager {
  CounterManager._privateConstructor();

  static final CounterManager instance = CounterManager._privateConstructor();

  static const String _counterKey = 'counter_key';

  int _counter = 1;

  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _counter = _prefs.getInt(_counterKey) ?? 1;
  }

  Future<int> getNextCounter() async {
    _counter++;
    await _prefs.setInt(_counterKey, _counter);
    return _counter;
  }
}
