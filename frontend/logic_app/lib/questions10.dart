// This file contains the Question and TopUser classes

class Question {
  final int taskId;
  final String question;
  final List<String> options;
  final int answerIndex;
  final String explanation;

  Question({
    required this.taskId,
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.explanation,
  });
  //All attributes are required because they are marked as required

  factory Question.fromJson(Map<String, dynamic> json) {
    //Map<String, dynamic> is often used to process JSON data, because the keys of JSON objects are always strings,
    //and the values can be of multiple types (such as strings, numbers, booleans, arrays, or other objects)
    return Question(
      taskId: json['task_id'],
      question: json['question'] ?? '',
      options:
          json['options'] != null ? List<String>.from(json['options']) : [],
      answerIndex: json['answerIndex'] ?? 0,
      explanation: json['Explanation'] ?? '',
    );
  }
  //This is a factory constructor that accepts a Map<String, dynamic> type parameter, which represents a key-value pair parsed from JSON data.
  //This constructor is used to extract data from these key-value pairs and create a new Question object.

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'question': question,
      'options': options.join(','),
      'answerIndex': answerIndex,
      'explanation': explanation,
    };
  }
  //Convert the Question object into a Map<String, dynamic> type object, which can be further converted into JSON data
}

List<Question> questionsinfrontend = [
  Question(
      taskId: 1,
      question:
          'Given the statements: ∀x (P(x) → Q(x)) and ∃x P(x), which of the following must be true?',
      options: ['∀x Q(x)', '∃x Q(x)', '∃x ¬Q(x)', '∀x ¬P(x)'],
      answerIndex: 1,
      explanation:
          'If for every x, P(x) implies Q(x), and there exists an x such that P(x) is true, then there must exist an x such that Q(x) is true.'),
  Question(
      taskId: 2,
      question:
          'Given the statements: ∀x (P(x) ∧ Q(x)), which of the following must be true?',
      options: ['∀x P(x)', '∃x ¬Q(x)', '∀x ¬P(x)', '∃x P(x)'],
      answerIndex: 0,
      explanation:
          'If for every x, both P(x) and Q(x) are true, then for every x, P(x) must be true.'),
  Question(
      taskId: 3,
      question:
          'Given the statement: ¬∃x P(x), which of the following must be true?',
      options: ['∀x ¬P(x)', '∃x P(x)', '∀x P(x)', '∃x ¬P(x)'],
      answerIndex: 0,
      explanation:
          'If there does not exist an x such that P(x) is true, then for every x, P(x) must be false.'),
  Question(
      taskId: 4,
      question:
          'Given the statements: ∀x (P(x) → Q(x)) and ∀x ¬Q(x), which of the following must be true?',
      options: ['∀x ¬P(x)', '∃x P(x)', '∃x Q(x)', '∀x P(x)'],
      answerIndex: 0,
      explanation:
          'If for every x, P(x) implies Q(x), and for every x, Q(x) is false, then for every x, P(x) must be false.'),
  Question(
      taskId: 5,
      question:
          'Given the statement: ∀x (P(x) → Q(x)), which of the following is equivalent?',
      options: [
        '∀x (¬P(x) ∨ Q(x))',
        '∀x (P(x) ∧ ¬Q(x))',
        '∃x (P(x) ∧ Q(x))',
        '∃x (¬P(x) ∧ Q(x))'
      ],
      answerIndex: 0,
      explanation:
          'The implication P(x) → Q(x) is equivalent to ¬P(x) ∨ Q(x).'),
  Question(
      taskId: 6,
      question:
          'Given the statement: ¬∀x P(x), which of the following must be true?',
      options: ['∃x ¬P(x)', '∀x ¬P(x)', '∃x P(x)', '∀x P(x)'],
      answerIndex: 0,
      explanation:
          'If it is not the case that for every x, P(x) is true, then there exists an x such that P(x) is false.'),
  Question(
      taskId: 7,
      question:
          'Given the statements: ∃x P(x) and ∀x (P(x) → Q(x)), which of the following must be true?',
      options: ['∃x Q(x)', '∀x Q(x)', '∃x ¬Q(x)', '∀x ¬Q(x)'],
      answerIndex: 0,
      explanation:
          'If there exists an x such that P(x) is true, and for every x, P(x) implies Q(x), then there exists an x such that Q(x) is true.'),
  Question(
      taskId: 8,
      question:
          'Given the statement: ∀x (P(x) ∧ Q(x)), which of the following must be false?',
      options: ['∀x ¬P(x)', '∃x ¬P(x)', '∃x ¬Q(x)', '∀x ¬Q(x)'],
      answerIndex: 0,
      explanation:
          'If for every x, both P(x) and Q(x) are true, then it cannot be the case that for every x, P(x) is false.'),
  Question(
      taskId: 9,
      question:
          'Given the statement: ∃x ¬P(x), which of the following must be true?',
      options: ['¬∀x P(x)', '∀x ¬P(x)', '∀x P(x)', '∃x P(x)'],
      answerIndex: 0,
      explanation:
          'If there exists an x such that P(x) is false, then it cannot be the case that for every x, P(x) is true.'),
  Question(
      taskId: 10,
      question:
          'Given the statements: ∀x ¬P(x) and ∀x ¬Q(x), which of the following must be true?',
      options: [
        '¬∃x (P(x) ∨ Q(x))',
        '∃x (P(x) ∧ Q(x))',
        '∀x (P(x) ∨ Q(x))',
        '∃x (P(x) ∨ Q(x))'
      ],
      answerIndex: 0,
      explanation:
          'If for every x, P(x) is false and Q(x) is false, then there does not exist an x such that either P(x) or Q(x) is true.'),
];

class TopUser {
  final String username;
  final double score;

  TopUser({required this.username, required this.score});

  // Create a TopUser instance from a JSON object
  factory TopUser.fromJson(Map<String, dynamic> json) {
    return TopUser(
      username: json['username'],
      score: json['score'].toDouble(),
    );
  }
}
