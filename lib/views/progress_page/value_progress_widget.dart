import 'package:flutter/material.dart';
import 'package:keep_up_work/models/value_progress.dart';

class ValueProgressWidget extends StatelessWidget {
  final ValueProgress item;
  const ValueProgressWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: item.displayColor,
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(item.goal ?? 'No Goal!'),
      ),
    );
  }
}
