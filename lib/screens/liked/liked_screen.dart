import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show basename;
import 'package:provider/provider.dart';

import '../../animations/bottom_animation.dart';
import '../../configs/app_theme.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../providers/song_provider.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({Key? key}) : super(key: key);

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final songProvider = Provider.of<SongProvider>(context, listen: false);
      songProvider.getLiked();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);

    return SingleChildScrollView(
      padding: Space.all(1, 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Space.yf(3.5),
          Text(
            'Liked',
            style: AppText.h1b,
          ),
          Space.y1!,
          if (songProvider.likedSongsList.isEmpty)
            Center(
              child: Text(
                'No Liked Songs!',
                style: AppText.b1b,
              ),
            ),
          ...songProvider.likedSongs.map(
            (e) => WidgetAnimator(
              child: ListTile(
                tileColor: context.read<SongProvider>().current == e.songPath
                    ? AppTheme.c!.primary!.withAlpha(100)
                    : null,
                leading: CircleAvatar(
                  backgroundColor:
                      context.read<SongProvider>().current == e.songPath
                          ? AppTheme.c!.primary!
                          : Colors.grey,
                  child: Text(
                    basename(e.songPath).substring(0, 1),
                  ),
                ),
                title: Text(
                  basename(e.songPath),
                ),
                onTap: () {
                  context.read<SongProvider>().playSong(path: e.songPath);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
