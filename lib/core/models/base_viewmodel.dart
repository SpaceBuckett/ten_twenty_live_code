import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isDisposed = false;

  @override
  void notifyListeners() {
    if (_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
