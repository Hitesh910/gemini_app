import 'package:sqflite/sqflite.dart';

class DbHelper
{
  static DbHelper helper = DbHelper._();
  DbHelper._();
  Database? database;

  Future<Database> checkDb()
  async {
    if(database==null)
      {
        // database = await initDb();
      }
    return database!;
  }

  Future<void> initDb()
  async {
    String folder =await getDatabasesPath();
    String path = "$folder/demo.db";
  }
}