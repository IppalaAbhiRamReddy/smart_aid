import 'package:flutter/foundation.dart';

class SafetyService extends ChangeNotifier {
  bool _isSosActive = false;
  bool _isLocationSharing = false;

  bool get isSosActive => _isSosActive;
  bool get isLocationSharing => _isLocationSharing;

  void setSosActive(bool isActive) {
    if (_isSosActive != isActive) {
      _isSosActive = isActive;
      notifyListeners();
    }
  }

  void setLocationSharing(bool isSharing) {
    if (_isLocationSharing != isSharing) {
      _isLocationSharing = isSharing;
      notifyListeners();
    }
  }
}
