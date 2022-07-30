// ignore_for_file: constant_identifier_names

enum MyRoutes {
  PROGRESS,
  DETAILS,
  ADD_VALUE_PROGRESS,
  ADD_STEPS_PROGRESS;

  static const Map<MyRoutes, String> paths = {
    PROGRESS: '/progress',
    DETAILS: ':id',
    ADD_VALUE_PROGRESS: 'add_value_progress',
    ADD_STEPS_PROGRESS: 'add_steps_progress',
  };

  String get name {
    switch (this) {
      case PROGRESS:
        return 'progress';
      case DETAILS:
        return 'details';
      case ADD_VALUE_PROGRESS:
        return 'add_value_progress';
      case ADD_STEPS_PROGRESS:
        return 'add_steps_progress';
    }
  }

  String get path => paths[this]!;
}
