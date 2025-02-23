import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/primary_text_field.dart';
import 'package:tatpar_orange/features/authentication/authentication.dart';

import '../../../../configurations/configurations.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  FormGroup _profileFormBuilder({required AppUser? appUserModel}) {
    return fb.group({
      'id': FormControl<int>(value: appUserModel?.id),
      'status': FormControl<String?>(
        value: appUserModel?.status ?? '',
      ),
      'mobile_number': FormControl<String?>(
        value: appUserModel?.mobileNumber ?? '',
      ),
      'alternate_number': FormControl<String?>(
        value: appUserModel?.alternateNumber ?? '',
      ),
      'aadhar_number':
          FormControl<String?>(value: appUserModel?.aadhaarNumber ?? ''),
      'first_name': FormControl<String?>(value: appUserModel?.firstName ?? ''),
      'last_name': FormControl<String?>(value: appUserModel?.lastName ?? ''),
      'city': FormControl<String?>(value: appUserModel?.city),
      'district': FormControl<String?>(value: appUserModel?.district),
      'state': FormControl<String?>(value: appUserModel?.state),
      'pincode': FormControl<String?>(value: appUserModel?.pinCode),
      'address': FormControl<String?>(value: appUserModel?.address),
      'email': FormControl<String?>(value: appUserModel?.email),
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          (previous != current) || (previous.user != current.user),
      builder: (context, state) {
        return ReactiveFormBuilder(
          form: () => _profileFormBuilder(
            appUserModel: state.user,
          ),
          builder: (BuildContext context, FormGroup formGroup, Widget? child) =>
              const AutofillGroup(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
                      child: Column(
                        spacing: kPadding * 2,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryTextField<int>(
                            formControlName: 'id',
                            label: 'User ID',
                            prefixIcon: Icons.account_circle_outlined,
                            keyboardType: TextInputType.number,
                          ),
                          PrimaryTextField(
                            formControlName: 'status',
                            label: 'Status',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'mobile_number',
                            label: 'Mobile Number',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'alternate_number',
                            label: 'Alternate Number',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'aadhar_number',
                            label: 'Aadhar Number',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'first_name',
                            label: 'First Name',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'last_name',
                            label: 'Last Name',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'city',
                            label: 'City',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'district',
                            label: 'District',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'state',
                            label: 'State',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'pincode',
                            label: 'Pin Code',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'address',
                            label: 'Address',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          PrimaryTextField(
                            formControlName: 'email',
                            label: 'Email',
                            prefixIcon: Icons.account_circle_outlined,
                            readOnly: true,
                          ),
                          SizedBox(height: kPadding * 2),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
