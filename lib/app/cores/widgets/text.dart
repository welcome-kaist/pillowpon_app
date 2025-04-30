import 'package:flutter/material.dart';
import '../values/app_colors.dart';

class PillowponText{
  static Text mob24Bold({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: color ?? AppColors.primaryWhite),
    );
  }

  static Text mob24w500({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: color ?? AppColors.primaryWhite),
    );
  }

  static Text mob14Bold({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color ?? AppColors.primaryWhite),
    );
  }

  static Text mob14w500({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color ?? AppColors.primaryWhite),
    );
  }

  static Text mob12Bold({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color ?? AppColors.primaryWhite),
    );
  }

  static Text mob12w500({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color ?? AppColors.primaryWhite),
    );
  }

}