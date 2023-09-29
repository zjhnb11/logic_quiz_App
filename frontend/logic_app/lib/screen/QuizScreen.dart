import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:log_app/myappstate.dart';
import 'package:log_app/api.dart';
import 'package:log_app/database_helper.dart';
import 'package:log_app/Internet.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsNotifier = ref.read(questionsProvider.notifier);

    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          shadowColor: const Color.fromARGB(234, 12, 122, 231),
          actions: [],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ready to quiz?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  bool isOnline = await checkInternetConnection();

                  var dbHelper = DatabaseHelper.instance;
                  print("dbHelpe ok");
                  print("questionsFromDb ok");

                  if (isOnline) {
                    await dbHelper.clearQuestions();
                    var questionsFromApi = await fetchQuestions();
                    //Iterate through each question fetched from the API and insert it into the SQLite database using the dbHelper.insert(question) method.
                    for (var question in questionsFromApi) {
                      await dbHelper.insert(question);
                    }
                    questionsNotifier.state = questionsFromApi;
                  } else {
                    var questionsFromDb = await dbHelper.getQuestions();
                    questionsNotifier.state = questionsFromDb;
                  }

                  context.go('/quiz/quiz_process');
                },
                child: const Text('Start Quiz'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
