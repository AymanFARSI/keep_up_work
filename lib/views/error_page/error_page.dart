import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/routing/routes.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';

class ErrorPage extends StatelessWidget {
  final GoRouterState? state;
  final String? message;
  const ErrorPage({Key? key, this.state, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Error',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          context.goNamed(MyRoutes.PROGRESS.name);
        },
      ),
      child: Center(
        child: Text(
          state == null ? message ?? 'Unknown Error' : state!.error.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
