import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/main/widgets/setting.dart';
import 'package:myapp/app/routes/app_asset_path.dart';

import '../values/app_colors.dart';

class MyAppbar {
  static PreferredSizeWidget main({
    required VoidCallback onNotificationPressed,
    required VoidCallback onSettingsPressed,
  }) {
    return AppBar(
      title: Image.asset(
        AppAsset.logo,
        width: 200,
        height: 50,
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: onNotificationPressed,
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: onSettingsPressed,
        ),
      ],
    );
  }
}
