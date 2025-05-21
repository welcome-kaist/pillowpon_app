import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/app/cores/bases/base_view.dart';
import 'package:myapp/app/cores/widgets/appbar.dart';
import 'package:myapp/app/cores/widgets/text.dart';
import 'package:myapp/app/routes/app_asset_path.dart';

import '../../../cores/utils/throttler.dart';
import '../../../cores/values/app_colors.dart';
import '../controllers/logout_controller.dart';

class LogoutView extends BaseView<LogoutController> {
  LogoutView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              AppAsset.logo,
              width: 260,
              height: 76,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 167,
              height: 52,
              child: OutlinedButton(
                  onPressed: Throttler.to.run(action: controller.goLogin()),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primaryWhite,
                      side: const BorderSide(
                          width: 2, color: AppColors.primaryNormal),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: PillowponText.mob14w700(
                      text: "LOG IN", color: AppColors.primaryNormal)),
            ),
            SizedBox(
                width: 167,
                height: 52,
                child: FilledButton(
                  onPressed: Throttler.to.run(action: controller.goRegister()),
                  style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryNormal,
                      side: const BorderSide(
                          width: 2, color: AppColors.primaryNormal),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: PillowponText.mob14w700(
                      text: "REGISTER", color: AppColors.primaryWhite),
                ))
          ],
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    return null;
  }
}
