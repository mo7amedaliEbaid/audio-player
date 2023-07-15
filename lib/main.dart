
import 'package:audio_bless/providers/app_provider.dart';
import 'package:audio_bless/providers/bottom_provider.dart';
import 'package:audio_bless/providers/song_provider.dart';
import 'package:audio_bless/screens/dashboard/dashboard.dart';
import 'package:audio_bless/screens/forgot_password/forgot_password_screen.dart';
import 'package:audio_bless/screens/login/login_screen.dart';
import 'package:audio_bless/screens/playing_now/playing_now_screen.dart';
import 'package:audio_bless/screens/profile/profile_screen.dart';
import 'package:audio_bless/screens/signup/signup_screen.dart';
import 'package:audio_bless/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'configs/core_theme.dart' as theme;
import 'cubits/auth/cubit.dart';
import 'firebase_options.dart';
import 'models/playlist/playlist.dart';
import 'models/song/song.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // hive
  await Hive.initFlutter();

  Hive.registerAdapter<Song>(SongAdapter());
  Hive.registerAdapter<Playlist>(PlaylistAdapter());

  await Hive.openBox('app');
  await Hive.openBox('songs');
  await Hive.openBox('playlists');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => SongProvider()),
        ChangeNotifierProvider(create: (_) => BottomProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, value, _) {
          return MaterialChild(
            provider: value,
          );
        },
      ),
    );
  }
}

class MaterialChild extends StatelessWidget {
  final AppProvider provider;
  const MaterialChild({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Beat Box',
      debugShowCheckedModeBanner: false,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      themeMode: provider.themeMode,
      initialRoute: '/splash',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/splash': (context) => const SplashScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/playing': (context) => const PlayingNowScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/create-account': (context) => const CreateAccountScreen(),
      },
    );
  }
}
