part of '../home_screen.dart';

class _PlaylistScreen extends StatelessWidget {
  final Playlist playlist;
  const _PlaylistScreen({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.name),
      ),
      body: SafeArea(
        child: playlist.playlist.isEmpty
            ? Center(
                child: Text(
                  'Please add some songs to the playlist!',
                  style: AppText.b1b,
                ),
              )
            : SingleChildScrollView(
                padding: Space.all(1.5, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: playlist.playlist
                      .map((e) => Card(
                            child: ListTile(
                              title: Text(e.songPath),
                            ),
                          ))
                      .toList(),
                ),
              ),
      ),
    );
  }
}
