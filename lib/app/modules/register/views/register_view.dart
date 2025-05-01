import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/app/cores/bases/base_view.dart';
import 'package:myapp/app/cores/widgets/appbar.dart';
import 'package:myapp/app/routes/app_asset_name.dart';

import '../../../cores/utils/throttler.dart';
import '../../../cores/values/app_colors.dart';
import '../../../cores/widgets/text.dart';
import '../controllers/register_controller.dart';

class LoginView extends BaseView<LoginController> {
  LoginView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: controller.back(),
          icon: const Icon(Icons.keyboard_backspace)),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PillowponText.comfortaa24Normal(
                text: "Welcome to",
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3, left: 5),
                child: Image.asset(
                  AppAsset.logo,
                  width: 130,
                  height: 37,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          PillowponText.comfortaa20Normal(
              text: "Please login to use", color: AppColors.primaryBlack),
          loginForm(),
          const SizedBox(
            height: 8.0,
          ),
          confirmButton(),
        ],
      ),
    );
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    return null;
  }

  Widget loginForm() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              key: const ValueKey(1),
              validator: controller.validator.emailValidator(),
              onSaved: (value) {
                controller.userEmail = value!;
              },
              onChanged: (value) => controller.userEmail = value,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: AppColors.primaryNormal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryNormal),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryNormal),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  hintText: 'email',
                  hintStyle:
                      TextStyle(fontSize: 14, color: AppColors.primaryNormal),
                  contentPadding: EdgeInsets.all(10)),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              obscureText: true,
              key: const ValueKey(2),
              validator: controller.validator.passwordValidator(),
              onSaved: (value) {
                controller.userPassword = value!;
              },
              onChanged: (value) => controller.userPassword = value,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppColors.primaryNormal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryNormal),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryNormal),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  hintText: 'password',
                  hintStyle:
                      TextStyle(fontSize: 14, color: AppColors.primaryNormal),
                  contentPadding: EdgeInsets.all(10)),
            )
          ],
        ),
      ),
    );
  }

  Widget confirmButton() {
    return SizedBox(
      width: double.maxFinite,
      child: FilledButton(
          onPressed: Throttler.to.run(action: controller.login(formKey)),
          style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryNormal,
              side: const BorderSide(color: AppColors.primaryNormal),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          child: PillowponText.mob14w700(
              text: "LOG IN", color: AppColors.primaryWhite)),
    );
  }
}
