import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/difficulty.dart';
import 'package:primeiro_projeto/data/new_task_dao.dart';
import 'package:primeiro_projeto/data/task_dao.dart';

class Task extends StatefulWidget {
  final String name;
  final String image;
  final int difficulty;
  int nivel;
  int maestryLevel = 1;

  Task(this.name, this.image, this.difficulty, [this.nivel = 0, Key? key])
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();

  int actualLevel() {
    return nivel;
  }
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.image.contains("http")) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        Container(
          //color: Colors.blue,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (widget.maestryLevel == 1)
                ? Colors.blue
                : (widget.maestryLevel == 2)
                    ? Colors.green
                    : (widget.maestryLevel == 3)
                        ? Colors.yellow
                        : (widget.maestryLevel == 4)
                            ? Colors.orange
                            : (widget.maestryLevel == 5)
                                ? Colors.red
                                : (widget.maestryLevel == 6)
                                    ? Colors.pink
                                    : (widget.maestryLevel == 7)
                                        ? Colors.black
                                        : Colors.black,
          ),
          height: 140,
        ),
        Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black26,
                        ),
                        width: 72,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: (assetOrNetwork())
                              ? Image.asset(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Difficulty(
                            difficultyLevel: widget.difficulty,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 52,
                        height: 52,
                        child: ElevatedButton(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Alerta!"),
                                  content:
                                      const Text("Deseja excluir a tarefa?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        NewTaskDao().delete(widget.name);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Sim"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancelar"),
                                    ),
                                  ],
                                );
                              },
                            ); //
                          },
                          onPressed: () {
                            setState(
                              () {
                                widget.nivel++;
                                // if (widget.nivel / widget.difficulty > 10) {
                                //   widget.maestryLevel++;
                                //   if (widget.maestryLevel <= 7) {
                                //     widget.nivel = 1;
                                //   }
                                // }
                              },
                            );
                          NewTaskDao().addTask(Task(widget.name, widget.image, widget.difficulty, widget.nivel));

                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                "UP",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      color: Colors.white,
                      value: (widget.difficulty > 0)
                          ? (widget.nivel / widget.difficulty) / 10
                          : 1,
                    ),
                  ),
                  Text("Nivel: ${widget.nivel}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
