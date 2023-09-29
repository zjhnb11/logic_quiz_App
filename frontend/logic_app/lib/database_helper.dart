import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'questions10.dart';
import 'dart:core';

class DatabaseHelper {
  static final _databaseName = "questions.db";
  static final _databaseVersion = 1;

  static final table = 'questions';

  static final columnId = 'task_id';
  static final columnQuestion = 'question';
  static final columnOptions = 'options';
  static final columnAnswerIndex = 'answerIndex';
  static final columnExplanation = 'explanation';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnQuestion TEXT NOT NULL,
            $columnOptions TEXT NOT NULL,
            $columnAnswerIndex INTEGER NOT NULL,
            $columnExplanation TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Question question) async {
    Database db = await database;
    var res = await db.insert(table, question.toJson());
    return res;
  }

//getQuestions(): This method retrieves all questions from the questions table and returns a list of Question objects.
  Future<List<Question>> getQuestions() async {
    Database db = await database;
    var res = await db.query(table);
    List<Question> list =
        res.isNotEmpty ? res.map((c) => Question.fromJson(c)).toList() : [];
    return list;
  }

//clearQuestions(): This method deletes all data from the questions table.
  Future<void> clearQuestions() async {
    var db = await database;
    await db.delete('questions');
    // Assume your table is named 'questions'
  }
}
