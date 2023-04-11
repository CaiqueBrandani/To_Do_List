import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/services/auth_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  // Controllers são objetos que você pode anexar a determinados Widgets e, em seguida, usar 
  // esses objetos para controlar o comportamento desse Widget.
  final email = TextEditingController();
  final password = TextEditingController();
  bool _passwordVisible = true;
  bool isLogin = true;
  bool loading = false;
  
  late String titulo;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao){
    setState(() {
      isLogin = acao;
      if(isLogin = acao) {
        titulo = 'Bem Vindo!';
        actionButton = 'Logar';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora';
      } else {
        titulo = 'Crie sua conta!';
        actionButton = 'Cadastrar-se';
        toggleButton = 'Já possui conta? faça o login';
      }
    });
  }

  login() async {
    setState(() => loading = true);

    try {
      await context.read<AuthService>().login(email.text, password.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text(e.message))));
    }
  }

  register() async {
    setState(() => loading = true);

    try {
      await context.read<AuthService>().register(email.text, password.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text(e.message))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/image/logoUnifei.png'),
                  ),
      
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.5,
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo de email não pode estar vazio!';
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible? 
                            Icons.visibility_outlined : 
                            Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        labelText: 'Senha',
                        border: const OutlineInputBorder(),
                      ),
                      obscureText: _passwordVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe a sua senha!';
                        } else if (value.length < 6) {
                          return 'Sua senha deve ter no mínimo 6 caracteres!';
                        }
                        return null;
                      },
                    ),
                  ),
                  
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (isLogin) {
                          login();
                        } else {
                          register();
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        actionButton,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ), 
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () => setFormAction(!isLogin), 
                      child: Text(toggleButton),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
