import 'package:get/get.dart';

class KeamananController extends GetxController {
  // Example observable variables for security settings
  var isTwoFactorEnabled = false.obs;
  var passwordStrength = ''.obs;

  // Method to toggle two-factor authentication
  void toggleTwoFactor(bool value) {
    isTwoFactorEnabled.value = value;
  }

  // Method to update password strength
  void updatePasswordStrength(String password) {
    // Simple password strength check (this can be expanded)
    if (password.length < 6) {
      passwordStrength.value = 'Weak';
    } else if (password.length < 12) {
      passwordStrength.value = 'Moderate';
    } else {
      passwordStrength.value = 'Strong';
    }
  }
}
