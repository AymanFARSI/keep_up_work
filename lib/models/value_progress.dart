import 'package:keep_up_work/models/progress_model.dart';
import 'package:flutter/material.dart' show Color;

class ValueProgress extends ProgressModel {
  int totalValue;
  int? currentValue;
  String name;
  ValueProgress({
    required int id,
    required String title,
    required this.totalValue,
    this.currentValue,
    required this.name,
    DateTime? dateCreated,
    Color? displayColor,
    bool? isCompleted,
    String? goal,
    String? note,
  }) : super(
          progressId: id,
          title: title,
          dateCreated: dateCreated,
          displayColor: displayColor,
          isCompleted: isCompleted,
          goal: goal,
          note: note,
        ) {
    currentValue ??= 0;
  }
}
