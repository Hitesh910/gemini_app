import 'package:flutter/material.dart';
import 'package:gemini_app/screen/home/controller/home_controller.dart';
import 'package:get/get.dart';

import '../model/gemini_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  TextEditingController txtSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    // controller.getData(txtSearch.text);
    // print("+=======================================${data}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gemini app"),
      ),
      body: Column(
        children: [
          // const Text("Hello"),
          Obx(
            () =>  Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(itemCount: controller.geminiList.length,itemBuilder: (context, index) {
                    return index % 2==0?Container(alignment: Alignment.centerRight,child: Text(controller.geminiList[index])):Container(alignment: Alignment.centerLeft,child: Text(controller.geminiList[index]));
                  },),
                ),

            ),
          ),
          // Expanded(
          //   child: FutureBuilder(
          //     future: controller.model,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return Text("============${snapshot.error}");
          //       } else if (snapshot.hasData) {
          //         GeminiModel? model = snapshot.data;
          //
          //         if (model != null) {
          //           controller.geminiList.addAll(model.candidates!);
          //           model.candidates!.clear();
          //         } else if (controller.geminiList.isEmpty) {
          //           return const Text("Search another topic");
          //         }
          //         return Expanded(
          //           child: ListView.builder(
          //             itemCount: controller.geminiList.length,
          //             itemBuilder: (context, index) {
          //               print(
          //                   "===========================================List data${controller.geminiList.length}");
          //               return Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Text(
          //                   "${controller.geminiList[index].content!.parts?[index].text}",
          //                 ),
          //               );
          //             },
          //           ),
          //         );
          //       }
          //       return const Center(child: CircularProgressIndicator());
          //     },
          //   ),
          // ),
          // const Spacer(),
          Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.08,
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    child: TextFormField(
                      controller: txtSearch,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.getData(txtSearch.text);
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // bottomSheet: Text("hello"),
    );
  }
}
