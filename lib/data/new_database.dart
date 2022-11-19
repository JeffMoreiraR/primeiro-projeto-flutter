
import 'package:primeiro_projeto/data/new_task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database>  getNewDataBase() async{
  //final String path = join(await getDatabasesPath(), "newDBTask.db");
  final String path = join(await getDatabasesPath(), "dbteste3.db");
  
  return openDatabase(path, onCreate: ((newDB, version) => newDB.execute(NewTaskDao.newTableSql)), version: 1);
}