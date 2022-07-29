import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';

class AddValueProgress extends StatefulWidget {
  const AddValueProgress({Key? key}) : super(key: key);

  @override
  State<AddValueProgress> createState() => _AddValueProgressState();
}

class _AddValueProgressState extends State<AddValueProgress> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Add Value Progress',
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
            // TODO: Add Value Progress
          },
        ),
      ],
      child: const Center(
        child: Text('Add Value Progress'),
      ),
    );
  }
}
