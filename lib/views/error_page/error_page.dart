import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';

class ErrorPage extends StatelessWidget {
  final GoRouterState state;
  const ErrorPage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Error',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () {},
      ),
      child: Center(
        child: Text(
          state.error.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
