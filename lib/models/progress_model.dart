import 'package:flutter/material.dart' show Color, Colors;

class ProgressModel {
  int progressId;
  String title;
  DateTime? dateCreated;
  Color? displayColor;
  bool? isCompleted;
  String? goal;
  String? note;

  ProgressModel({
    required this.progressId,
    required this.title,
    this.dateCreated,
    this.displayColor,
    this.isCompleted,
    this.goal,
    this.note,
  }) {
    note ??= '';
    goal ??= '';
    isCompleted ??= false;
    displayColor ??= Colors.white;
    dateCreated ??= DateTime.now();
  }
}
