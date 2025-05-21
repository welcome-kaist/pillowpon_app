import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:myapp/app/cores/bases/base_view.dart';
import 'package:myapp/app/cores/values/app_colors.dart';
import 'package:myapp/app/cores/widgets/appbar.dart';
import 'package:myapp/app/cores/widgets/text.dart';
import 'package:myapp/app/modules/main/controllers/main_controller.dart';
import 'package:myapp/app/modules/main/widgets/setting.dart';

import '../../../cores/utils/throttler.dart';
import '../../../routes/app_asset_path.dart';

class MainView extends BaseView<MainController> {
  MainView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return MyAppbar.main(
      onNotificationPressed: () {
        controller.onNotificationPressed();
      },
      onSettingsPressed: () {
        globalKey.currentState!.openEndDrawer();
      },
    );
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Obx(() {
        if(!controller.isSleeping) return onboarding();
        return homeWidget();
        }
      ),
    );
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "add"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outline), label: "Notification"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.currentIndex,
        onTap: (index) {},
      );
    });
  }

  Widget onboarding() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 60,
        ),
        Obx(() {
          return PillowponText.comfortaa36Normal(
              text: controller.isConnected ? "Success!!" : "Before started");
        }),
        const SizedBox(height: 10),
        Obx(() {
          return PillowponText.comfortaa24Normal(
              text: controller.isConnected
                  ? "Please Sleep to use"
                  : "Please connect your");
        }),
        Image.asset(
          AppAsset.logo,
          width: 130,
          height: 37,
        ),
        Obx(() {
          return GestureDetector(
            onTap: () {
              if (controller.isConnected) {
                controller.setSleeping();
              }
            },
            child: Stack(
              children: [
                Image.asset(
                  AppAsset.pillowIcon,
                  width: 122,
                  height: 122,
                  color: controller.isConnected ? AppColors.primaryNormal : null,
                ),
                Positioned(
                  bottom: 8,
                  left: 0,
                  child: AnimatedScale(
                    curve: Curves.easeOutExpo,
                    scale: controller.isConnected ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 400),
                    child: Image.asset(
                      AppAsset.check,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(
          height: 20,
        ),
        animatedConnectedButton()
      ],
    );
  }

  Widget connectButton() {
    return Obx(() {
      return SizedBox(
        width: double.maxFinite,
        height: 52,
        child: controller.isDeviceDialogOpened
            ? FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryNormal,
                    side: const BorderSide(color: AppColors.primaryNormal),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: JumpingDots(
                  color: AppColors.primaryWhite,
                  radius: 7,
                  numberOfDots: 3,
                  animationDuration: const Duration(milliseconds: 150),
                  delay: 500,
                  verticalOffset: -10,
                  innerPadding: 3,
                ))
            : FilledButton(
                onPressed: Throttler.to
                    .run(action: () => controller.openDeviceDialog()),
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryNormal,
                    side: const BorderSide(color: AppColors.primaryNormal),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: PillowponText.mob14w700(
                    text: controller.isConnected
                        ? "CONNECT NEW DEVICE"
                        : "CONNECT",
                    color: AppColors.primaryWhite)),
      );
    });
  }

  Widget animatedConnectedButton() {
    return Obx(() {
      return SizedBox(
          width: double.maxFinite,
          height: 52,
          child: AnimatedButton(
            isSelected: controller.isConnected,
            animatedOn: AnimatedOn.none,
            text: "CONNECT",
            onPress:
                Throttler.to.run(action: () => controller.openDeviceDialog()),
            selectedText: "CONNECTED",
            selectedTextColor: AppColors.primaryWhite,
            backgroundColor: AppColors.primaryNormal,
            selectedBackgroundColor: AppColors.primaryRed,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryWhite),
          ));
    });
  }

  @override
  Widget? endDrawer(BuildContext context) {
    return Drawer(
      child: SettingWidget(),
    );
  }

  Widget homeWidget(){
    return LineChart(
      LineChartData(
        // read about it in the LineChartData section
      ),
      duration: Duration(milliseconds: 150), // Optional
      curve: Curves.linear, // Optional
    );
  }
}
