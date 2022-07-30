import 'package:sqlite3/sqlite3.dart';

class AppDatabase {
  late Database _db;
  openDatabase(String path) async {
    _db = sqlite3.open(path);
  }

  closeDatabase() {
    _db.dispose();
  }

  createTables() {
    _db.execute('''
    CREATE TABLE IF NOT EXISTS progress (
      id INTEGER NOT NULL PRIMARY KEY,
      title TEXT NOT NULL,
      date_created TEXT NOT NULL,
      display_color TEXT NOT NULL,
      is_completed INTEGER NOT NULL,
      goal TEXT NOT NULL,
      note TEXT NOT NULL
    );
  ''');
    _db.execute('''
    CREATE TABLE IF NOT EXISTS value_progress (
      progress_id INTEGER NOT NULL PRIMARY KEY REFERENCES progress(id),
      total_value INTEGER NOT NULL,
      current_value INTEGER NOT NULL,
      name TEXT NOT NULL
    );
  ''');
    _db.execute('''
    CREATE TABLE IF NOT EXISTS steps_progress (
      progress_id INTEGER NOT NULL PRIMARY KEY REFERENCES progress(id)
    );
  ''');
    _db.execute('''
    CREATE TABLE IF NOT EXISTS step (
      progress_id INTEGER NOT NULL REFERENCES steps_progress(progress_id),
      label TEXT NOT NULL,
      value INTEGER NOT NULL,
      is_done INTEGER NOT NULL,
      PRIMARY KEY (progress_id, label, value)
    );
  ''');
  }

  insertProgress({
    required int id,
    required String title,
    required String dateCreated,
    required String displayColor,
    required int isCompleted,
    required String goal,
    required String note,
  }) {
    _db.execute('''
    INSERT INTO progress (
      id,
      title,
      date_created,
      display_color,
      is_completed,
      goal,
      note
    ) VALUES (?, ?, ?, ?, ?, ?, ?)
    ''', [
      id,
      title,
      dateCreated,
      displayColor,
      isCompleted,
      goal,
      note,
    ]);
  }

  insertValueProgress({
    required int progressId,
    required int totalValue,
    required int currentValue,
    required String name,
  }) {
    _db.execute('''
    INSERT INTO value_progress (
      progress_id,
      total_value,
      current_value,
      name
    ) VALUES (?, ?, ?, ?)
    ''', [
      progressId,
      totalValue,
      currentValue,
      name,
    ]);
  }

  insertStepsProgress({
    required int progressId,
  }) {
    _db.execute('''
    INSERT INTO steps_progress (
      progress_id
    ) VALUES (?)
    ''', [
      progressId,
    ]);
  }

  insertStep({
    required int stepId,
    required int progressId,
    required String label,
    required int value,
    required int isDone,
  }) {
    _db.execute('''
    INSERT INTO step (
      progress_id,
      label,
      value,
      is_done
    ) VALUES (?, ?, ?, ?)
    ''', [
      progressId,
      label,
      value,
      isDone,
    ]);
  }

  getAllValueProgresses() {
    return _db.select(
      'SELECT * FROM progress INNER JOIN value_progress ON progress.id = value_progress.progress_id',
    );
  }

  getAllStepsProgresses() {
    return _db.select(
      'SELECT * FROM progress INNER JOIN steps_progress ON progress.id = steps_progress.progress_id',
    );
  }

  getAllSteps({
    required int progressId,
  }) {
    return _db.select(
      'SELECT * FROM step WHERE progress_id = ?',
      [progressId],
    );
  }

  int getCurrentProgressId() {
    ResultSet results = _db
      .select(
        'SELECT id FROM progress ORDER BY id DESC LIMIT 1',
      );
    return results.isEmpty ? 0 : results.first['id'] + 1;
  }

  int getCurrentStepId() {
    ResultSet results = _db
      .select(
        'SELECT progress_id FROM step ORDER BY progress_id DESC LIMIT 1',
      );
    return results.isEmpty ? 0 : results.first['progress_id'];
  }

  int getCurrentValueProgressId() {
    ResultSet results =  _db
      .select(
        'SELECT progress_id FROM value_progress ORDER BY progress_id DESC LIMIT 1',
      );
    return results.isEmpty ? 0 : results.first['progress_id'];
  }

  int getCurrentStepProgressId() {
    ResultSet results =  _db
      .select(
        'SELECT progress_id FROM steps_progress ORDER BY progress_id DESC LIMIT 1',
      );
    return results.isEmpty ? 0 : results.first['progress_id'];
  }

  updateProgress({
    required int id,
    required String title,
    required String dateCreated,
    required String displayColor,
    required int isCompleted,
    required String goal,
    required String note,
  }) {
    _db.execute('''
    UPDATE progress SET
      title = ?,
      date_created = ?,
      display_color = ?,
      is_completed = ?,
      goal = ?,
      note = ?
    WHERE id = ?
    ''', [
      title,
      dateCreated,
      displayColor,
      isCompleted,
      goal,
      note,
      id,
    ]);
  }

  updateValueProgress({
    required int progressId,
    required int totalValue,
    required int currentValue,
    required String name,
  }) {
    _db.execute('''
    UPDATE value_progress SET
      total_value = ?,
      current_value = ?,
      name = ?
    WHERE progress_id = ?
    ''', [
      totalValue,
      currentValue,
      name,
      progressId,
    ]);
  }

  updateStepsProgress({
    required int progressId,
  }) {
    _db.execute('''
    UPDATE steps_progress SET
      progress_id = ?
    WHERE progress_id = ?
    ''', [
      progressId,
      progressId,
    ]);
  }

  updateStep({
    required int stepId,
    required int progressId,
    required String label,
    required int value,
    required int isDone,
  }) {
    _db.execute('''
    UPDATE step SET
      progress_id = ?,
      label = ?,
      value = ?,
      is_done = ?
    WHERE progress_id = ?
    ''', [
      progressId,
      label,
      value,
      isDone,
    ]);
  }

  deleteProgress(int progressId) {
    _db.execute('''
    DELETE FROM progress WHERE id = ?
    ''', [
      progressId.toString(),
    ]);
  }

  deleteValueProgress(int progressId) {
    _db.execute('''
    DELETE FROM value_progress WHERE progress_id = ?
    ''', [
      progressId.toString(),
    ]);
  }

  deleteStepsProgress(int progressId) {
    _db.execute('''
    DELETE FROM steps_progress WHERE progress_id = ?
    ''', [
      progressId.toString(),
    ]);
  }

  deleteStep(int progressId) {
    _db.execute('''
    DELETE FROM step WHERE progress_id = ?
    ''', [
      progressId.toString(),
    ]);
  }
}
