// import 'package:tatpar_orange/configurations/network/api_constants.dart';
// import 'package:tatpar_orange/configurations/network/api_response.dart';
// import 'package:tatpar_orange/configurations/network/application_error.dart';
// import 'package:tatpar_orange/configurations/network/network_manager.dart';
// import 'package:tatpar_orange/configurations/network/network_request.dart';
// import 'package:tatpar_orange/features/case/data/models/subordinates_model.dart';

// import '../../../authentication/authentication.dart';

// class AssignCaseRepo {
//   Future<void> assignCase(int assignTo) async {
//     await Future.delayed(const Duration(seconds: 1));
//   }

//   Future<List<SubordinatesModel>> getSubordinates() async {
//     final params = {'healthworker_id': AuthCubit.instance.state.user!.id};
//   //   final response = await NetworkManager.instance.perform(
//   //     NetworkRequest(
//   //       subordinatesUrl,
//   //       RequestMethod.get,
//   //       isAuthorized: true,
//   //       data: params,
//   //     ),
//   //   );
//   //   if (response.status == Status.ok) {
//   //     final subordinates = response.data as List<dynamic>;
//   //     final subordinatesList = subordinates
//   //         .map((e) => SubordinatesModel.fromJson(e as Map<String, dynamic>))
//   //         .toList();
//   //     return subordinatesList;
//   //   } else {
//   //     throw ApplicationError(
//   //       errorMsg: 'Error fetching data',
//   //       type: UnExpected(),
//   //     );
//   //   }
//   // }

//   Future<ApiResponse<dynamic>> assignSubordinate(int caseId,
//       {required SubordinatesModel subordinatesModel}) async {
//     final response = await NetworkManager.instance.perform(
//       NetworkRequest(
//         '$casesUrl$caseId/',
//         RequestMethod.patch,
//         data: {
//           'assigned_to': subordinatesModel.id,
//           'healthworker_id': AuthCubit.instance.state.user!.id,
//         },
//         isAuthorized: true,
//       ),
//     );
//     return response;
//   }
// }
