import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/routing/routes.dart';
import 'package:keep_up_work/init_app.dart';
import 'package:keep_up_work/views/details_page/details_page.dart';
import 'package:keep_up_work/views/edit_page/edit_page.dart';
import 'package:keep_up_work/views/error_page/error_page.dart';
import 'package:keep_up_work/views/progress_page/add_steps_progress.dart';
import 'package:keep_up_work/views/progress_page/add_value_progress.dart';
import 'package:keep_up_work/views/progress_page/progress_page.dart';

main() async {
  await initApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: '/progress',
    redirect: (state) {
      return null;
    },
    routes: [
      GoRoute(
        name: MyRoutes.PROGRESS.name,
        path: MyRoutes.PROGRESS.path,
        builder: (context, state) => const ProgressPage(),
        routes: [
          GoRoute(
            name: MyRoutes.ADD_VALUE_PROGRESS.name,
            path: MyRoutes.ADD_VALUE_PROGRESS.path,
            builder: (context, state) => const AddValueProgress(),
          ),
          GoRoute(
            name: MyRoutes.ADD_STEPS_PROGRESS.name,
            path: MyRoutes.ADD_STEPS_PROGRESS.path,
            builder: (context, state) => const AddStepsProgress(),
          ),
          GoRoute(
            name: MyRoutes.DETAILS.name,
            path: MyRoutes.DETAILS.path,
            builder: (context, state) => DetailsPage(
              id: int.parse(state.params['id']!),
              type: state.params['type']!,
            ),
            routes: [
              GoRoute(
                name: MyRoutes.EDIT.name,
                path: MyRoutes.EDIT.path,
                builder: (context, state) => EditPage(
                  id: int.parse(state.params['id']!),
                  type: state.params['type']!,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'error',
        path: '/error',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: ErrorPage(state: state),
        ),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(state: state),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Keep Up Work',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
