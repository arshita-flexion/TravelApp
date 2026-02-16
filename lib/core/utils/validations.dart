import 'package:validators/validators.dart';

import 'app_exports.dart';

class AppValidations {
  AppValidations._();

  static String? verificationCodeValidation(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.lbl_emptyVerificationCode;
    }
    return null;
  }

  /// Validates mobile number with country code
  static String? phoneNumberValidation(BuildContext context, String? value, {String countryCode = '+91'}) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)?.lbl_emptyPhoneNumber;
    }

    // Remove spaces and special characters except +
    final cleanNumber = value.replaceAll(RegExp(r'[^\d+]'), '');

    // Indian mobile number validation (10 digits)
    if (countryCode == '+91' || countryCode == '91') {
      if (!RegExp(r'^[6-9]\d{9}$').hasMatch(cleanNumber.replaceAll('+91', ''))) {
        return AppLocalizations.of(context)?.lbl_invalidPhoneNumber;
      }
    }

    return null;
  }

  static String? nameValidation(String? value, BuildContext context) {
    if (value == null || value.isEmpty) return AppLocalizations.of(context)?.lbl_emptyName;
    return null;
  }

  // static String? passwordValidation(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return AppLocalizations.of(context)?.lbl_emptyPassword;
  //   }
  //   return null;
  // }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).+$').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
    }

    return null;
  }

  static String? confirmPasswordValidation(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  // static String? confirmPasswordValidation(String? value, String otherPasswordValue, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return AppLocalizations.of(context)?.lbl_emptyConfirmPassword;
  //   }
  //   if (otherPasswordValue.isEmpty) return null;
  //   if (otherPasswordValue != value) {
  //     return AppLocalizations.of(context)?.lbl_passwordMismatch;
  //   }
  //   return null;
  // }

  static String? emailValidation(String? value, BuildContext context) {
    if (value == null || value.isEmpty) return AppLocalizations.of(context)?.lbl_emptyEmail;
    if (!isEmail(value)) return AppLocalizations.of(context)?.lbl_invalidEmail;
    return null;
  }

  /// Validates if the field is not empty
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter OTP';
    } else if (value.length != 4) {
      return 'OTP must be exactly 4 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'OTP should contain only digits';
    }
    return null;
  }
}
