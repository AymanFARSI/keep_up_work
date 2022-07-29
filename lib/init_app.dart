import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:keep_up_work/src/layer/layer.dart';
import 'package:keep_up_work/src/variables/var_database.dart';

initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
}

initDatabase() async {
  dbLayer = DBLayer();
  await dbLayer.init();
}
