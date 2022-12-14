import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/routing/routes.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';
import 'package:keep_up_work/src/variables/var_progress.dart';
import 'package:keep_up_work/views/details_page/steps_progress_details.dart';
import 'package:keep_up_work/views/details_page/value_progress_details.dart';
import 'package:keep_up_work/views/error_page/error_page.dart';

class DetailsPage extends StatelessWidget {
  final int id;
  final String type;
  const DetailsPage({
    Key? key,
    required this.id,
    required this.type,
  }) : super(key: key);

  Widget _buildBody() {
    switch (type) {
      case 'value':
        return ValueProgressDetails(
            progress: listOfValueProgress
                .firstWhere((element) => element.progressId == id));
      case 'steps':
        return StepsProgressDetails(
            progress: listOfStepsProgress
                .firstWhere((element) => element.progressId == id));
      default:
        return ErrorPage(message: 'Unknown type: $type');
    }
  }

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
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            context.goNamed(
              MyRoutes.EDIT.name,
              params: {
                'id': id.toString(),
                'type': type,
              },
            );
          },
        ),
      ],
      child: _buildBody(),
    );
  }
}
