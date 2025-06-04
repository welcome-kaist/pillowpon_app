import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:myapp/app/cores/bases/base_view.dart';
import 'package:myapp/app/cores/values/app_colors.dart';
import 'package:myapp/app/cores/widgets/appbar.dart';
import 'package:myapp/app/cores/widgets/text.dart';
import 'package:myapp/app/modules/main/controllers/main_controller.dart';
import 'package:myapp/app/modules/main/models/smart_alart.dart';
import 'package:myapp/app/modules/main/widgets/setting.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../cores/utils/throttler.dart';
import '../../../routes/app_asset_path.dart';
import '../widgets/smart_alarm_widget.dart';

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
    return Obx(() {
      if (controller.currentIndex == 2) {
        if (controller.isOnboarding) {
          return Padding(
            padding: const EdgeInsets.all(30),
            child: onboarding(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: homeWidget(),
        );
      } else if (controller.currentIndex == 3) {
        return smartAlarmWidget();
      }
      return Container();
    });
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "add"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Alarm"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Fluttertoast.showToast(msg: "개발중");
              break;
            case 1:
              Fluttertoast.showToast(msg: "개발중");
              break;
            case 2:
              controller.tabBarIndex = index;
              break;
            case 3:
              controller.tabBarIndex = index;
              break;
            case 4:
              Fluttertoast.showToast(msg: "개발중");
              break;
          }
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
          monthlySleepScore(),
          const SizedBox(height: 20),
          sleepDepthGraph(),
        ],
      );
    });
  }

  Widget monthlySleepScore() {
    return TableCalendar(
      calendarBuilders: CalendarBuilders(
        prioritizedBuilder: (context, day, focusedDay) {
          return Container(
            decoration: BoxDecoration(
              color: day == focusedDay
                  ? AppColors.primaryNormal.withAlpha(50)
                  : AppColors.primaryTransparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primaryTransparent,
                      child: PillowponText.mob14Normal(
                        text: '${day.day}',
                        color: day.weekday == DateTime.sunday
                            ? AppColors.primaryRed
                            : day.weekday == DateTime.saturday
                                ? AppColors.primaryNormal
                                : AppColors.primaryBlack,
                      ),
                    ),
                    if (controller.monthlySleepScores.containsKey(day.day))
                      Positioned(
                          top: -15,
                          bottom: 0,
                          left: 0,
                          child:
                              controller.monthlySleepScores[day.day]!.score > 50
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: AppColors.primaryGreen,
                                      size: 15,
                                    )
                                  : const Icon(
                                      Icons.cancel,
                                      color: AppColors.primaryRed,
                                      size: 15,
                                    )),
                  ],
                ),
                PillowponText.mob14Normal(
                    text:
                        "${controller.monthlySleepScores[day.day]?.score ?? ""}")
              ],
            ),
          );
        },
        dowBuilder: (context, day) {
          String text;
          Color textColor = AppColors.primaryBlack;
          switch (day.weekday) {
            case DateTime.monday:
              text = "Mon";
              break;
            case DateTime.tuesday:
              text = "Tue";
              break;
            case DateTime.wednesday:
              text = "Wed";
              break;
            case DateTime.thursday:
              text = "Thu";
              break;
            case DateTime.friday:
              text = "Fri";
              break;
            case DateTime.saturday:
              text = "Sat";
              textColor = AppColors.primaryNormal;
              break;
            case DateTime.sunday:
              text = "Sun";
              textColor = AppColors.primaryRed;
              break;
            default:
              text = "";
              textColor = AppColors.primaryBlack;
              break;
          }
          return Center(
            child: PillowponText.mob14Normal(
              text: text,
              color: textColor,
            ),
          );
        },
      ),
      calendarFormat: CalendarFormat.twoWeeks,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
      rowHeight: 60,
      firstDay: DateTime(DateTime.now().year, DateTime.now().month, 1),
      lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
      focusedDay: DateTime.now(),
    );
  }

  Widget sleepDepthGraph() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            PillowponText.comfortaa24Bold(
              text: "Sleep Depth",
              color: AppColors.primaryBlack,
            ),
            OutlinedButton(
                onPressed: () {
                  if (controller.isSleeping) {
                    controller.stopSleeping();
                  } else {
                    controller.setSleeping();
                  }
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        width: 2,
                        color: controller.isSleeping
                            ? AppColors.primaryRed
                            : AppColors.primaryNormal.withValues(alpha: 0.5)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: PillowponText.mob14Bold(
                  text: controller.isSleeping ? "Stop" : "Start",
                  color: controller.isSleeping
                      ? AppColors.primaryRed
                      : AppColors.primaryNormal,
                )),
          ],
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
                    minX: controller.backendService.sleepDepthList.isNotEmpty
                        ? controller.backendService.sleepDepthList.first.time
                            .millisecondsSinceEpoch
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
                        color: AppColors.primaryGray.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: controller.backendService.sleepDepthList
                            .map((depth) {
                          return FlSpot(
                              depth.time.millisecondsSinceEpoch.toDouble(),
                              depth.depth.toDouble());
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
                                .map((color) => color.withValues(alpha: 0.3))
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
                    controller.backendService.sleepDepthList.isNotEmpty &&
                            controller
                                    .backendService.sleepDepthList.last.depth >
                                50
                        ? Icons.sentiment_satisfied_alt
                        : Icons.sentiment_dissatisfied_outlined,
                    size: 50,
                    color:
                        controller.backendService.sleepDepthList.isNotEmpty &&
                                controller.backendService.sleepDepthList.last
                                        .depth >
                                    50
                            ? AppColors.primaryNormal.withAlpha(150)
                            : AppColors.primaryRed.withAlpha(150),
                  )),
            ],
          ),
        ),
        Center(
          child: PillowponText.comfortaa20Normal(
              text: controller.backendService.sleepDepthList.isNotEmpty &&
                      controller.backendService.sleepDepthList.last.depth > 50
                  ? "You are sleeping well"
                  : "You are not sleeping well",
              color: controller.backendService.sleepDepthList.isNotEmpty &&
                      controller.backendService.sleepDepthList.last.depth > 50
                  ? AppColors.primaryNormal
                  : AppColors.primaryRed),
        ),
      ],
    );
  }

  Widget smartAlarmWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PillowponText.comfortaa24Bold(
                text: "Smart Alarm",
                color: AppColors.primaryBlack,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primaryGray.withValues(alpha: 0.5),
              ),
            ),
            height: 200,
            width: double.maxFinite,
            child: CupertinoDatePicker(
              onDateTimeChanged: (dateTime) {
                controller.setSmartAlarm(
                  SmartAlarm(
                    id: (controller.smartAlarm?.id ?? 0) + 1,
                    alartTime: dateTime,
                    currentTime: DateTime.now(),
                  ),
                );
              },
              minimumDate: DateTime.now(),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              controller.saveSmartAlarm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryNormal.withAlpha(200),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: PillowponText.comfortaa24Bold(
                text: "add alarm", color: AppColors.primaryWhite),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
                color: AppColors.primaryTransparent,
                border: Border(
                  top: BorderSide(
                    color: AppColors.primaryGray.withValues(alpha: 0.5),
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: AppColors.primaryGray.withValues(alpha: 0.5),
                    width: 1,
                  ),
                )),
            height: 300,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: controller.smartAlarmList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SmartAlarmWidget(
                    index: index,
                  );
                }),
          )
        ],
      ),
    );
  }
}
