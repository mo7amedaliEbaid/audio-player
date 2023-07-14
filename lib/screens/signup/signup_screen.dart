import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

part 'widgets/create_account.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.cubit(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Space.all(1.5, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Sign In'),
                ),
              ),
              Space.y2!,
              Hero(
                tag: 'logo',
                child: Image.asset(
                  AppUtils.appIcon,
                  height: AppDimensions.normalize(35),
                ),
              ),
              Space.y1!,
              Text(
                'Beat Box',
                style: AppText.h1b!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Space.yf(4),
              Space.y!,
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is FBLoginFailed) {
                    CustomSnackBars.failure(context, state.message!);
                  } else if (state is FBLoginSuccess) {
                    CustomSnackBars.success(context, 'Facebook login success!');
                    Navigator.pushNamed(context, '/dashboard');
                  }
                },
                builder: (context, state) {
                  if (state is FBLoginLoading) {
                    return const LinearProgressIndicator(
                      color: Color(0xff4267B2),
                    );
                  }
                  return Container();
                },
              ),
              Space.y2!,
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is GmailLoginFailed) {
                    CustomSnackBars.failure(context, state.message!);
                  } else if (state is GmailLoginSuccess) {
                    CustomSnackBars.success(context, 'Google login success!');
                    Navigator.pushNamed(context, '/dashboard');
                  }
                },
                builder: (context, state) {
                  if (state is GmailLoginLoading) {
                    return const LinearProgressIndicator(
                      color: Color(0xffDB4437),
                    );
                  }
                  return Container();
                },
              ),
              Space.y!,
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: AppDimensions.normalize(20),
                color: Colors.white,
                onPressed: () {
                  authCubit.gmailLogin();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.google,
                      color: Color(0xffDB4437),
                    ),
                    Space.x!,
                    Text(
                      'Continue with Google',
                      style: AppText.b1b!.copyWith(
                        color: const Color(0xffDB4437),
                      ),
                    )
                  ],
                ),
              ),
              Space.y1!,
              MaterialButton(
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: AppDimensions.normalize(20),
                color: Colors.white,
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 750),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 750),
                      transitionsBuilder: (context, ani1, ani2, child) {
                        return FadeTransition(
                          opacity: ani1,
                          child: child,
                        );
                      },
                      pageBuilder: (context, a1, a2) =>
                          const CreateAccountScreen()),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppUtils.appIcon,
                      height: AppDimensions.normalize(12),
                    ),
                    Space.x!,
                    Text(
                      'Create an Account',
                      style: AppText.b1b!.copyWith(
                        color: AppTheme.c!.primary,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
