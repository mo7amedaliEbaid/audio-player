import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../providers/song_provider.dart';
import '../../utils/utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final songProvider = Provider.of<SongProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Space.all(1, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    splashRadius: AppDimensions.normalize(10),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Space.x1!,
                  Text(
                    'Profile',
                    style: AppText.h3b,
                  ),
                  Space.xm!,
                  IconButton(
                    splashRadius: AppDimensions.normalize(10),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ],
              ),
              Space.y2!,
              currentUser?.photoURL == null
                  ? Image.asset(
                      AppUtils.dp,
                      height: AppDimensions.normalize(50),
                    )
                  : CircleAvatar(
                      radius: AppDimensions.normalize(35),
                      child: ClipOval(
                        child: Image.network(
                          currentUser!.photoURL!,
                          height: AppDimensions.normalize(80),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
              Space.y!,
              Center(
                child: Text(
                  currentUser != null ? currentUser.displayName! : 'Full Name',
                  style: AppText.h1b,
                ),
              ),
              Space.y2!,
              Text(
                currentUser!.email!,
                style: AppText.h2b,
              ),
              Space.y!,
              Text(
                'Total Songs: ${songProvider.songs!.length.toString()}',
                style: AppText.h2,
              ),
              Space.y!,
              Text(
                'Total Playlists: ${songProvider.playlists.length}',
                style: AppText.h2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
