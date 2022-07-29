// ignore_for_file: constant_identifier_names

enum MyRoutes {
  PROGRESS,
  DETAILS;

  static const Map<MyRoutes, String> paths = {
    PROGRESS: '/progress',
    DETAILS: ':id',
  };

  String get name {
    switch (this) {
      case PROGRESS:
        return 'progress';
      case DETAILS:
        return 'details';
    }
  }

  String get path => paths[this]!;
}
