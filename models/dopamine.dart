import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Dopamine {
  Dopamine({
    required this.title,
    required this.amount,
    required this.date,
    required this.catergory,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category catergory;

  String get formattedDate {
    return formatter.format(date);
  }
}

// ignore: camel_case_types
class dopamineBucket {
  const dopamineBucket({
    required this.category,
    required this.dopamines,
  });

  dopamineBucket.forCategory(List<Dopamine> alldopamines, this.category)
      : dopamines = alldopamines
            .where((dopamine) => dopamine.catergory == category)
            .toList();
  final Category category;
  final List<Dopamine> dopamines;

  double get totaldopamines {
    double sum = 0;
    for (final dopamine in dopamines) {
      sum += dopamine.amount;
    }
    return sum;
  }
}
