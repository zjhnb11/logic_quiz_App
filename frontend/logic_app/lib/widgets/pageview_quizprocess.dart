import 'package:flutter/material.dart';

class PageView_Quizprocess extends StatelessWidget {
  final PageController controller;

  PageView_Quizprocess({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: controller,
        children: [
          Center(
              child: Text(
                  'In this program you will complete questions on propositional logic and first-order logic')),
          Center(
              child: Text(
                  'Each quiz consists of 10 questions, and each question has only one correct answer.')),
          Center(
              child: Text(
                  'After completing each question, you can slide to the next question, or click the next button in the upper right corner to go to next questions.')),
          Center(
              child: Text(
                  'After answering all the questions, you can click the finish button, and then you can see the explanations for the wrong questions in the explanation column. And your scores will be sent to the backend. You can also see your current accuracy rate and the three users with the best scores so far in the statistics column.')),
        ],
      ),
    );
  }
}
