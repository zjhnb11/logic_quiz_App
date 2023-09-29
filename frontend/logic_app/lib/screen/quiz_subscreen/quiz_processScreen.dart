import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log_app/myappstate.dart';

class QuizProcessScreen extends ConsumerWidget {
  const QuizProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch<MyAppState>(appStateProvider);
    final _currentQuestionIndex = appState.currentQuestionIndex;
    final questions = ref.watch(questionsProvider);

    final PageController _pageController = PageController(
      initialPage: _currentQuestionIndex,
      // Set initial page
    );

    if (questions == null || questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No questions available.')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(234, 12, 122, 231),
        actions: [
          TextButton(
            onPressed: () {
              for (int i = 0; i < questions.length; i++) {
                if (appState.userAnswers[i] !=
                    questions[i].options[questions[i].answerIndex]) {
                  appState.updateExplanation(i, questions[i].explanation);
                } else {
                  appState.updateExplanation(i, 'You are correct!');
                }
              }
              // All answers are correct
              appState.checkAnswers(questions);
              // Send statistics to the backend
              appState.submitStats();
            },
            child: const Text('Finish'),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              if (_pageController.page! < questions.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: const Text('Next'),
          )
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          //Create a component for each child element of the page
          //A page is created for each question
          final question = questions[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Question ${index + 1}',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text(question.question,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              for (var option in question.options)
                //Each iteration generates an option
                ListTile(
                  title: Text(option),
                  leading: Radio<String>(
                    value: option,
                    groupValue: appState.userAnswers[index],
                    //appstateuserAnswers[index],
                    onChanged: (String? value) {
                      appState.updateUserAnswer(index, value);
                    },
                  ),
                ),
              Text('Explanation:'),
              Text(
                //If explanations[index] is not null, returns the value of explanations[index].
                //If explanations[index] is null, returns the empty string ''
                appState.explanations[index] ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
