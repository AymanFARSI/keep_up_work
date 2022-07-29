import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';

class DetailsPage extends StatelessWidget {
  final int id;
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Details',
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      child: Text('Details $id'),
    );
  }
}
