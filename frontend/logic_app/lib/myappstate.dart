import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:core';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:log_app/questions10.dart';
import 'package:log_app/api.dart';
import 'package:log_app/database_helper.dart';

final appStateProvider = ChangeNotifierProvider((ref) => MyAppState());

final questionsProvider = StateProvider<List<Question>?>((ref) => null);

class MyAppState extends ChangeNotifier {
  final userAnswers = List<String?>.filled(10, null);
//useranswer is a list used to store the user's answer. The length of the list is the number of questions.
//Each element is a string used to store the user's answer.
  int tasksCompleted = 0;
  int tasksFailed = 0;
  List<Question>? questions;
  int _currentQuestionIndex = 0;
  int get currentQuestionIndex => _currentQuestionIndex;
  //currentQuestionIndex can be accessed outside the class, but it cannot be modified (because no setter is provided).
  //This is a way of encapsulation to ensure that only the MyAppState class can change _currentQuestionIndex.
  final explanations = List<String?>.filled(10, null);
  List<bool> correctAnswers = List<bool>.filled(10, false);
  double get accuracy => tasksCompleted / (tasksCompleted + tasksFailed);
  // Calculate accuracy
  String? currentUsername;
  List<Map<String, dynamic>> topUsers = [];
  Map<int, bool> taskStatus = {};
  // Add a new field, the key is task_id, the value is the status of the task (true means correct, false means wrong)

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void updateUserAnswer(int index, String? value) {
    userAnswers[index] = value;
    _currentQuestionIndex = index;
    notifyListeners();
  }

  void updateExplanation(int index, String? explanation) {
    explanations[index] = explanation;
    notifyListeners();
  }

  void setQuestions(List<Question> newQuestions) {
    questions = newQuestions;
    notifyListeners();
  }

  void LogoutConfirmation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Are you sure you want to reset the statistics?'),
        action: SnackBarAction(
          label: 'Reset',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
    notifyListeners();
  }

  void _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    tasksCompleted = prefs.getInt('tasksCompleted') ?? 0;
    tasksFailed = prefs.getInt('tasksFailed') ?? 0;
    notifyListeners();
  }

  void checkAnswers(List<Question> questions) {
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == questions[i].options[questions[i].answerIndex]) {
        correctAnswers[i] = true;
        tasksCompleted++;
        taskStatus[questions[i].taskId] = true;
        // Update the status of task_id to be correct
      } else {
        correctAnswers[i] = false;
        tasksFailed++;
        taskStatus[questions[i].taskId] = false;
        // Update the status of task_id to error
      }
    }
    notifyListeners();
  }

  Future<void> submitStats() async {
    //check weather any user logged in
    if (currentUsername == null) {
      print("No user is logged in.");
      return;
    }
    double score = accuracy * 10;
    Map<String, dynamic> stats = {
      'username': currentUsername,
      'score': score,
      'correctQuestions': correctAnswers
          .asMap()
          .entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList(),
      //Convert the correctAnswers list into a Map where the keys are indices and the values are booleans (indicating whether the answer is correct).
      //Use where to filter out correct or incorrect answers. Use map to get the indices (i.e. question numbers) of these answers.
      //Use toList() to convert the result back to a list.
      'incorrectQuestions': correctAnswers
          .asMap()
          .entries
          .where((e) => !e.value)
          .map((e) => e.key)
          .toList(),
      'accuracy': accuracy,
      'task_id':
          taskStatus.map((key, value) => MapEntry(key.toString(), value)),
      // Modify the task_id field to ensure that all keys are string types
    };
    try {
      await submitStatistics(stats);
    } catch (e) {
      print("Failed to submit statistics: $e");
    }
  }

  void logout() {
    currentUsername = null;
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('username');
    });
    notifyListeners();
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    currentUsername = prefs.getString('username');
    notifyListeners();
  }

  void _loadQuestions() async {
    var dbHelper = DatabaseHelper.instance;
    questions = await dbHelper.getQuestions();
    notifyListeners();
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = !_isDarkMode;
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }
}
