import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/routing/routes.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Progress',
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        onPressed: () {},
      ),
      child: ElevatedButton(
        onPressed: () {
          context.goNamed(
            MyRoutes.DETAILS.name,
            params: {'id': '1999'},
          );
        },
        child: const Text('Details'),
      ),
    );
  }
}
