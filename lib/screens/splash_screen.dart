import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../animations/entrance_fader.dart';
import '../configs/app.dart';
import '../configs/app_dimensions.dart';
import '../configs/app_typography.dart';
import '../configs/space.dart';
import '../providers/app_provider.dart';
import '../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _next() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    String? userId;
    if (firebaseUser != null) {
      userId = prefs.getString(firebaseUser.uid);
    }
    bool isAlreadyLoggedIn = userId != null;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appProvider.initTheme();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          isAlreadyLoggedIn ? '/dashboard' : '/login',
        );
      }
    });
  }

  @override
  void initState() {
    _next();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EntranceFader(
                offset: const Offset(0, 50),
                duration: const Duration(seconds: 2),
                child: Image.asset(
                  AppUtils.appIcon,
                  height:AppDimensions.normalize(65) ,
                  width:AppDimensions.normalize(65) ,
                ),
              ),
              Space.y1!,
              EntranceFader(
                offset: const Offset(0, -50),
                duration: const Duration(seconds: 2),
                child: Text(
                  'Audio Bliss',
                  style: AppText.h1b!.copyWith(
                    fontSize: AppDimensions.normalize(20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
