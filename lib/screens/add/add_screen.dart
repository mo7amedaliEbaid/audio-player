import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_theme.dart';
import '../../configs/app_typography.dart';
import '../../configs/space.dart';
import '../../models/playlist/playlist.dart';
import '../../providers/song_provider.dart';
import '../../validators/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_text_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);

    return SingleChildScrollView(
      padding: Space.all(1, 1.5),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Space.yf(3.5),
            Text(
              'Add Playlist',
              style: AppText.h1b,
            ),
            Space.y1!,
            Container(
              height: AppDimensions.normalize(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.c!.primary!.withAlpha(100),
              ),
              child: Center(
                child: Icon(
                  Icons.upload_file,
                  color: AppTheme.c!.primary,
                  size: AppDimensions.normalize(50),
                ),
              ),
            ),
            Space.y2!,
            CustomTextField(
              controller: name,
              hint: 'Playlist Name',
              textInputType: TextInputType.name,
              validatorFtn: Validators.required,
            ),
            Space.y1!,
            CustomTextField(
              controller: description,
              hint: 'Description',
              textInputType: TextInputType.name,
              validatorFtn: Validators.required,
            ),
            Space.y2!,
            CustomButton(
              title: 'Add Playlist',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final playlist = Playlist(
                    playlist: [],
                    name: name.text.trim(),
                    description: description.text.trim(),
                  );

                  name.clear();
                  description.clear();

                  songProvider.addPlaylist(playlist);

                  CustomSnackBars.success(context, 'New playlist added!');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
