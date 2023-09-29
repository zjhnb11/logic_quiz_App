import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:log_app/myappstate.dart';
import 'package:log_app/api.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return _portraitLayout(
          context, ref, usernameController, passwordController);
    } else {
      return _landscapeLayout(
          context, ref, usernameController, passwordController);
    }
  }

  Widget _portraitLayout(
      BuildContext context,
      WidgetRef ref,
      TextEditingController usernameController,
      TextEditingController passwordController) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(234, 12, 122, 231),
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _commonWidgets(
                context, ref, usernameController, passwordController),
          ),
        ),
      ),
    );
  }

  Widget _landscapeLayout(
      BuildContext context,
      WidgetRef ref,
      TextEditingController usernameController,
      TextEditingController passwordController) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(234, 12, 122, 231),
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _commonWidgets(
                  context, ref, usernameController, passwordController),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _commonWidgets(
      BuildContext context,
      WidgetRef ref,
      TextEditingController usernameController,
      TextEditingController passwordController) {
    return [
      TextField(
        controller: usernameController,
        decoration: const InputDecoration(
          labelText: 'Username',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 20),
      TextField(
        controller: passwordController,
        decoration: const InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
        obscureText: true,
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () async {
          // Replace this with your login logic
          bool success = await login(usernameController.text,
              passwordController.text, ref.read(appStateProvider));
          //登陆验证
          if (success) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Login successful')));
            context.go('/quiz');
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Login failed')));
            context.go('/login');
          }
        },
        child: Text('Login'),
      ),
      ElevatedButton(
        onPressed: () {
          // Navigate to Register Screen
          context.go('/login/register');
        },
        child: Text('Register'),
      ),
      ElevatedButton(
        onPressed: () {
          // Navigate to Forgot Password Screen
          context.go('/login/forgotpassword');
        },
        child: Text('Forgot Password'),
      ),
    ];
  }
}
