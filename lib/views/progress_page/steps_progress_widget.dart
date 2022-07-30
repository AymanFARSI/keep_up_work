// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_up_work/models/step_model.dart';
import 'package:keep_up_work/models/steps_progress.dart';

class StepsProgressWidget extends StatelessWidget {
  final StepsProgress item;
  const StepsProgressWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime daysSince =
        DateTime.now().subtract(item.dateCreated!.timeZoneOffset);
    double maxBarWidth = Get.width * 0.8;
    int totalStepsValue = item.steps.fold(0, (acc, step) => acc + step.value);
    int totalStepsDoneValue = item.steps
        .where((element) => element.isDone)
        .fold(0, (acc, step) => acc + step.value);
    double percentage = totalStepsDoneValue / totalStepsValue;
    double barWidth = percentage * maxBarWidth;
    String title =
        '${item.title}${percentage > 0.8 ? ' (${(percentage * 100).toStringAsFixed(0)}%)' : ''}';
    return SizedBox(
      height: 100,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                item.goal ?? 'No Goal!',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              trailing: Text(
                '${daysSince.day}\ndays',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    Container(
                      width: maxBarWidth,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: barWidth,
                          height: 20,
                          decoration: BoxDecoration(
                            color: item.displayColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        if (percentage < 0.8)
                          Text(
                            '${(percentage * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
IconButton(
                icon: const Icon(Icons.delete_forever_rounded),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete ${item.title}?'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await dbLayer.deleteStepsProgress(item);
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
 */
