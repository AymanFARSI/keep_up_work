import 'package:flutter/material.dart';
import 'package:keep_up_work/models/steps_progress.dart';
import 'package:keep_up_work/src/variables/var_database.dart';

class StepsProgressWidget extends StatelessWidget {
  final StepsProgress item;
  const StepsProgressWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.lightBlueAccent,
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(item.goal ?? 'No Goal!'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever_rounded),
          onPressed: () async {
            await dbLayer.deleteStepProgress(item);
          },
        ),
      ),
    );
  }
}
