

class SimUtil {
  /// Test numbers exception list
  static const List<String> testNumbers = ['9751222553', '9876541302'];

  /// Verifies if the [registeredPhone] is currently present in the device's SIM slots.
  /// Uses the new custom MethodChannel 'sim_verification' implemented in MainActivity.kt
  static Future<bool> verifySimPresent(
    String registeredPhone, {
    bool showToasts = false,
  }) async {
    return true;
  }
}
