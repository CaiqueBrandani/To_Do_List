import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/services/auth_services.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthService>().logout();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Sair',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
