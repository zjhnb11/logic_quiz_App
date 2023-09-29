import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log_app/myappstate.dart';
import 'package:log_app/api.dart';
import 'package:log_app/questions10.dart';

class StatisticialScreen extends ConsumerWidget {
  const StatisticialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch<MyAppState>(appStateProvider);

    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(234, 12, 122, 231),
      ),
      body: Center(
        child: FutureBuilder<List<TopUser>>(
          future: fetchTopUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final topUsers = snapshot.data ?? [];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Statistics'),
                  const SizedBox(height: 20),
                  Text(
                      'Correct Questions: ${appState.correctAnswers.where((e) => e).length}'),
                  const SizedBox(height: 20),
                  Text(
                      'Incorrect Questions: ${appState.correctAnswers.where((e) => !e).length}'),
                  const SizedBox(height: 20),
                  Text(
                      'Accuracy: ${(appState.accuracy * 100).toStringAsFixed(2)}%'),
                  const SizedBox(height: 20),
                  const Text('Top 3 Users:'),
                  if (topUsers.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: topUsers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(topUsers[index].username),
                          subtitle: Text('Score: ${topUsers[index].score}'),
                        );
                      },
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
