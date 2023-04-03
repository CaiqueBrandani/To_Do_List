import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  // Controllers são objetos que você pode anexar a determinados Widgets e, em seguida, usar 
  // esses objetos para controlar o comportamento desse Widget.
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'exemplo@gmail.com',
                  border: OutlineInputBorder(),
                ),
                onChanged: onChanged,
              ),
      
              ElevatedButton(
                onPressed: login, 
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChanged(String text){
    print(text);
  }

  void login() {
    print(emailController.text);
  }
}