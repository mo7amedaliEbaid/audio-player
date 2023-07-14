import 'package:flutter/cupertino.dart';

class BottomProvider extends ChangeNotifier {
  int currentIndex = 0;

  int get index => currentIndex;

  set setIndex(int value) {
    currentIndex = value;

    notifyListeners();
  }
}
