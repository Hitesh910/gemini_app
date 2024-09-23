import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../utils/API_helper.dart';
import '../../../utils/helper/db_helper.dart';
import '../../../utils/helper/shared_helper.dart';
import '../../history/model/history_model.dart';
import '../model/gemini_model.dart';

class HomeController extends GetxController
{
   GeminiModel? model;
   RxList<String> geminiList = <String>[].obs;
   ValueNotifier<bool> isCheck =  ValueNotifier(false);
   RxBool isTheme = false.obs;
   RxList<HistoryModel> historyList = <HistoryModel>[].obs;

 void getData(String search)
    async{
      isCheck.value = true;
    model = await APIHelper.helper.getData(search);

    geminiList.add(model!.candidates[0].content.parts[0].text);
    isCheck.value = false;

     DbHelper.helper.insertData(search,model!.candidates[0].content.parts[0].text);
  }

  void changeTheme()
 async {
  bool? theme  =await SharedHelper.helper.getData();
  isTheme.value = theme ?? false;
  }

  Future<void> dbData()
  async {
  historyList.value =await DbHelper.helper.readData();
  }

  // void deleteData(int cid)
  // {
  //   DbHelper.helper.deleteData(cid);
  // }
}