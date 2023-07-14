import 'package:flutter/material.dart';

import '../../configs/app_typography.dart';
import '../../configs/space.dart';

class ListenLaterScreen extends StatelessWidget {
  const ListenLaterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Space.all(1, 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Space.yf(3.5),
          Text(
            'Listen Later',
            style: AppText.h1b,
          ),
        ],
      ),
    );
  }
}
