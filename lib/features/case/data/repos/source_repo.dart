import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatpar_orange/configurations/network/application_error.dart';
import 'package:tatpar_orange/configurations/network/network_manager.dart';
import 'package:tatpar_orange/features/case/data/source_models/diagnosis_data.dart';
import 'package:tatpar_orange/features/case/data/source_models/data_model.dart';

import '../../../../configurations/network/api_constants.dart';
import '../../../../configurations/network/network_request.dart';

class SourceRepo {
  Future<DataModel?> buildDataFields() async {
    final response = await NetworkManager.instance.perform(NetworkRequest(
      districtsUrl,
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    ));
    if (response.success == true) {
      Box<DataModel> dataBox = Hive.box<DataModel>('dataModel');
      final DataModel dataModel = DataModel.fromJson(response.data['data']);
      await dataBox.put('latestData', dataModel);

      final storedData = dataBox.get(dataBox.keyAt(dataBox.length - 1));
      log(storedData.toString());

      return dataModel;
    } else {
      Box<DataModel> dataBox = Hive.box<DataModel>('dataModel');
      final DataModel? storedData =
          dataBox.get(dataBox.keyAt(dataBox.length - 1));

      if (response.error != null && response.error?.type is NetworkError) {
        log('Using stored data from Hive: $storedData');
        return storedData;
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching data',
          type: UnExpected(),
        );
      }
    }
  }

  Future<DiagnosisData?> getDiagnosisData() async {
    final response = await NetworkManager.instance.perform(NetworkRequest(
      diagnosisDataUrl,
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    ));
    if (response.success == true) {
      Box<DiagnosisData> dataBox = Hive.box<DiagnosisData>('diagnosisData');

      final DiagnosisData diagnosisData =
          DiagnosisData.fromJson(response.data['data']);
      await dataBox.put('latestData', diagnosisData);
      final storedData = dataBox.get(dataBox.keyAt(dataBox.length - 1));
      log('STORED DATA=====================$storedData');
      log(storedData.toString());

      return diagnosisData;
    } else {
      Box<DiagnosisData> dataBox = Hive.box<DiagnosisData>('diagnosisData');
      final DiagnosisData? storedData = dataBox.get('latestData');
      log('Using stored data from Hive: $storedData');

      if (response.error != null && response.error?.type is NetworkError) {
        log('Using stored data from Hive: $storedData');
        return storedData;
      } else {
        throw ApplicationError(
          errorMsg: 'Error fetching data',
          type: UnExpected(),
        );
      }
    }
  }
}
