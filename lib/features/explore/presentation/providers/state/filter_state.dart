import 'dart:convert';

import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/utils/cusotm_date_utils.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

class FilterState {
  final String? zipCode;
  final double? radius;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isGarage;
  final List<CarCondition>? selectedCategories;

  FilterState({
    this.zipCode,
    this.radius,
    this.startDate,
    this.endDate,
    this.isGarage,
    this.selectedCategories,
  });

  FilterState copyWith({
    String? zipCode,
    double? radius,
    DateTime? startDate,
    bool? isGarage,
    DateTime? endDate,
    List<CarCondition>? selectedCategories,
  }) {
    return FilterState(
      zipCode: zipCode ?? this.zipCode,
      radius: radius ?? this.radius,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isGarage: isGarage ?? this.isGarage,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  FilterState copyWithDate({DateTime? sDate, DateTime? eDate}) {
    return FilterState(
      zipCode: zipCode,
      radius: radius,
      startDate: sDate,
      endDate: eDate,
      isGarage: isGarage,
    );
  }

  FilterState copyWithRadius({double? rad}) {
    return FilterState(
      zipCode: zipCode,
      radius: rad,
      startDate: startDate,
      endDate: endDate,
      isGarage: isGarage,
    );
  }

  String get formattedStartDate {
    if (startDate != null && endDate != null) {
      return '${CustomDateUtils.formatDate(startDate ?? DateTime.now())} - ${CustomDateUtils.formatDate(endDate ?? DateTime.now())}';
    }
    return startDate != null
        ? CustomDateUtils.formatDate(startDate ?? DateTime.now())
        : '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      if (zipCode != null) 'zip_code': zipCode,
      if (radius != null) 'max_distance_km': ((radius ?? 0.0) * 1.60934),
      // if (PrintUtils.radiusInAllChip != true)
      //   if (radius == null) 'max_distance_km': (15 * 1.60934),
      'start_date': CustomDateUtils.formatDateFilter(
        startDate ?? DateTime.now(),
      ),
      if (endDate != null)
        'end_date': CustomDateUtils.formatDateFilter(endDate!),
      if (isGarage != null) 'is_garage': isGarage,
      if (selectedCategories != null)
        'category': (selectedCategories ?? []).map((e) => e.id).toList(),
    };
    PrintUtils.customLog('FilterState.toJson: ${jsonEncode(map)}');
    return map;
  }

  // Factory constructor for the initial state
  factory FilterState.initial() {
    return FilterState(
      startDate: DateTime.now(),
      zipCode: null,
      endDate: null,
      radius: PrintUtils.radiusInAllChip ? null : 15,
      selectedCategories: null,
    );
  }
}

//employee daywork date filters enum
enum DateFilter { today, toWeek, toMonth, customRange }

extension DateFilterText on DateFilter {
  String get name {
    switch (this) {
      case DateFilter.today:
        return 'Today';
      case DateFilter.toWeek:
        return 'This Week';
      case DateFilter.toMonth:
        return 'This Month';
      case DateFilter.customRange:
        return 'Custom Range';
      default:
        return '';
    }
  }
}
