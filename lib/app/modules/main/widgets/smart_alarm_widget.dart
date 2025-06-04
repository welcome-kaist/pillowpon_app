import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../cores/values/app_colors.dart';
import '../../../cores/widgets/text.dart';
import '../controllers/main_controller.dart';
import '../models/smart_alart.dart';

class SmartAlarmWidget extends StatefulWidget {
  final int index;

  const SmartAlarmWidget({super.key, required this.index});

  @override
  State<SmartAlarmWidget> createState() => _SmartAlarmWidgetState();
}

class _SmartAlarmWidgetState extends State<SmartAlarmWidget> {
  final controller = Get.find<MainController>();
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        width: double.maxFinite,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.primaryGray.withAlpha(100),
          ),
        ),
        child: Center(
          child: ListTile(
            leading: Icon(
              Icons.alarm,
              size: 40,
              color: _isEnabled ? AppColors.primaryBlack : AppColors.primaryGray,
            ),
            trailing: CupertinoSwitch(
                value: _isEnabled,
                onChanged: (value) {
                  setState(() {
                    _isEnabled = value;
                  });
                }),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: PillowponText.mob12Bold(
                text: DateFormat.E()
                    .format(controller.smartAlarmList[widget.index].alartTime),
                color: _isEnabled ? AppColors.primaryBlack : AppColors.primaryGray),
            subtitle: PillowponText.mob24w500(
                text: DateFormat("hh:mm")
                    .format(controller.smartAlarmList[widget.index].alartTime),
                color: _isEnabled ? AppColors.primaryBlack : AppColors.primaryGray),
          ),
        ),
      ),
    );
  }
}
