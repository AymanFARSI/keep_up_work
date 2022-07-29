import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';

class AddStepsProgress extends StatefulWidget {
  const AddStepsProgress({Key? key}) : super(key: key);

  @override
  State<AddStepsProgress> createState() => _AddStepsProgressState();
}

class _AddStepsProgressState extends State<AddStepsProgress> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Add Steps Progress',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.pop();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.save_rounded),
          onPressed: () {
            // TODO: Save steps progress
          },
        ),
      ],
      child: const Center(
        child: Text('Add Steps Progress'),
      ),
    );
  }
}
