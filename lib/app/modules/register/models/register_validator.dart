import 'package:flutter/material.dart';

class RegisterValidator {
  bool isNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  FormFieldValidator nameValidator() {
    return (value) {
      if (value!.isEmpty || value.length < 4) {
        isNameValid = false;
        return 'Please enter at least 4 characters';
      }
      return null;
    };
  }

  FormFieldValidator emailValidator() {
    return (value) {
      if (value!.isEmpty || !value.contains('@')) {
        return 'Please enter a valid email address.';
      }
      return null;
    };
  }

  FormFieldValidator passwordValidator() {
    return (value) {
      if (value!.isEmpty || value.length < 6) {
        return 'Password must be at least 7 characters long.';
      }
      return null;
    };
  }

  FormFieldValidator ageValidator() {
    return (value) {
      if (value!.isEmpty || int.tryParse(value) == null) {
        return 'invalid age';
      }
      return null;
    };
  }

  FormFieldValidator genderValidator() {
    return (value) {
      if (value!.isEmpty || (value != "male" && value != "female")) {
        return 'invalid gender';
      }
      return null;
    };
  }

  bool tryValidation(GlobalKey<FormState> formKey) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }
}
