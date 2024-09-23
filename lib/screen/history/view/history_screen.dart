import 'package:flutter/material.dart';
import 'package:gemini_app/screen/home/controller/home_controller.dart';
import 'package:get/get.dart';

import '../../../utils/helper/db_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.dbData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: controller.isTheme.value == true
                      ? const AssetImage("assets/images/img.jpg")
                      : const AssetImage("assets/images/img2.jpg"),
                  fit: BoxFit.fill),
            ),
          ),
          Obx(
            () => ListView.builder(
              itemCount: controller.historyList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onLongPress: () {
                        Get.defaultDialog(
                          title: "Delete",
                          content: const Text("Delete data"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                DbHelper.helper.deleteData(
                                    controller.historyList[index].i!);
                                controller.dbData();
                                Get.back();
                              },
                              child: const Text("Yes"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("No"),
                            )
                          ],
                        );
                      },
                      child: Container(
                        alignment: controller.historyList[index].status == 0
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          // color: Colors.red,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: controller.historyList[index].status == 0
                                ? Colors.blue
                                : controller.isTheme.value == true
                                    ? Colors.black
                                    : Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                            ),
                          ),
                          child: Text(
                            "${controller.historyList[index].search}",
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
