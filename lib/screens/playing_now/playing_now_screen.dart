import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show basename;
import 'package:provider/provider.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_theme.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../models/song/song.dart';
import '../../providers/song_provider.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_snackbar.dart';

class PlayingNowScreen extends StatefulWidget {
  const PlayingNowScreen({Key? key}) : super(key: key);

  @override
  State<PlayingNowScreen> createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends State<PlayingNowScreen> {
  double playing = 0;

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);
    bool alreadyLiked = songProvider.likedSongs.contains(
      Song(
        songPath: songProvider.current!,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Space.all(1, 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      songProvider.current!.isEmpty||songProvider.current == null
                          ? ""
                          : '${basename(songProvider.current!).substring(0, 8)}...',
                      style: AppText.h1b,
                    ),
                  ),
                  Space.x!,
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    iconSize: AppDimensions.normalize(20),
                    splashRadius: AppDimensions.normalize(10),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppTheme.c!.primary,
                    ),
                  ),
                ],
              ),
              Text(
                'By Artist',
                style: AppText.b2b!.copyWith(
                  color: AppTheme.c!.primary,
                ),
              ),
              Space.y2!,
              Expanded(
                child: Container(
                  height: AppDimensions.normalize(140),
                  child: songProvider.isPlaying
                      ? Lottie.asset(AppUtils.playinglottie)
                      : Image.asset(AppUtils.playing),
                ),
              ),
              Space.y1!,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: AppDimensions.normalize(20),
                    splashRadius: AppDimensions.normalize(10),
                    onPressed: () {},
                    color: AppTheme.c!.primary,
                    icon: const Icon(
                      Icons.skip_previous,
                    ),
                  ),
                  IconButton(
                    iconSize: AppDimensions.normalize(20),
                    splashRadius: AppDimensions.normalize(10),
                    color: AppTheme.c!.primary,
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
                    iconSize: AppDimensions.normalize(20),
                    splashRadius: AppDimensions.normalize(10),
                    onPressed: () {},
                    color: AppTheme.c!.primary,
                    icon: const Icon(
                      Icons.skip_next,
                    ),
                  ),
                ],
              ),
              Space.y1!,
              songProvider.isPlaying
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitWave(
                          color: Colors.red,
                          size: 45,
                        ),
                        SpinKitWave(
                          color: Colors.red,
                          size: 45,
                        ),
                        SpinKitWave(
                          color: Colors.red,
                          size: 45,
                        ),
                        SpinKitWave(
                          color: Colors.red,
                          size: 45,
                        ),
                        SpinKitWave(
                          color: Colors.red,
                          size: 45,
                        ),
                        SpinKitWave(
                          color: Colors.red,
                          size: 45,
                        ),
                      ],
                    )
                  : Slider(
                      value: playing,
                      onChanged: (value) {
                        setState(() {
                          playing = value;
                        });
                      },
                    ),
              Space.y1!,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    splashRadius: AppDimensions.normalize(10),
                    onPressed: () {
                      if (!alreadyLiked) {
                        songProvider.liked(
                          Song(
                            songPath: songProvider.current!,
                          ),
                        );
                        CustomSnackBars.success(context, 'Added to Liked!');
                      } else {
                        songProvider.unLiked(
                          Song(
                            songPath: songProvider.current!,
                          ),
                        );
                        CustomSnackBars.failure(context, 'Removed from Liked!');
                      }
                    },
                    icon: Icon(
                      alreadyLiked ? Icons.favorite : Icons.favorite_border,
                      color: alreadyLiked ? AppTheme.c!.primary : null,
                    ),
                  ),
                  IconButton(
                    splashRadius: AppDimensions.normalize(10),
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                  ),
                  IconButton(
                    splashRadius: AppDimensions.normalize(10),
                    onPressed: () {},
                    icon: const Icon(Icons.comment),
                  ),
                  IconButton(
                    splashRadius: AppDimensions.normalize(10),
                    onPressed: () {},
                    icon: const Icon(Icons.playlist_add),
                  ),
                  IconButton(
                    splashRadius: AppDimensions.normalize(10),
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
