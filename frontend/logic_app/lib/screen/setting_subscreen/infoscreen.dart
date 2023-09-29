import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoScreen extends ConsumerWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(234, 12, 122, 231),
          actions: [],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('logic app_V1.0.0'),
              SizedBox(height: 20),
              Text('Developer Jiahao Zhao'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
