import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:keep_up_work/controllers/wrappers/page_wrapper.dart';
import 'package:keep_up_work/models/value_progress.dart';
import 'package:keep_up_work/src/variables/var_database.dart';

class AddValueProgress extends StatefulWidget {
  const AddValueProgress({Key? key}) : super(key: key);

  @override
  State<AddValueProgress> createState() => _AddValueProgressState();
}

class _AddValueProgressState extends State<AddValueProgress> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _currentValueController =
      TextEditingController(text: '0');
  final TextEditingController _totalValueController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isCompleted = false;
  Color _displayColor = Colors.black45;
  DateTime _dateCreated = DateTime.now();

  @override
  dispose() {
    _titleController.dispose();
    _goalController.dispose();
    _noteController.dispose();
    _currentValueController.dispose();
    _totalValueController.dispose();
    _nameController.dispose();
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
      title: 'Add Value Progress',
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
            _currentValueController.text = '0';
            _totalValueController.clear();
            _nameController.clear();
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
            _buildInputField(
              label: 'Current Value',
              controller: _currentValueController,
              isNumber: true,
            ),
            divider,
            _buildInputField(
              label: 'Total Value',
              controller: _totalValueController,
              isNumber: true,
              hint: 'Enter Total Value',
            ),
            divider,
            _buildInputField(
              label: 'Name',
              controller: _nameController,
              hint: 'Enter the name of values',
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
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_titleController.text.isEmpty ||
                      _currentValueController.text.isEmpty ||
                      _totalValueController.text.isEmpty) {
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
                    ValueProgress progress = ValueProgress(
                      id: currentProgressId++,
                      title: _titleController.text,
                      goal: _goalController.text,
                      note: _noteController.text,
                      currentValue: int.parse(_currentValueController.text),
                      totalValue: int.parse(_totalValueController.text),
                      name: _nameController.text,
                      displayColor: _displayColor,
                      dateCreated: _dateCreated,
                      isCompleted: _isCompleted,
                    );
                    await dbLayer.addValueProgress(progress);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Value Progress'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
