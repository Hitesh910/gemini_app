import 'package:gemini_app/screen/home/model/gemini_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../screen/history/model/history_model.dart';

class DbHelper {
  static DbHelper helper = DbHelper._();

  DbHelper._();

  Database? database;

  Future<Database> checkDb() async {
    if (database == null) {
      database = await initDb();
    }
    return database!;
  }

  Future<Database> initDb() async {
    String folder = await getDatabasesPath();
    String path = "$folder/demo.db";

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query1 = "CREATE TABLE history (cid INTEGER PRIMARY KEY AUTOINCREMENT, history TEXT,status INTEGER)";
print("=================================================== table query${query1}");
        db.execute(query1);
      },
    );
  }

  Future<void> insertData(String search,int i) async {
    database = await checkDb();
     database!.insert('history', {'history':search,'status':i});
  }

  Future<List<HistoryModel>> readData() async {
    database = await checkDb();
    String query = "SELECT * FROM history";
    List<Map> l1 = await database!.rawQuery(query);
    List<HistoryModel> historyList = l1
        .map(
          (e) => HistoryModel.mapToModel(e),
        )
        .toList();

    return historyList;
  }

  Future<void> deleteData(int cid)
  async {
    database = await checkDb();
    print("================================= cid ${cid}");
    String query = "DELETE FROM history WHERE id = $cid";
    database!.delete("history",where: "cid=?",whereArgs:[cid]);
  }
}
