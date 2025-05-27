import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        if (!controller.isSleeping) return onboarding();
        return homeWidget();
      }),
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
        onTap: (index) {
          Fluttertoast.showToast(msg: "개발중");
        },
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
                  color:
                      controller.isConnected ? AppColors.primaryNormal : null,
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
    return const Drawer(
      child: SettingWidget(),
    );
  }

  Widget homeWidget() {
    return Obx(() {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PillowponText.comfortaa24Bold(
                text: "Sleep Score",
                color: AppColors.primaryBlack,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Stack(
                  children: [
                    SizedBox(
                      height: Get.width * (3 / 4),
                      child: LineChart(
                        LineChartData(
                          backgroundColor: AppColors.primaryWhite,
                          maxY: 100,
                          minY: 0,
                          minX: controller
                                  .backendService.sleepScoreList.isNotEmpty
                              ? controller.backendService.sleepScoreList.first
                                  .start_time.millisecondsSinceEpoch
                                  .toDouble()
                              : 0,
                          titlesData: const FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 44,
                                showTitles: true,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                          ),
                          gridData: const FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            horizontalInterval: 10,
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color:
                                  AppColors.primaryGray.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: controller.backendService.sleepScoreList
                                  .map((score) {
                                return FlSpot(
                                    score.start_time.millisecondsSinceEpoch
                                        .toDouble(),
                                    score.score.toDouble());
                              }).toList(),
                              isCurved: true,
                              barWidth: 5,
                              isStrokeCapRound: true,
                              dotData: const FlDotData(show: false),
                              gradient: const LinearGradient(
                                  colors: AppColors.graphGradient),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: AppColors.graphGradient
                                      .map((color) =>
                                          color.withValues(alpha: 0.3))
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                          // read about it in the LineChartData section
                        ),
                        duration: const Duration(milliseconds: 150), // Optional
                        curve: Curves.linear, // Optional
                      ),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: Icon(
                          controller.backendService.sleepScoreList.isNotEmpty &&
                                  controller.backendService.sleepScoreList.last
                                          .score >
                                      50
                              ? Icons.sentiment_satisfied_alt
                              : Icons.sentiment_dissatisfied_outlined,
                          size: 50,
                          color: controller.backendService.sleepScoreList
                                      .isNotEmpty &&
                                  controller.backendService.sleepScoreList.last
                                          .score >
                                      50
                              ? AppColors.primaryNormal.withAlpha(150)
                              : AppColors.primaryRed.withAlpha(150),
                        )),
                  ],
                ),
              ),
            ],
          ),
          PillowponText.comfortaa20Normal(
              text: controller.backendService.sleepScoreList.isNotEmpty &&
                      controller.backendService.sleepScoreList.last.score > 50
                  ? "You are sleeping well"
                  : "You are not sleeping well",
              color: controller.backendService.sleepScoreList.isNotEmpty &&
                      controller.backendService.sleepScoreList.last.score > 50
                  ? AppColors.primaryNormal
                  : AppColors.primaryRed),
        ],
      );
    });
  }
}
