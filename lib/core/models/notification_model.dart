import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uid = Uuid();
final formatter = DateFormat.yMd();

enum Categories { food, travel, home, work, shopping }

const categoryIcons = {
  Categories.food: Icons.lunch_dining_outlined,
  Categories.travel: Icons.card_travel_outlined,
  Categories.home: Icons.home_outlined,
  Categories.work: Icons.work_history_outlined,
  Categories.shopping: Icons.shopping_bag_outlined,
};

class NotificationModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate {
    return formatter.format(date);
  }

  NotificationModel(
      {required this.date,
      required this.category,
      required this.title,
      required this.amount})
      : id = uid.v4();
}
