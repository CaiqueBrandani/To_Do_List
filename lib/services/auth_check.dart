import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/pages/login.dart';
import 'package:lista_de_tarefas/pages/todo_list_page.dart';
import 'package:lista_de_tarefas/services/auth_services.dart';
import 'package:provider/provider.dart';


class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.user == null) {
      return const LoginPage();
    } else {
      return TodoListPage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}