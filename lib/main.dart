import 'package:flutter/material.dart';
import 'package:gemini_app/screen/home/controller/home_controller.dart';
import 'package:gemini_app/utils/app_routes.dart';
import 'package:gemini_app/utils/app_theme.dart';
import 'package:get/get.dart';

void main() {
  HomeController controller = Get.put(HomeController());
  controller.changeTheme();
  runApp(
    Obx(
      () =>  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: app_routes,
        theme: controller.isTheme.value == false ?light :dark,
      ),
    ),
  );
}
