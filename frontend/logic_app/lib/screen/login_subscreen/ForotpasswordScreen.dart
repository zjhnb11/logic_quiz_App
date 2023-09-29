import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:log_app/api.dart';

class ForgotpasswordScreen extends ConsumerWidget {
  const ForgotpasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    bool usernameExists = false;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(234, 12, 122, 231),
        title: const Text('Login--asdfgh'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      // Check if username exists
                      usernameExists =
                          await checkUsername(usernameController.text);
                      if (usernameExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Username exists')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Username not found')));
                      }
                    },
                    child: Text('Check Username'),
                  ),
                ],
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
                  if (usernameExists) {
                    // Logic for updating password
                    bool success = await updatePassword(
                        usernameController.text, passwordController.text);
                    if (success) {
                      // Display a message that the password has been updated successfully and jump to the login page
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password reset successful')));
                      context.go('/login');
                    } else {
                      // Display password update failed message
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password reset failed')));
                    }
                  }
                },
                child: Text('Reset password Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
