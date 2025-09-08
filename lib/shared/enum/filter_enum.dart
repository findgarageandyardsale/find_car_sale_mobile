///enum & extension for resource create source
enum FilterEnum { all, garage, yard, distance, date, categories }

extension FilterExtension on FilterEnum {
  String get source {
    switch (this) {
      case FilterEnum.all:
        return 'all';
      case FilterEnum.garage:
        return 'garage';
      case FilterEnum.yard:
        return 'yarf';
      case FilterEnum.date:
        return 'date';
      case FilterEnum.distance:
        return 'distance';

      case FilterEnum.categories:
        return 'categories';
    }
  }

  String get filterValue {
    switch (this) {
      case FilterEnum.all:
        return 'All';
      case FilterEnum.garage:
        return 'Garage';
      case FilterEnum.yard:
        return 'Yard';
      case FilterEnum.date:
        return 'Date';
      case FilterEnum.distance:
        return 'Distance';
      case FilterEnum.categories:
        return 'Categories';
    }
  }
}
