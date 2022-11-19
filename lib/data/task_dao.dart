import 'package:primeiro_projeto/components/task.dart';
import 'package:primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      ' $_image TEXT)';

  static const String _tableName = "taskTable";
  static const String _name = "name";
  static const String _image = "image";
  static const String _difficulty = "difficulty";

  save(Task task) async {
    print("Iniciando o Save");
    final Database dataBase = await getDataBase();
    var itemExists = await find(task.name);

    Map<String, dynamic> taskMap = toMap(task);
    if (itemExists.isEmpty) {
      print("A tarefa não existia.");
      return await dataBase.insert(_tableName, taskMap);
    } else {
      print("A tarefa ja existia.");
      return await dataBase.update(_tableName, taskMap,
          where: "$_name = ?", whereArgs: [task.name]);
    }
  }

  Map<String, dynamic> toMap(Task task) {
    print("Converendo Tarefa em Map");

    final Map<String, dynamic> taskMap = {};
    taskMap[_name] = task.name;
    taskMap[_difficulty] = task.difficulty;
    taskMap[_image] = task.image;

    print("O Mapa de tarefas e $taskMap");

    return taskMap;
  }

  Future<List<Task>> findAll() async {
    print("Estamos acessando o findAll");
    final Database dataBase = await getDataBase();
    final List<Map<String, dynamic>> result = await dataBase.query(_tableName);
    print("Procurando dados no banco de dados... encontrado: $result");
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> tasksMap) {
    print("Convertendo Map em List: ");
    final List<Task> tasks = [];
    for (Map<String, dynamic> linha in tasksMap) {
      final Task task = Task(linha[_name], linha[_image], linha[_difficulty]);
      tasks.add(task);
    }
    print("Lista de Tarefas: $tasks");
    return tasks;
  }

  Future<List<Task>> find(String taskName) async {
    print("Acessando o find: ");
    final Database dataBase = await getDataBase();
    final List<Map<String, dynamic>> result = await dataBase.query(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskName],
    );
    print("Tarefa encontrada: ${toList(result)}");
    return toList(result);
  }

  delete(String taskName) async {
    print("Deletando tarefa");
    final Database dataBase = await getDataBase();
    print("Deletando Tarefa $taskName");
    return dataBase.delete(_tableName, where: '$_name = ?', whereArgs: [taskName]);
  }
}
