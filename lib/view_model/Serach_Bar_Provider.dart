import 'package:flutter/material.dart';

class SearchBarProvider with ChangeNotifier {
  bool _isSearching = false;

  bool get isSearching => _isSearching;

  void Searching() {
    _isSearching = !_isSearching;
    notifyListeners();
  }
}
