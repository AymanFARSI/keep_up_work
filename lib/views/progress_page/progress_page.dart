import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_up_work/controllers/routing/routes.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';
import 'package:keep_up_work/models/steps_progress.dart';
import 'package:keep_up_work/models/value_progress.dart';
import 'package:keep_up_work/src/variables/var_progress.dart';
import 'package:keep_up_work/views/progress_page/steps_progress_widget.dart';
import 'package:keep_up_work/views/progress_page/value_progress_widget.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late PageController _pageController;
  late Widget _pageView;
  final RxInt _currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex.value,
      keepPage: true,
    );
    _pageView = Obx(
      () => PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.start,
        onPageChanged: (int index) {
          _currentIndex.value = index;
        },
        children: [
          _buildPageViewAll(
            valueList: listOfValueProgress,
            stepsList: listOfStepsProgress,
          ),
          _buildListViewValue(
            length: listOfValueProgress.length,
            list: listOfValueProgress,
          ),
          _buildListViewSteps(
            length: listOfStepsProgress.length,
            list: listOfStepsProgress,
          ),
        ],
      ),
    );
  }

  Widget _buildPageViewAll({
    required List<ValueProgress> valueList,
    required List<StepsProgress> stepsList,
  }) {
    int length = valueList.length + stepsList.length;
    if (length == 0) {
      return const Center(
        child: Text('No Progress'),
      );
    } else {
      return ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) => index < valueList.length
            ? ValueProgressWidget(
                item: valueList[index],
              )
            : StepsProgressWidget(
                item: stepsList[index - valueList.length],
              ),
      );
    }
  }

  Widget _buildListViewValue({
    required int length,
    required List<ValueProgress> list,
  }) {
    if (length == 0) {
      return const Center(
        child: Text('No Value Progress'),
      );
    } else {
      return ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) => ValueProgressWidget(
          item: list[index],
        ),
      );
    }
  }

  Widget _buildListViewSteps({
    required int length,
    required List<StepsProgress> list,
  }) {
    if (length == 0) {
      return const Center(
        child: Text('No Steps Progress'),
      );
    } else {
      return ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) => StepsProgressWidget(
          item: list[index],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle activeStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    TextStyle inactiveStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontSize: 18,
      fontWeight: FontWeight.normal,
    );
    return BasePage(
      title: 'Progress',
      actions: [
        IconButton(
          icon: const Icon(Icons.add_rounded),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add Progress'),
                content: const Text('Select a type of progress'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actionsPadding: const EdgeInsets.all(7.0),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.goNamed(MyRoutes.ADD_VALUE_PROGRESS.name);
                    },
                    child: const Text('Value Progress'),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.goNamed(MyRoutes.ADD_STEPS_PROGRESS.name);
                    },
                    child: const Text('Steps Progress'),
                  ),
                ],
              ),
            );
          },
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const AboutDialog(
                applicationIcon: FlutterLogo(
                  size: 100,
                ),
                applicationName: 'Keep Up Work',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2022 Keep Up Work',
              ),
            );
          },
          icon: const Icon(Icons.lightbulb_circle),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            Container(
              height: 40,
              width: Get.width * 0.7,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(0);
                        _currentIndex.value = 0;
                      },
                      child: Text(
                        'All',
                        style: _currentIndex.value == 0
                            ? activeStyle
                            : inactiveStyle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(1);
                        _currentIndex.value = 1;
                      },
                      child: Text(
                        'Value',
                        style: _currentIndex.value == 1
                            ? activeStyle
                            : inactiveStyle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(2);
                        _currentIndex.value = 2;
                      },
                      child: Text(
                        'Steps',
                        style: _currentIndex.value == 2
                            ? activeStyle
                            : inactiveStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 9),
            Expanded(
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.all(7.0),
                child: _pageView,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
