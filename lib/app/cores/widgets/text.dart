import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../values/app_colors.dart';

class PillowponText {
  static Text mob24Bold({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: color ?? AppColors.primaryBlack),
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
          color: color ?? AppColors.primaryBlack),
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
          color: color ?? AppColors.primaryBlack),
    );
  }

  static Text mob14w700({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: color ?? AppColors.primaryBlack),
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
          color: color ?? AppColors.primaryBlack),
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
          color: color ?? AppColors.primaryBlack),
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
          color: color ?? AppColors.primaryBlack),
    );
  }

  static Text comfortaa20Normal({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: color ?? AppColors.primaryBlack),
    );
  }

  static Text comfortaa24Normal({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: color ?? AppColors.primaryBlack),
    );
  }

  static Text comfortaa24Bold({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: color ?? AppColors.primaryBlack),
    );
  }

  static Text comfortaa36Normal({
    required String text,
    Color? color,
  }) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
          fontSize: 36,
          fontWeight: FontWeight.normal,
          color: color ?? AppColors.primaryBlack),
    );
  }
}
