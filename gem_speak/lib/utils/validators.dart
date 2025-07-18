import 'package:flutter/material.dart';

class Validators {
  static FormFieldValidator<String> emailValidator() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Email cannot be empty';
      }
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
      if (!emailRegex.hasMatch(value)) {
        return 'Invalid email format';
      }
      return null;
    };
  }

  static FormFieldValidator<String> passwordValidator() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Password cannot be empty';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
      return null;
    };
  }
}
