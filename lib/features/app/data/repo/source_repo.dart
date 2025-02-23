// import 'package:tatpar_orange/configurations/network/api_response.dart';
// import 'package:tatpar_orange/configurations/network/network_manager.dart';
// import 'package:tatpar_orange/features/app/data/models/source_model.dart';

// import '../../../../configurations/network/api_constants.dart';
// import '../../../../configurations/network/network_request.dart';
// import '../models/drug_model.dart';
// import '../models/facility_model.dart';
// import '../models/vouchers_model.dart';

// class SourceRepo {
//   Future<List<Source>?> getSources({required int healthWorkerId}) async {
//     final apiResponse = await NetworkManager.instance.perform(
//       NetworkRequest(
//         sourcesForHealthWorkerUrl,
//         RequestMethod.get,
//         isAuthorized: true,
//         data: {
//           'healthworker_id': healthWorkerId,
//         },
//       ),
//     );
//     if (apiResponse.status == Status.failed) {
//       return null;
//     }
//     if (apiResponse.response!.statusCode == 200) {
//       return List<Source>.from(apiResponse.data.map((x) => Source.fromJson(x)));
//     }
//     return null;
//   }

//   Future<List<FacilityModel>?> getFacilities(
//       {required int healthWorkerId}) async {
//     final apiResponse = await NetworkManager.instance.perform(
//       NetworkRequest(
//         facilitiesUrl,
//         RequestMethod.get,
//         isAuthorized: true,
//         data: {
//           'healthworker_id': healthWorkerId,
//         },
//       ),
//     );
//     if (apiResponse.status == Status.failed) {
//       return null;
//     }
//     if (apiResponse.response!.statusCode == 200) {
//       return List<FacilityModel>.from(
//           apiResponse.data.map((x) => FacilityModel.fromJson(x)));
//     }
//     return null;
//   }

//   Future<List<DrugModel>?> getDrugs({required int healthWorkerId}) async {
//     final apiResponse = await NetworkManager.instance.perform(
//       NetworkRequest(
//         drugsUrl,
//         RequestMethod.get,
//         isAuthorized: true,
//         data: {
//           'healthworker_id': healthWorkerId,
//         },
//       ),
//     );
//     if (apiResponse.status == Status.ok) {
//       return List<DrugModel>.from(
//           apiResponse.data.map((x) => DrugModel.fromJson(x)));
//     }
//     return null;
//   }

//   Future<List<VouchersModel>?> getVouchers(
//       {required int healthWorkerId}) async {
//     final apiResponse = await NetworkManager.instance.perform(
//       NetworkRequest(
//         vouchersUrl,
//         RequestMethod.get,
//         isAuthorized: true,
//         data: {
//           'healthworker_id': healthWorkerId,
//         },
//       ),
//     );
//     if (apiResponse.status == Status.ok) {
//       return List<VouchersModel>.from(
//           apiResponse.data.map((x) => VouchersModel.fromJson(x)));
//     }
//     return null;
//   }
// }
