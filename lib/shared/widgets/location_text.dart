import 'package:flutter/material.dart';

import '../constants/spacing.dart';
import '../theme/app_colors.dart';

class LocationText extends StatelessWidget {
  const LocationText({
    super.key,
    required this.fromDetail,
    required this.isGarage,
    required this.location,
  });
  final bool isGarage;
  final bool fromDetail;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: isGarage ? AppColors.primary : AppColors.green,
          size: fromDetail ? 24 : 18,
        ),
        Spacing.sizedBoxW_04(),
        Expanded(
          child: Text(
            location,
            style: fromDetail
                ? Theme.of(context).textTheme.bodyLarge
                : Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
