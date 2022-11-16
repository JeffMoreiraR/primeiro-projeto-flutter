import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task("Aprender Flutter", "assets/images/aprender-flutter.jpg", 5),
    Task("Andar de Bike", "assets/images/andar-de-bike.jpg", 3),
    Task("Cozinhar", "assets/images/cozinhar.jpg", 4),
    Task("Meditar", "assets/images/meditar.jpg", 2),
    Task("Atividade Física", "assets/images/exercicio-fisico.jpg", 5),
    Task("Ler Livro", "assets/images/ler-livro.jpg", 1),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
