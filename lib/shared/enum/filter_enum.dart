///enum & extension for resource create source
enum FilterEnum { all, distance, condition, date }

extension FilterExtension on FilterEnum {
  String get source {
    switch (this) {
      case FilterEnum.all:
        return 'all';

      case FilterEnum.distance:
        return 'distance';

      case FilterEnum.condition:
        return 'condition';
      case FilterEnum.date:
        return 'date';
    }
  }

  String get filterValue {
    switch (this) {
      case FilterEnum.all:
        return 'All';

      case FilterEnum.distance:
        return 'Distance';
      case FilterEnum.condition:
        return 'Condition';
      case FilterEnum.date:
        return 'Date';
    }
  }
}
