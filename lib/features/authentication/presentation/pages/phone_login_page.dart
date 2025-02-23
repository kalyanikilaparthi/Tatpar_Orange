import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_builder/progress_builder.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/primary_text_field.dart';
import 'package:tatpar_orange/features/authentication/blocs/auth_cubit.dart';
import 'package:tatpar_orange/features/authentication/presentation/widgets/auth_button.dart';
import 'package:tatpar_orange/features/authentication/presentation/widgets/login_register_toggle.dart';

@RoutePage()
class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding * 2,
        vertical: kPadding * 3,
      ),
      shrinkWrap: true,
      children: [
        const Text(
          'Login',
          style: TextStyle(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: kPadding * 4,
        ),
        ReactiveFormBuilder(
          form: authCubit.formBuilder,
          builder: (context, form, child) => AutofillGroup(
            child: Column(
              children: [
                PrimaryTextField(
                  autoFocus: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 10,
                  onSubmitted: (_) {
                    form.markAllAsTouched();
                    if (form.valid) {
                      DefaultActionController.of(context)?.add(ActionType.start);
                    }
                  },
                  formControlName: 'phone',
                  label: 'Phone number',
                  keyboardType: TextInputType.phone,
                  autofillHints: const [
                    AutofillHints.telephoneNumber,
                  ],
                ),
                PrimaryTextField(
                  autoFocus: true,
                  onSubmitted: (_) {
                    form.markAllAsTouched();
                    if (form.valid) {
                      DefaultActionController.of(context)?.add(ActionType.start);
                    }
                  },
                  formControlName: 'password',
                  label: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isObscure,
                  autofillHints: const [
                    AutofillHints.password,
                  ],
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: kPadding * 6,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return AuthButton(
                      text: 'Login',
                      onClick: (ReactiveForm.of(context)?.valid ?? false)
                          ? () async {
                              final phoneControl = form.control('phone');
                              final passwordControl = form.control('password');
                              await authCubit.loginWithPhoneAndPass(phoneControl.value, passwordControl.value);
                            }
                          : null,
                    );
                  },
                ),
                const SizedBox(
                  height: kPadding * 2,
                ),
                const LoginRegisterToggle(),
                const SizedBox(
                  height: kPadding * 2,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
