// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/routing/routes.dart';
import 'package:keep_up_work/models/value_progress.dart';
import 'package:keep_up_work/src/variables/var_database.dart';
import 'package:keep_up_work/src/variables/var_progress.dart';

class ValueProgressWidget extends StatefulWidget {
  final ValueProgress item;
  const ValueProgressWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<ValueProgressWidget> createState() => _ValueProgressWidgetState();
}

class _ValueProgressWidgetState extends State<ValueProgressWidget> {
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
            height: 150,
            width: Get.width * 0.7,
            child: ListView(
              children: [
                TextButton(
                  child: const Text(
                    'One more done',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onPressed: () async {
                    widget.item.currentValue = widget.item.currentValue! + 1;
                    await dbLayer.updateValueProgress(widget.item);
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                TextButton(
                  child: const Text(
                    'One more not done',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onPressed: () async {
                    widget.item.currentValue = widget.item.currentValue! - 1;
                    await dbLayer.updateValueProgress(widget.item);
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                TextButton(
                  onPressed: () {},
                  onLongPress: () async {
                    await dbLayer.deleteValueProgress(widget.item);
                    listOfValueProgress.remove(widget.item);
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
    DateTime daysSince =
        DateTime.now().subtract(widget.item.dateCreated!.timeZoneOffset);
    double maxBarWidth = Get.width * 0.8;
    double percentage =
        (widget.item.currentValue ?? 0) / widget.item.totalValue;
    double barWidth = percentage * maxBarWidth;
    String title =
        '${widget.item.title}${percentage > 0.9 ? ' (${(percentage * 100).toStringAsFixed(0)}%)' : ''}';
    return GestureDetector(
      onTap: () {
        context.goNamed(
          MyRoutes.DETAILS.name,
          params: {
            'id': widget.item.progressId.toString(),
            'type': 'value',
          },
        );
      },
      onLongPress: () => _showDialog(context),
      child: SizedBox(
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
                  widget.item.goal ?? 'No Goal!',
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
                              color: widget.item.displayColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          if (percentage < 0.9)
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
                            await dbLayer.deleteValueProgress(item);
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
