import 'package:flutter/material.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BasePage(
      title: 'Progress',
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        onPressed: () {},
      ),
      child: const Text('Progress'),
    );
  }
}
