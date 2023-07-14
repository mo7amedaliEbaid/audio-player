part of '../signup_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final email = TextEditingController();
  final fullName = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    fullName.dispose();
    password.dispose();
    super.dispose();
  }

  int genderIndex = -1;
  bool? notification = false;

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.cubit(context);

    return Scaffold(
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
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back'),
                  ),
                ),
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
                Space.y1!,
                CustomTextField(
                  hint: 'Full Name',
                  controller: fullName,
                  textInputType: TextInputType.name,
                  validatorFtn: Validators.required,
                ),
                Space.y!,
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
                  validatorFtn: Validators.required,
                ),
                Space.y1!,
                Text(
                  'Gender',
                  style: AppText.b1!.copyWith(
                    color: AppTheme.c!.primary,
                  ),
                ),
                Space.y!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppUtils.male,
                    AppUtils.female,
                    AppUtils.other,
                  ]
                      .asMap()
                      .entries
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            setState(() {
                              genderIndex = e.key;
                            });
                          },
                          child: Container(
                            margin: Space.h!,
                            padding: Space.all(0.25, 0.25),
                            decoration: BoxDecoration(
                              color: genderIndex == e.key
                                  ? AppTheme.c!.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset(
                              e.value,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Space.y!,
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppTheme.c!.primary!,
                      value: notification,
                      onChanged: (value) {
                        setState(() {
                          notification = value;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'I would like to receive your newsletter and other promotional information.',
                      ),
                    ),
                  ],
                ),
                Space.y!,
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSignUpFailed) {
                      CustomSnackBars.failure(context, state.message!);
                    } else if (state is AuthSignUpSuccess) {
                      CustomSnackBars.success(
                          context, 'Account Created Successfully!');
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthSignUpLoading) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LinearProgressIndicator(
                            color: AppTheme.c!.primary,
                          ),
                          Space.y1!,
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                CustomButton(
                  title: 'Sign Up',
                  onPressed: authCubit.state is AuthSignUpLoading
                      ? () {}
                      : () {
                          if (genderIndex == -1) {
                            CustomSnackBars.failure(
                                context, 'Please select Gender!');
                          } else if (formKey.currentState!.validate()) {
                            authCubit.signup(
                              fullName.text.trim(),
                              email.text.trim(),
                              password.text.trim(),
                            );
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
