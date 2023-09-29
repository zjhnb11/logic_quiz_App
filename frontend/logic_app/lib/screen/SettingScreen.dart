import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log_app/widgets/logout_confirm.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(234, 12, 122, 231),
        actions: [],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Info of creater'),
            onTap: () {
              context.go('/settings/info');
            },
          ),
          LogoutConfirmation(),
        ],
      ),
    );
  }
}
