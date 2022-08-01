// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/routing/routes.dart';
import 'package:keep_up_work/models/step_model.dart';
import 'package:keep_up_work/models/steps_progress.dart';
import 'package:keep_up_work/src/variables/var_database.dart';
import 'package:keep_up_work/src/variables/var_progress.dart';

class StepsProgressWidget extends StatefulWidget {
  final StepsProgress item;

  const StepsProgressWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<StepsProgressWidget> createState() => _StepsProgressWidgetState();
}

class _StepsProgressWidgetState extends State<StepsProgressWidget> {
  final RxBool _customTileExpanded = false.obs;

  _showDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text(
              widget.item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SizedBox(
            height: 50,
            width: Get.width * 0.7,
            child: ListView(
              children: [
                TextButton(
                  onPressed: () {},
                  onLongPress: () async {
                    await dbLayer.deleteStepProgress(widget.item);
                    listOfStepsProgress.remove(widget.item);
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Duration daysSince = DateTime.now().difference(widget.item.dateCreated!);
    double maxBarWidth = Get.width * 0.8;
    int totalStepsValue =
        widget.item.steps.fold(0, (acc, step) => acc + step.value);
    int totalStepsDoneValue = widget.item.steps
        .where((element) => element.isDone)
        .fold(0, (acc, step) => acc + step.value);
    double percentage = totalStepsDoneValue / totalStepsValue;
    double barWidth = percentage * maxBarWidth;
    String title =
        '${widget.item.title}${percentage > 0.8 ? ' (${(percentage * 100).toStringAsFixed(0)}%)' : ''}';
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.goNamed(
              MyRoutes.DETAILS.name,
              params: {
                'id': widget.item.progressId.toString(),
                'type': 'steps',
              },
            );
          },
          onLongPress: () => _showDialog(context),
          child: SizedBox(
            height: 100,
            child: Obx(
              () => Card(
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
                        widget.item.goal ?? 'No Goal!',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: Text(
                        '${daysSince.inDays}\ndays',
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 5,
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
                                          color: widget.item.displayColor,
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
                            Expanded(
                              child: IconButton(
                                icon: Icon(
                                  _customTileExpanded.value
                                      ? Icons.arrow_drop_up_rounded
                                      : Icons.arrow_drop_down_rounded,
                                  size: 60,
                                ),
                                onPressed: () {
                                  _customTileExpanded.value =
                                      !_customTileExpanded.value;
                                },
                                splashColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: _customTileExpanded.value,
            child: SizedBox(
              height: (40 * widget.item.steps.length).toDouble(),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  StepModel step = widget.item.steps[index];
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
                      leading: Icon(
                        step.isDone
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: step.isDone ? Colors.green : Colors.grey,
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
                itemCount: widget.item.steps.length,
              ),
            ),
          ),
        ),
      ],
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
