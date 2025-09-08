import 'package:flutter/material.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';

class IncludePdf extends StatelessWidget {
  const IncludePdf({
    super.key,
    required this.isInclude,
    required this.onChanged,
  });
  final bool isInclude;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      horizontalTitleGap: 0,
      child: CheckboxListTile(
        value: isInclude,
        onChanged: onChanged,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          'Attach to email',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
