import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.Md();
const uuid = Uuid();

enum Category { food, clothing, utilities, transportation, other } //predefined allowed values

const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.clothing: Icons.shopping_bag_rounded,
  Category.utilities: Icons.water_damage_rounded,
  Category.transportation:  Icons.car_crash_rounded,
  Category.other: Icons.plus_one_rounded,
};

class Expense{
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //dart feature for personal ids

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; //use the new enum

  String get formattedDate{
    return formatter.format(date);
  }
}