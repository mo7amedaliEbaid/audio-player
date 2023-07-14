import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_theme.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../cubits/auth/cubit.dart';
import '../../utils/utils.dart';
import '../../validators/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.cubit(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Space.all(1, 1),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Space.y1!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        AppUtils.appIcon,
                        height: AppDimensions.normalize(20),
                      ),
                    )
                  ],
                ),
                Space.y1!,
                Text(
                  'Forgot Password?',
                  style: AppText.h1b!.copyWith(
                    fontSize: AppDimensions.normalize(25),
                    color: AppTheme.c!.primary,
                  ),
                ),
                Space.y1!,
                CustomTextField(
                  controller: email,
                  hint: 'Enter Email',
                  textInputType: TextInputType.emailAddress,
                  validatorFtn: Validators.emailValidator,
                ),
                Space.y!,
                Text(
                  'You will receive a rest link at your registered email address',
                  style: AppText.b2,
                ),
                Space.y1!,
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthForgotPasswordFailed) {
                      CustomSnackBars.failure(context, state.message!);
                    } else if (state is AuthForgotPasswordSuccess) {
                      CustomSnackBars.success(
                          context, 'Reset link has been sent at your email!');
                      email.clear();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthForgotPasswordLoading) {
                      return LinearProgressIndicator(
                        color: AppTheme.c!.primary,
                      );
                    }
                    return Container();
                  },
                ),
                Space.y1!,
                CustomButton(
                  title: 'Reset Password',
                  onPressed: authCubit.state is AuthForgotPasswordLoading
                      ? () {}
                      : () {
                          if (formKey.currentState!.validate()) {
                            authCubit.forgotPassword(email.text.trim());
                          }
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
