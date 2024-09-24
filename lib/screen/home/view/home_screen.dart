import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/screen/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../utils/helper/shared_helper.dart';
import '../model/gemini_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  TextEditingController txtSearch = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.initSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
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
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 5, right: 0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // const Text("Hello"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Gemini app",
                          style: TextStyle(fontSize: 22),
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: const Text("History"),
                                onTap: () {
                                  Get.toNamed('/history');
                                },
                              ),
                              PopupMenuItem(
                                child: const Text("Theme"),
                                onTap: () {
                                  Get.defaultDialog(
                                    title: "Theme",
                                    actions: [
                                      Obx(
                                        () => Switch(
                                          value: controller.isTheme.value,
                                          onChanged: (value) {
                                            controller.isTheme.value = value;
                                            SharedHelper.helper.setData(
                                                controller.isTheme.value);
                                          },
                                        ),
                                      )
                                    ],
                                    content: const Text("Change theme"),
                                  );
                                },
                              ),
                            ];
                          },
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.geminiList.length,
                            itemBuilder: (context, index) {
                              return index % 2 == 0
                                  ? Container(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        // color: Colors.blue,
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Text(
                                          controller.geminiList[index],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: controller.isTheme.value == true
                                              ? Colors.black
                                              : Colors.white,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Obx(
                                          () =>  AnimatedTextKit(
                                            isRepeatingAnimation: false,
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                speed: const Duration(milliseconds: 12),
                                                controller.geminiList[index],
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  // color: controller.isTheme.value ==
                                                  //         true
                                                  //     ? Colors.white
                                                  //     : Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                    ),
                    // ValueListenableBuilder(valueListenable: controller.isCheck,
                    //   builder: (context, value, child) {
                    //     if (value) {
                    //       return   Center(
                    //           child: LoadingAnimationWidget.horizontalRotatingDots(
                    //               color: Colors.yellow, size: MediaQuery
                    //               .sizeOf(context)
                    //               .width * 0.1));
                    //     }
                    //     return SizedBox();
                    //   },),
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
                              onPressed: () {
                                controller.speechToText.isNotListening ? controller.startSpeech():controller.stopSpeech();
                                print("============================${controller.speechToText.isListening ? controller.lastWords : controller.isEnabled}");
                              },
                              icon: const Icon(Icons.mic),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.08,
                              width: MediaQuery.sizeOf(context).width * 0.69,
                              child: TextFormField(
                                controller: txtSearch,
                                validator: (value) {
                                  if(value!.isEmpty)
                                    {
                                      return "Enter message";
                                    }
                                },
                                decoration: const InputDecoration(
                                  hintText: "Type here",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: controller.isCheck,
                              builder: (context, value, child) {
                                if (value) {
                                  print("==========================on$value");
                                  return LoadingAnimationWidget.threeArchedCircle(
                                      color: controller.isTheme.value == true
                                          ? Colors.white
                                          : Colors.black,
                                      size:
                                          MediaQuery.sizeOf(context).width * 0.1);
                                }
                                print(
                                    "==================================off$value");
                                return SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.1,
                                  child: IconButton(
                                    onPressed: () {
                                      if(formKey.currentState!.validate())
                                        {
                                      controller.geminiList.add(txtSearch.text);
                                      controller.getData(txtSearch.text);
                                      txtSearch.clear();
                                      }
                                    },
                                    icon: const Icon(Icons.send),
                                  ),
                                );
                              },
                              child: IconButton(
                                onPressed: () {
                                  // controller.getData(txtSearch.text);
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomSheet: Text("hello"),
    );
  }
}
