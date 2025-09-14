///enum & extension for resource create source
enum FilterEnum { all, distance, condition }

extension FilterExtension on FilterEnum {
  String get source {
    switch (this) {
      case FilterEnum.all:
        return 'all';

      case FilterEnum.distance:
        return 'distance';

      case FilterEnum.condition:
        return 'condition';
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
    }
  }
}
