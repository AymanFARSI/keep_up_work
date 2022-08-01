import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_up_work/models/steps_progress.dart';

class StepsProgressEdit extends StatefulWidget {
  final StepsProgress progress;
  const StepsProgressEdit({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  State<StepsProgressEdit> createState() => _StepsProgressEditState();
}

class _StepsProgressEditState extends State<StepsProgressEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          Center(
            child: Text('Edit ${widget.progress.title}'),
          ),
          Positioned(
            bottom: 7,
            right: 7,
            child: IconButton(
              icon: const Icon(Icons.save_rounded),
              onPressed: () async {
                // TODO: Save progress
              },
            ),
          ),
        ],
      ),
    );
  }
}
