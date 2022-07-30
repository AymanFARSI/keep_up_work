import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';
import 'package:keep_up_work/models/step_model.dart';
import 'package:keep_up_work/models/steps_progress.dart';
import 'package:keep_up_work/src/variables/var_database.dart';

class AddStepsProgress extends StatefulWidget {
  const AddStepsProgress({Key? key}) : super(key: key);

  @override
  State<AddStepsProgress> createState() => _AddStepsProgressState();
}

class _AddStepsProgressState extends State<AddStepsProgress> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final RxList<StepModel> _steps = RxList<StepModel>();
  final TextEditingController _stepLabelController = TextEditingController();
  final TextEditingController _stepValueController = TextEditingController();
  bool _isCompleted = false;
  Color _displayColor = Colors.black45;
  DateTime _dateCreated = DateTime.now();

  @override
  dispose() {
    _titleController.dispose();
    _goalController.dispose();
    _noteController.dispose();
    _stepLabelController.dispose();
    _stepValueController.dispose();
    _steps.close();
    super.dispose();
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool isNumber = false,
    String hint = '',
  }) =>
      SizedBox(
        width: Get.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: Text(
                '$label:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType:
                    isNumber ? TextInputType.number : TextInputType.text,
                textAlign: TextAlign.justify,
                decoration: InputDecoration(
                  hintText: hint,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                onEditingComplete: () => FocusScope.of(context).unfocus(),
              ),
            ),
          ],
        ),
      );

  Widget _buildDatePicker() => SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(
              width: 150,
              child: Text(
                'Date Created:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'd MMM, yyyy',
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                initialValue: _dateCreated.toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(DateTime.now().year + 1),
                dateLabelText: 'Date Created',
                onSaved: (String? val) {
                  if (val != null) {
                    _dateCreated = DateTime.parse(val);
                  }
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildColorPicker() => HueRingPicker(
        pickerColor: _displayColor,
        onColorChanged: (Color color) {
          setState(() {
            _displayColor = color;
          });
        },
        enableAlpha: false,
        displayThumbColor: true,
        portraitOnly: true,
      );

  @override
  Widget build(BuildContext context) {
    Widget divider = const Divider(
      thickness: 1,
      indent: 5,
      endIndent: 5,
    );
    return BasePage(
      title: 'Add Steps Progress',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.clear_all_rounded),
          onPressed: () {
            _titleController.clear();
            _goalController.clear();
            _noteController.clear();
            _stepLabelController.clear();
            _stepValueController.clear();
            _steps.clear();
            _isCompleted = false;
            _displayColor = Colors.black45;
            _dateCreated = DateTime.now();
            setState(() {});
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _buildInputField(
              label: 'Title',
              controller: _titleController,
              hint: 'Enter Title',
            ),
            divider,
            _buildInputField(
              label: 'Goal',
              controller: _goalController,
              hint: 'Enter Goal',
            ),
            divider,
            _buildInputField(
              label: 'Note',
              controller: _noteController,
              hint: 'Enter Note',
            ),
            divider,
            _buildDatePicker(),
            divider,
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 150,
                    child: Text(
                      'Color:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0),
                            contentPadding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? const BorderRadius.vertical(
                                          top: Radius.circular(500),
                                          bottom: Radius.circular(100),
                                        )
                                      : const BorderRadius.horizontal(
                                          right: Radius.circular(500),
                                        ),
                            ),
                            content: SingleChildScrollView(
                              child: _buildColorPicker(),
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: _displayColor,
                    ),
                  ),
                ],
              ),
            ),
            divider,
            SwitchListTile(
              title: const Text('Completed'),
              value: _isCompleted,
              onChanged: (bool value) {
                setState(() {
                  _isCompleted = value;
                });
              },
            ),
            divider,
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'List of Steps:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Add Step'),
                            elevation: 5,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildInputField(
                                  label: 'Label',
                                  controller: _stepLabelController,
                                  hint: 'Enter Label',
                                ),
                                const SizedBox(height: 10),
                                _buildInputField(
                                  label: 'Value',
                                  controller: _stepValueController,
                                  hint: 'Enter Value',
                                  isNumber: true,
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                child: const Text('Add'),
                                onPressed: () {
                                  if (_stepLabelController.text.isNotEmpty &&
                                      _stepValueController.text.isNotEmpty) {
                                    _steps.add(
                                      StepModel(
                                        label: _stepLabelController.text,
                                        value: int.parse(
                                            _stepValueController.text),
                                        isDone: false,
                                        progressId: currentProgressId,
                                      ),
                                    );
                                    _stepLabelController.clear();
                                    _stepValueController.clear();
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => _steps.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _steps.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(_steps[index].label),
                          subtitle: Text(_steps[index].value.toString()),
                          leading: IconButton(
                            icon: Icon(
                              _steps[index].isDone
                                  ? Icons.check_box_sharp
                                  : Icons.check_box_outline_blank_sharp,
                            ),
                            onPressed: () {
                              setState(() {
                                _steps[index].isDone = !_steps[index].isDone;
                              });
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _steps.removeAt(index);
                            },
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_titleController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please fill all the fields'),
                          actions: [
                            ElevatedButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    StepsProgress progress = StepsProgress(
                      title: _titleController.text,
                      id: currentProgressId,
                      dateCreated: _dateCreated,
                      goal: _goalController.text,
                      note: _noteController.text,
                      displayColor: _displayColor,
                      isCompleted: _isCompleted,
                      steps: _steps,
                    );
                    await dbLayer.addStepsProgress(progress);
                    currentProgressId++;
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Steps Progress'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
