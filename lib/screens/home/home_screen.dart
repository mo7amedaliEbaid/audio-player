import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_theme.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../models/playlist/playlist.dart';
import '../../providers/song_provider.dart';
import '../../utils/utils.dart';

part 'widgets/_playlist_card.dart';
part 'widgets/_playlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final songProvider = Provider.of<SongProvider>(context, listen: false);
      songProvider.getPlaylists();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Space.all(1, 1.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Space.yf(3.5),
              Text(
                'Playlists',
                style: AppText.h1b,
              ),
              Space.y1!,
              context.watch<SongProvider>().getLists.length==0?Center(
                child: Text(
                  'You don\'t have playlists yet',
                  style: AppText.b1,
                ),
              ):
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: context.watch<SongProvider>().getLists.map((e) => _PlaylistCard(
                          playlist: e,
                          isPlaylist: true,
                        ),
                      )
                      .toList(),
                ),
              ),
              Space.y2!,
              Text(
                'Artists',
                style: AppText.h1b,
              ),
              Space.y1!,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Eminem',
                    'Eminem',
                    'Eminem',
                    'Eminem',
                  ]
                      .map(
                        (e) => _PlaylistCard(
                          playlist: Playlist(
                            name: e,
                            description: '',
                            playlist: [],
                          ),
                          isPlaylist: false,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
