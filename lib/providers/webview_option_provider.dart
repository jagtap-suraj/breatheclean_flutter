import 'package:flutter/foundation.dart';

class WebViewOptionProvider with ChangeNotifier {
  bool _isChartEnabled = false;

  bool get isChartEnabled => _isChartEnabled;

  void toggle() {
    _isChartEnabled = !_isChartEnabled;
    notifyListeners();
  }
}
