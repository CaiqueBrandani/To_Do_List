import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/services/auth_check.dart';
import 'package:lista_de_tarefas/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicialização dos módulos e da conexão do firebase com o servidor do firebase
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const ToDoListApp(),
    ),
  );
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthCheck(),
    );
  }
}