import 'package:primeiro_projeto/components/task.dart';
import 'package:primeiro_projeto/data/new_database.dart';
import 'package:sqflite/sqflite.dart';

class NewTaskDao {
  static const String _newTableName = "newTaskTable";
  static const String _name = "name";
  static const String _image = "image";
  static const String _difficulty = "difficulty";
  static const String _nivel = "nivel";

  static const String newTableSql = 'CREATE TABLE $_newTableName('
      '$_name TEXT, '
      '$_image TEXT, '
      '$_difficulty INTEGER, '
      '$_nivel INTEGER)';

  //CRUD

  Future<List<Task>> find(String taskname) async {
    print("Entrando no NOVO find");
    final Database database = await getNewDataBase();
    final List<Map<String, dynamic>> result = await database.query(
      _newTableName,
      where: "$_name = ?",
      whereArgs: [taskname],
    );
    print("Tarefa encontrada no NOVO find : ${toList(result)}");
    return toList(result);
  }

  Future<List<Task>> findAll() async {
    final Database database = await getNewDataBase(); //abre o banco de dados
    final List<Map<String, dynamic>> result = await database
        .query(_newTableName); // busca toda a tabela inteira do banco de dados
    print("Procurando dados no banco de dados... encontrado: $result");
    return toList(
        result); // chama a funcao toList para converter a Lista de Mapa em Lista de tarefas
  }

  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    print("Entrando no toList");
    final List<Task> taskList = [];
    for (Map<String, dynamic> taskLine in taskMap) {
      final Task task = Task(taskLine[_name], taskLine[_image], taskLine[_difficulty], taskLine[_nivel]);
      taskList.add(task);
    }
    print("Mapa convertido em Lista (toList)");
    return taskList;
  }

  //Adicionar tarefa
  addTask(Task task) async {
    print("Entrando no addTask");
    final Database database = await getNewDataBase(); // abre o banco de dados
    var taskExists = await find(task.name);
    Map<String, dynamic> taskConvertedMap = toMap(task);
    if (taskExists.isEmpty) {
      print("A tarefa NOME: ${task.name} não existia");
      return await database.insert(_newTableName, taskConvertedMap);
    } else {
      print("A tarefa NOME: ${task.name} já existe");
      return await database.update(_newTableName, taskConvertedMap, where: "$_name = ?", whereArgs: [task.name]);
    }
  }

  Map<String, dynamic> toMap(Task task) {
    print("Entrando no toMap");

    Map<String, dynamic> taskMap = {};
    taskMap[_name] = task.name;
    taskMap[_image] = task.image;
    taskMap[_difficulty] = task.difficulty;
    taskMap[_nivel] = task.nivel;

    print("Mapa de tarefas: $taskMap");

    return taskMap;
  }

  //Deletar tarefa
  delete(String taskName) async {
    final Database database = await getNewDataBase(); // abre o banco de dados
    print("Deletando tarefa $taskName");
    return database.delete(_newTableName,
        where: "$_name = ?",
        whereArgs: [taskName]); // busca na tabela pelo nome da tarefa e deleta
  }
}
