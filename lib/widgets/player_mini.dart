import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show basename;

import '../configs/app_theme.dart';
import '../configs/app_typography.dart';
import '../configs/space.dart';
import '../providers/song_provider.dart';

class PlayerMini extends StatelessWidget {
  const PlayerMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);

    return InkWell(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      onTap: () => Navigator.pushNamed(context, '/playing'),
      child: Container(
        padding: Space.all(),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          border: Border.all(
            color: AppTheme.c!.primary!,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Space.x1!,
            Expanded(
              child: Text(
                songProvider.current!.isEmpty
                    ? 'Now Playing'
                    : basename(songProvider.current!),
                style: AppText.b1b,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.skip_previous,
              ),
            ),
            IconButton(
              onPressed: () {
                if (songProvider.isPlaying) {
                  songProvider.pauseSong();
                } else {
                  songProvider.playSong();
                }
              },
              icon: Icon(
                songProvider.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.skip_next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
