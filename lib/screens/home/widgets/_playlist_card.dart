part of '../home_screen.dart';

class _PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final bool isPlaylist;
  const _PlaylistCard({
    Key? key,
    required this.playlist,
    required this.isPlaylist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isPlaylist
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => _PlaylistScreen(playlist: playlist),
                ),
              )
          : null,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: Space.h,
            child: Image.asset(
              isPlaylist ?AppUtils.song:AppUtils.artistslist[2],
              height:AppDimensions.normalize(65) ,
              width:AppDimensions.normalize(65) ,            ),
          ),
          Space.y!,
          Text(
            playlist.name,
            style: AppText.b1b!.copyWith(
              color: AppTheme.c!.primary,
            ),
          )
        ],
      ),
    );
  }
}
