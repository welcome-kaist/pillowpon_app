import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
abstract class BaseView<Controller extends GetxController>
    extends GetView<Controller> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  BaseView({super.key});

  Widget body(BuildContext context);
  PreferredSizeWidget? appBar(BuildContext context);
  Widget? bottomNavigationBar(BuildContext context) => null;
  bool? extendBodyBehindAppBar;
  Widget? drawer(BuildContext context) => null;
  Widget? endDrawer(BuildContext context) => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      appBar: appBar(context),
      body: body(context),
      bottomNavigationBar: bottomNavigationBar(context),
      drawer: drawer(context),
      endDrawer: endDrawer(context),
    );
  }
}
