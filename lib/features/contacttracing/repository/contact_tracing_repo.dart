// import 'dart:developer';

// import 'package:tatpar_orange/configurations/network/api_constants.dart';
// import 'package:tatpar_orange/configurations/network/api_response.dart';
// import 'package:tatpar_orange/configurations/network/application_error.dart';
// import 'package:tatpar_orange/configurations/network/network_manager.dart';
// import 'package:tatpar_orange/configurations/network/network_request.dart';
// import 'package:tatpar_orange/features/contacttracing/models/contact_tracing_model.dart';

// class ContactTracingRepo {
//   Future<List<ContactTracingModel>> getContactTracingList() async {
//     final request = NetworkRequest(
//       '$contactTracingUrl/$id',
//       RequestMethod.get,
//       isAuthorized: true,
//       data: {},
//     );

//     final result = await NetworkManager.instance.perform(request);
//     if (result.status == Status.ok) {
//       // Box<Case> dataBox = Hive.box<Case>('caseList');
//       final List<dynamic> contactData = result.data['data']['cases'];
//       final List<ContactTracingModel> contactDataList = contactData
//           .map<ContactTracingModel>((e) => ContactTracingModel.fromJson(e))
//           .toList();
//       // for (final caseItem in cases) {
//       //   final existingCaseIndex = dataBox.values
//       //       .toList()
//       //       .indexWhere((existingCase) => existingCase.id == caseItem.id);
//       //   if (existingCaseIndex != -1) {
//       //     dataBox.putAt(existingCaseIndex, caseItem);
//       //   } else {
//       //     dataBox.add(caseItem);
//       //   }
//       // }

//       // final List<Case> storedData = dataBox.values.toList();
//       // log(storedData.toString());

//       return contactDataList;
//     }
//     // else {
//     //   Box<Case> dataBox = Hive.box<Case>('caseList');
//     //   final List<Case> storedData = dataBox.values.toList();

//     //   if (result.error != null && result.error?.type is NetworkError) {
//     //     log('No NETWORK');
//     //     // return storedData;
//     //   }
//     else {
//       throw ApplicationError(
//         errorMsg: 'Error fetching data',
//         type: UnExpected(),
//       );
//     }
//     //  }
//   }
// }
