import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../../animations/bottom_animation.dart';
import '../../configs/app_theme.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../providers/song_provider.dart';
import '../../widgets/custom_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);

    return SingleChildScrollView(
      padding: Space.all(1, 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Space.yf(4.5),
          CustomTextField(
            hint: 'Search',
            controller: search,
            textInputType: TextInputType.name,
          ),
          Space.y1!,
          Text(
            'All Songs',
            style: AppText.b1!.copyWith(
              color: AppTheme.c!.primary,
            ),
          ),
          Space.y1!,
          ...songProvider.songs!
              .map(
                (e) => WidgetAnimator(
                  child: ListTile(
                    tileColor:
                        context.read<SongProvider>().current == e.songPath
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
              )
              .toList()
        ],
      ),
    );
  }
}
