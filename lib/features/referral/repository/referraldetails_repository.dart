import 'package:tatpar_orange/configurations/network/api_constants.dart';
import 'package:tatpar_orange/configurations/network/application_error.dart';
import 'package:tatpar_orange/configurations/network/network_manager.dart';
import 'package:tatpar_orange/configurations/network/network_request.dart';
import 'package:tatpar_orange/features/case/data/source_models/data_model.dart';

class ReferralDetailsRepository {
  Future<DataModel> buildDataFields() async {
    final response = await NetworkManager.instance.perform(NetworkRequest(
      districtsUrl,
      RequestMethod.get,
      isAuthorized: true,
      data: {},
    ));
    if (response.success = true) {
      final DataModel dataModel = DataModel.fromJson(response.data['data']);

      return dataModel;
    } else {
      throw ApplicationError(
        errorMsg: 'Error fetching data',
        type: UnExpected(),
      );
    }
  }
}
