import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:core';
import 'myapp.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}
