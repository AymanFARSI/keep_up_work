import 'package:flutter/material.dart';
import 'package:keep_up_work/models/value_progress.dart';

class ValueProgressDetails extends StatelessWidget {
  final ValueProgress progress;
  const ValueProgressDetails({
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
