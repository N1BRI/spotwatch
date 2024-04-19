import 'package:flutter/material.dart';

mixin Loadable on ChangeNotifier{
  bool _isBusy = false;

  bool isLoading() {
    return _isBusy;
  }

  void setLoadingState(bool isLoading) {
    _isBusy = isLoading;
    notifyListeners();
  }
}