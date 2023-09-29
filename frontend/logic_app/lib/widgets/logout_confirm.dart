import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoutConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Log out'),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Are you sure you want to log out?'),
            action: SnackBarAction(
              label: 'Yes',
              onPressed: () {
                context.go('/login');
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      },
    );
  }
}
