import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keep_up_work/models/value_progress.dart';

class ValueProgressDetails extends StatelessWidget {
  final ValueProgress progress;
  const ValueProgressDetails({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxBarWidth = Get.width;
    double percentage = (progress.currentValue ?? 0) / progress.totalValue;
    double barWidth = percentage * maxBarWidth;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: progress.displayColor!.withOpacity(0.7),
        height: Get.height,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    progress.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    DateFormat.yMMMd().format(progress.dateCreated!),
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
              progress.goal!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16),
            Text(
              'Progress',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 8),
            Stack(
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
                        color: progress.displayColor,
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
            const SizedBox(height: 16),
            Text(
              'Note',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 8),
            Text(
              progress.note!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
