import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/app/cores/bases/base_view.dart';
import 'package:myapp/app/cores/widgets/appbar.dart';
import 'package:myapp/app/routes/app_asset_name.dart';

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
                  onPressed: controller.goLogin(),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primaryWhite,
                      side:
                          const BorderSide(width: 2, color: AppColors.primaryNormal),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: const Text(
                    "LOG IN",
                    style: TextStyle(
                        color: AppColors.primaryNormal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
            ),
            SizedBox(
              width: 167,
              height: 52,
              child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryNormal,
                      side:
                          const BorderSide(width: 2, color: AppColors.primaryNormal),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(
                        color: AppColors.primaryWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
            )
          ],
        ),
        const SizedBox(height: 40,)
      ],
    );
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    return null;
  }
}
