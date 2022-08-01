import 'package:flutter/material.dart';
import 'package:keep_up_work/models/steps_progress.dart';

class StepsProgressDetails extends StatelessWidget {
  final StepsProgress progress;
  const StepsProgressDetails({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Details ${progress.title}'),
    );
  }
}
