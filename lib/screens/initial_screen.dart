import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacity = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.add), title: const Text("Tarefas")),
      body: AnimatedOpacity(
        opacity: opacity ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: const [
            Task(
              "Aprender Flutter",
              "assets/images/aprender-flutter.jpg",
              5,
            ),
            Task(
              "Andar de Bike",
              "assets/images/andar-de-bike.jpg",
              3,
            ),
            Task(
              "Cozinhar",
              "assets/images/cozinhar.jpg",
              4,
            ),
            Task(
              "Meditar",
              "assets/images/meditar.jpg",
              2,
            ),
            Task(
              "Atividade Física",
              "assets/images/exercicio-fisico.jpg",
              5,
            ),
            Task(
              "Ler Livro",
              "assets/images/ler-livro.jpg",
              1,
            ),
            SizedBox(height: 80,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacity = !opacity;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}