import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myapp/app/cores/values/app_colors.dart';

import '../../../cores/widgets/text.dart';
import '../controllers/setting_controller.dart';

class SettingWidget extends GetWidget<SettingController> {
  const SettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DrawerHeader(
          child: Column(
            children: [
              PillowponText.mob24Bold(
                  text: "Settings", color: AppColors.primaryBlack),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryGray,
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.account_circle,
            color: AppColors.primaryDark,
          ),
          title: PillowponText.mob14w500(text: "Profile"),
          onTap: () {
            Fluttertoast.showToast(msg: "개발중");
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.bluetooth_connected,
            color: AppColors.primaryDark,
          ),
          title: PillowponText.mob14w500(text: "Connected Devices"),
          onTap: () {
            Fluttertoast.showToast(msg: "개발중");
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications, color: AppColors.primaryDark),
          title: PillowponText.mob14w500(text: "Notifications"),
          onTap: () {
            Fluttertoast.showToast(msg: "개발중");
          },
        ),
        ListTile(
          leading: const Icon(Icons.security, color: AppColors.primaryDark),
          title: PillowponText.mob14w500(text: "Privacy"),
          onTap: () {
            Fluttertoast.showToast(msg: "개발중");
          },
        ),
        ListTile(
          leading: const Icon(Icons.language, color: AppColors.primaryDark),
          title: PillowponText.mob14w500(text: "Language"),
          onTap: () {
            Fluttertoast.showToast(msg: "개발중");
          },
        ),
        ListTile(
          leading: const Icon(Icons.help, color: AppColors.primaryDark),
          title: PillowponText.mob14w500(
            text: "Help & Feedback",
          ),
          onTap: () {
            Fluttertoast.showToast(msg: "개발중");
          },
        ),
        Expanded(child: Container()),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: AppColors.primaryRed,
          ),
          title: const Text(
            "Logout",
            style: TextStyle(color: AppColors.primaryRed),
          ),
          onTap: () {
            controller.authService.logout();
          },
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
