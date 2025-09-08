import 'package:flutter/material.dart';

import '../constants/spacing.dart';
import '../theme/app_colors.dart';

class TimerText extends StatelessWidget {
  const TimerText(
      {super.key,
      required this.isGarage,
      required this.fromDetail,
      this.days,
      required this.date,
      required this.time});
  final bool isGarage;
  final bool fromDetail;
  final String? days;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: fromDetail ? 24 : 18,
          color: isGarage ? AppColors.primary : AppColors.green,
        ),
        Spacing.sizedBoxW_04(),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: date,
              style: fromDetail
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.bodySmall,
              children: [
                const TextSpan(
                  text: ' • ',
                ),
                TextSpan(
                  text: time,
                ),
              ],
            ),
          ),
        ),
        if (days != null) Spacing.sizedBoxW_04(),
        if (days != null && days != '0')
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            decoration: BoxDecoration(
              color: isGarage ? AppColors.secondary : AppColors.green,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              '+$days',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
      ],
    );
  }
}
