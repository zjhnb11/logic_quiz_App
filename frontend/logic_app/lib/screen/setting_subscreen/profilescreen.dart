import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(234, 12, 122, 231),
          actions: [
            //
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('profile'),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
