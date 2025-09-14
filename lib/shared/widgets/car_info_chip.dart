import 'package:flutter/material.dart';

import '../domain/models/garage_yard/garage_yard_model.dart';
import '../theme/app_colors.dart';

class CarInfoChip extends StatelessWidget {
  const CarInfoChip({
    super.key,
    required this.status,
    this.brand,
    this.model,
    this.year,
    this.warranty,
  });

  final StatusEnum status;
  final String? brand;
  final String? model;
  final String? year;
  final bool? warranty;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        // Status chip
        _buildStatusChip(context),

        // Car info chips
        if (brand != null && brand!.isNotEmpty)
          _buildInfoChip(context, brand!, AppColors.primary),

        if (model != null && model!.isNotEmpty)
          _buildInfoChip(context, model!, AppColors.secondary),

        if (year != null && year!.isNotEmpty)
          _buildInfoChip(context, year!, AppColors.tertiary),

        if (warranty == true) _buildWarrantyChip(context),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color boxColor =
        status == StatusEnum.active ? AppColors.tertiary : AppColors.secondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        status.name,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withOpacity(0.3), width: 1.0),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildWarrantyChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.green.withOpacity(0.3), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: 12, color: AppColors.green),
          const SizedBox(width: 4),
          Text(
            'Warranty',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
