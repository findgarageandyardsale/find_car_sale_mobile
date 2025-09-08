import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';

///Icon button with title horizontal widget
class CustomIconBtnWithTitleWidget extends StatelessWidget {
  const CustomIconBtnWithTitleWidget({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
  });

  final String title;
  final IconData iconData;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => onTap(),
          icon: CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(
              iconData,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
        ),
      ],
    );
  }
}
