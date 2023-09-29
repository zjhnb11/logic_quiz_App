import 'dart:core';
import 'dart:convert';
import 'package:log_app/myappstate.dart';
import 'package:http/http.dart' as http;
import 'questions10.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Question>> fetchQuestions() async {
  final response = await http.get(Uri.parse('http://localhost:8080/api/task'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    //Decode the JSON data in the HTTP response body into a Dart object and store it in the jsonResponse variable
    return jsonResponse.map((json) => Question.fromJson(json)).toList();
    //The purpose of this line of code is to convert a list of multiple JSON objects into a list of multiple Question objects
  } else {
    throw Exception('Failed to load questions');
  }
}

Future<void> submitStatistics(Map<String, dynamic> stats) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/submit'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(stats),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to submit statistics');
  }
}

//login logic
Future<bool> login(
    String username, String password, MyAppState appState) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    print('Login successful');

    // Update currentUsername in MyAppState
    appState.currentUsername = username;

    // Save user information and persist it
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);

    return true;
  } else {
    print('Login failed');
    return false;
  }
}

Future<bool> register(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/register'),
    // Change this to your registration API
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    print('Registration successful');
    return true;
  } else {
    print('Registration failed');
    return false;
  }
}

Future<bool> checkUsername(String username) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/checkusername'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
    }),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> updatePassword(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/resetpassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<TopUser>> fetchTopUsers() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/api/topusers'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((json) => TopUser.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load top users');
  }
}
