import 'package:flutter/foundation.dart';

const baseUrl =
    kDebugMode ? 'http://3.110.217.238:8000' : 'http://3.110.217.238:8000';

const usersApiUrl = '$baseUrl/users/api/users';
const loginUrl = '$usersApiUrl/login';
const logoutUrl = '$usersApiUrl/logout';
const districtsUrl = '$baseUrl/api/referral-data';
const referralDetailsUrl = '$baseUrl/api/referral';
const tbScreeningUrl = '$baseUrl/api/tb-screening';
const whoSrqUrl = '$baseUrl/api/whosrq';
const diagnosisDataUrl = '$baseUrl/api/diagnosis-data';
const diagnosisUrl = '$baseUrl/api/diagnosis';
const treatmentUrl = '$baseUrl/api/treatment';
const contactTracingUrl = '$baseUrl/api/contact-tracing';
const contactTracingListUrl = '$baseUrl/api/fetch/contact-tracing';
const outcomeUrl = '$baseUrl/api/outcome';
const casesForHealthWorkerUrl = '$baseUrl/api/case?logged_in_user=';
const usersUrl = '$usersApiUrl/add-list';
const faqUrl = '$baseUrl/api/faochecklist';

const getSingleCaseUrl = '$baseUrl/api/case/get-delete';
