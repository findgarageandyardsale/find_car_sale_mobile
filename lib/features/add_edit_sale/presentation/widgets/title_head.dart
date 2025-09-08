//create a statelesswdget with title as argument and a text widget with title as text
import 'package:flutter/material.dart';
import 'package:findcarsale/shared/constants/spacing.dart';

class TitleHead extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? clearWidget;

  const TitleHead({
    super.key,
    required this.title,
    this.subtitle,
    this.clearWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        if (subtitle != null || subtitle != '') Spacing.sizedBoxH_08(),
        if (subtitle != null || subtitle != '')
          Row(
            children: [
              Expanded(
                child: Text(
                  subtitle ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if (clearWidget != null) clearWidget!,
            ],
          ),
      ],
    );
  }
}
