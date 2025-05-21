import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:myapp/app/cores/utils/throttler.dart';
import 'package:myapp/app/cores/widgets/text.dart';

import '../../../cores/values/app_colors.dart';
import '../controllers/main_controller.dart';

class DeviceDialog extends StatelessWidget {
  final controller = Get.find<MainController>();
  final log = Get.find<Logger>();

  DeviceDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: 300,
            decoration: const BoxDecoration(
              color: AppColors.primaryNormal,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
                child: PillowponText.mob14w500(
                    text: "Select Device", color: AppColors.primaryWhite)),
          ),
          SizedBox(
            height: 400,
            width: 300,
            child: Obx(() {
              if (controller.deviceService.deviceList.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }
              return ListView(
                children: controller.deviceService.deviceList.map((device) {
                  return ListTile(
                    title: Text(device.name),
                    onTap: () {
                      controller.connectDevice(device);
                    },
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}
