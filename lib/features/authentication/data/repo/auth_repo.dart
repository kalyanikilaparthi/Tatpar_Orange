import 'dart:convert';
import 'dart:developer';

import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tatpar_orange/configurations/network/api_constants.dart';
import 'package:tatpar_orange/configurations/network/api_response.dart';
import 'package:tatpar_orange/configurations/network/network_manager.dart';
import 'package:tatpar_orange/configurations/network/network_request.dart';
import 'package:tatpar_orange/features/authentication/data/models/app_user_model.dart';

class AuthRepo {
  AuthRepo();

  Future<Map<String, dynamic>> logout() async {
    try {
      final request = NetworkRequest(
        logoutUrl,
        RequestMethod.post,
        data: {},
        isAuthorized: true,
      );
      final result = await NetworkManager.instance.perform(request);
      if (result.status == Status.ok && result.response!.statusCode == 200) {
        final Map<String, dynamic> data = result.data;
        return data;
      } else {
        return result.response?.data ?? {};
      }
    } catch (e) {
      log('Error logging in: $e');
      return {};
    }
  }

  // Get user details
  Future<AppUser?> getUserDetails(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return AppUser.fromJson(userMap);
    } else {
      try {
        final request = NetworkRequest(
          usersUrl,
          RequestMethod.get,
          isAuthorized: true,
        );
        final result = await NetworkManager.instance.perform(request);
        if (result.status == Status.ok && result.response!.statusCode == 200) {
          final List<dynamic> usersList = result.data['data']['users'];
          final user = usersList.firstWhere(
            (user) => user['mobile_number'] == phone.replaceFirst('+91', ''),
            orElse: () => null,
          );
          if (user != null) {
            final appUser = AppUser.fromJson(user);

            await prefs.setString('user', json.encode(appUser.toJson()));

            return appUser;
          } else {
            DjangoflowAppSnackbar.showError(
              'User not registered',
            );
            log("User with mobile number $phone, not found.");
          }
        }
      } catch (e) {
        log('Error fetching user details: $e');
      }
      return null;
    }
  }

  Future<Map<String, dynamic>> loginWithPhoneAndPassword(
      String phone, String password) async {
    try {
      final request = NetworkRequest(
        loginUrl,
        RequestMethod.post,
        data: {
          'mobile_number': phone,
          'password': password,
        },
      );
      final result = await NetworkManager.instance.perform(request);
      print('Data: ${result.data}');
      if (result.status == Status.ok && result.response!.statusCode == 200) {
        final Map<String, dynamic> data = result.data;
        return data;
      } else {
        return {};
      }
    } catch (e) {
      log('Error logging in: $e');
      return {};
    }
  }
}
