import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../configs/app.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_theme.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../cubits/auth/cubit.dart';
import '../../providers/app_provider.dart';
import '../../providers/bottom_provider.dart';
import '../../providers/song_provider.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/player_mini.dart';
import '../add/add_screen.dart';
import '../home/home_screen.dart';
import '../liked/liked_screen.dart';
import '../listen_later/listen_later_screen.dart';
import '../search/search_screen.dart';

part 'widgets/custom_drawer.dart';
part 'widgets/main_screen.dart';

class DashboardScreen extends StatefulWidget {
  const   DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  late bool _canBeDragged;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta =
          details.primaryDelta! / MediaQuery.of(context).size.width * 0.835;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  Future<bool> _onWillPop() async {
    return (await (showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Text(
              "Exit Application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text("Are You Sure?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  exit(0);
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ) as FutureOr<bool>?)) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);
    final currentUser = FirebaseAuth.instance.currentUser;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        behavior: HitTestBehavior.translucent,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return Material(
              color: appProvider.isDark ? Colors.grey[800] : Colors.white70,
              child: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(
                          MediaQuery.of(context).size.width *
                              0.835 *
                              (animationController.value - 1),
                          0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(
                              math.pi / 2 * (1 - animationController.value)),
                        alignment: Alignment.centerRight,
                        child: const _CustomDrawer(),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          MediaQuery.of(context).size.width *
                              0.835 *
                              animationController.value,
                          0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(-math.pi / 2 * animationController.value),
                        alignment: Alignment.centerLeft,
                        child: const _MainScreen(),
                      ),
                    ),
                    Positioned(
                      top: 4.0 + MediaQuery.of(context).padding.top,
                      left: MediaQuery.of(context).size.width * 0.01 +
                          animationController.value *
                              MediaQuery.of(context).size.width *
                              0.835,
                      child: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: toggle,
                        color: appProvider.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Positioned(
                      top: 4.0 + MediaQuery.of(context).padding.top,
                      right: MediaQuery.of(context).size.width * 0.03 +
                          animationController.value *
                              -MediaQuery.of(context).size.width *
                              0.835,
                      child: currentUser != null && currentUser.photoURL != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                currentUser.photoURL!,
                              ),
                              radius: AppDimensions.normalize(10),
                            )
                          : Image.asset(
                              AppUtils.dp,
                              height: AppDimensions.normalize(18),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
