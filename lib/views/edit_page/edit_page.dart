import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';
import 'package:keep_up_work/src/variables/var_progress.dart';
import 'package:keep_up_work/views/edit_page/steps_progress_edit.dart';
import 'package:keep_up_work/views/edit_page/value_progress_edit.dart';
import 'package:keep_up_work/views/error_page/error_page.dart';

class EditPage extends StatelessWidget {
  final int id;
  final String type;
  const EditPage({
    Key? key,
    required this.id,
    required this.type,
  }) : super(key: key);

  Widget _buildBody() {
    switch (type) {
      case 'value':
        return ValueProgressEdit(
            progress: listOfValueProgress
                .firstWhere((element) => element.progressId == id));
      case 'steps':
        return StepsProgressEdit(
            progress: listOfStepsProgress
                .firstWhere((element) => element.progressId == id));
      default:
        return ErrorPage(message: 'Unknown type: $type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Edit Progress',
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      child: _buildBody(),
    );
  }
}
