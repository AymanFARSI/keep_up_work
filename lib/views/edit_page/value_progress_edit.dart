import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_up_work/models/value_progress.dart';

class ValueProgressEdit extends StatefulWidget {
  final ValueProgress progress;
  const ValueProgressEdit({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  State<ValueProgressEdit> createState() => _ValueProgressEditState();
}

class _ValueProgressEditState extends State<ValueProgressEdit> {
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
