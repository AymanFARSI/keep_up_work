import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keep_up_work/models/step_model.dart';
import 'package:keep_up_work/models/steps_progress.dart';
import 'package:keep_up_work/src/variables/var_database.dart';

class StepsProgressDetails extends StatefulWidget {
  final StepsProgress progress;
  const StepsProgressDetails({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  State<StepsProgressDetails> createState() => _StepsProgressDetailsState();
}

class _StepsProgressDetailsState extends State<StepsProgressDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(9.0),
        color: widget.progress.displayColor!.withOpacity(0.4),
        height: Get.height - kToolbarHeight - 25,
        width: Get.width,
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.progress.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    DateFormat.yMMMd().format(widget.progress.dateCreated!),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Goal',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 8),
            Text(
              widget.progress.goal!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16),
            Text(
              'Progress',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: (40 * widget.progress.steps.length).toDouble(),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  StepModel step = widget.progress.steps[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    height: 40,
                    child: ListTile(
                      title: Text(
                        step.label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: IconButton(
                        icon: Icon(
                          step.isDone
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: step.isDone ? Colors.green : Colors.grey,
                        ),
                        onPressed: () async {
                          widget.progress.steps[index].isDone = !step.isDone;
                          await dbLayer.updateStepProgress(widget.progress);
                          setState(() {});
                        },
                      ),
                      trailing: Text(
                        '${step.value}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.progress.steps.length,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Note',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 8),
            Text(
              widget.progress.note!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
