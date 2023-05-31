import 'package:flutter/material.dart';
import 'package:budgetapp/widgets/expenses.dart';

var _ColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 200, 130, 218));

void main() {
  runApp(
     MaterialApp(
        theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: _ColorScheme,
        ),
        home: const Expenses(),
      ),
  );
}
