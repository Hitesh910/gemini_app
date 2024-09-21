import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../utils/API_helper.dart';
import '../../../utils/helper/shared_helper.dart';
import '../model/gemini_model.dart';

class HomeController extends GetxController
{
   GeminiModel? model;
   RxList<String> geminiList = <String>[].obs;
   ValueNotifier<bool> isCheck =  ValueNotifier(false);
   RxBool isTheme = false.obs;

 void getData(String search)
    async{
      isCheck.value = true;
    model = await APIHelper.helper.getData(search);

    geminiList.add(model!.candidates[0].content.parts[0].text);
    isCheck.value = false;
    // model.then((value) {
    //   if(model!=null){
    //     geminiList.addAll(model);
    //   }
    // },);
    // model!.then((value) {
    //
    // },);
    // if(model1!= null)
    //   {
    //     model?.value = model1;
    //     return "Data is Come";
    //   }
    // return "Data is noting";
  }

  void changeTheme()
 async {
  bool? theme  =await SharedHelper.helper.getData();
  isTheme.value = theme ?? false;
  }
}