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
import '../forgot_password/forgot_password_screen.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.cubit(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: Space.all(1.5, 1),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 750),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 750),
                            transitionsBuilder: (context, ani1, ani2, child) {
                              return FadeTransition(
                                opacity: ani1,
                                child: child,
                              );
                            },
                            pageBuilder: (context, a1, a2) =>
                                const SignUpScreen()),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ),
                  Space.y1!,
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      AppUtils.appIcon,
                      height: AppDimensions.normalize(35),
                    ),
                  ),
                  Space.y!,
                  Text(
                    'Audio Bliss',
                    style: AppText.h1b!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Space.y2!,
                  CustomTextField(
                    hint: 'Email',
                    controller: email,
                    textInputType: TextInputType.emailAddress,
                    validatorFtn: Validators.emailValidator,
                  ),
                  Space.y!,
                  CustomTextField(
                    hint: 'Password',
                    controller: password,
                    textInputType: TextInputType.text,
                    isPass: true,
                    validatorFtn: (value) {
                      if (value.toString().isEmpty) {
                        return 'Password cannot be empty!';
                      }
                      return null;
                    },
                  ),
                  Space.y1!,
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoginFailed) {
                        CustomSnackBars.failure(context, state.message!);
                      } else if (state is AuthLoginSuccess) {
                        Navigator.popAndPushNamed(context, '/dashboard');
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoginLoading) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            LinearProgressIndicator(
                              color: AppTheme.c!.primary,
                            ),
                            Space.y!,
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  Space.y1!,
                  CustomButton(
                    title: 'Sign In',
                    onPressed: authCubit.state is AuthLoginLoading
                        ? () {}
                        : () {
                            if (formKey.currentState!.validate()) {
                              authCubit.login(
                                email.text.trim(),
                                password.text.trim(),
                              );
                            }
                          },
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 750),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 750),
                            transitionsBuilder: (context, ani1, ani2, child) {
                              return FadeTransition(
                                opacity: ani1,
                                child: child,
                              );
                            },
                            pageBuilder: (context, a1, a2) =>
                                const ForgotPasswordScreen()),
                      ),
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
