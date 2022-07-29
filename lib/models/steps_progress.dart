import 'package:keep_up_work/models/progress_model.dart';
import 'package:flutter/material.dart' show Color;
import 'package:keep_up_work/models/step_model.dart';

class StepsProgress extends ProgressModel {
  List<StepModel> steps;
  StepsProgress({
    required int id,
    required String title,
    required this.steps,
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
        );
}
