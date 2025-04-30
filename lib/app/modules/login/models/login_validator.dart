import 'package:flutter/material.dart';

class LoginValidator {
  bool isEmailValid = false;
  bool isPasswordValid = false;

  FormFieldValidator emailValidator(){
    return (value) {
      if (value!.isEmpty ||
          !value.contains('@')) {
        return 'Please enter a valid email address.';
      }
      return null;
    };
  }

  FormFieldValidator passwordValidator(){
    return (value) {
      if (value!.isEmpty || value.length < 6) {
        return 'Password must be at least 7 characters long.';
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