import 'package:get/get.dart';
import '../../../utils/API_helper.dart';
import '../model/gemini_model.dart';

class HomeController extends GetxController
{
   GeminiModel? model;
   RxList<String> geminiList = <String>[].obs;

 void getData(String search)
    async{
    model = await APIHelper.helper.getData(search);
    geminiList.add(search);
    geminiList.add(model!.candidates[0].content.parts[0].text);  // model.then((value) {
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
}