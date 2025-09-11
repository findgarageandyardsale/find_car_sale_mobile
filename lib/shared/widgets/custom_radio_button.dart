import 'package:flutter/material.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String title;
  final String? subtitle;
  final bool enabled;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return InkWell(
      onTap: enabled ? () => onChanged?.call(value) : null,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: enabled ? onChanged : null,
            activeColor: activeColor ?? AppColors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color:
                        enabled
                            ? (isSelected ? AppColors.primary : Colors.black87)
                            : Colors.grey,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          enabled
                              ? (isSelected
                                  ? AppColors.primary.withOpacity(0.7)
                                  : Colors.grey.shade600)
                              : Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRadioGroup<T> extends StatelessWidget {
  final List<CustomRadioOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Axis direction;
  final double spacing;
  final bool enabled;

  const CustomRadioGroup({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.direction = Axis.vertical,
    this.spacing = 8.0,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return direction == Axis.vertical
        ? Column(
          children:
              options
                  .map(
                    (option) => Padding(
                      padding: EdgeInsets.only(bottom: spacing),
                      child: CustomRadioButton<T>(
                        value: option.value,
                        groupValue: value,
                        onChanged: enabled ? onChanged : null,
                        title: option.title,
                        subtitle: option.subtitle,
                        enabled: enabled,
                        activeColor: option.activeColor,
                        inactiveColor: option.inactiveColor,
                      ),
                    ),
                  )
                  .toList(),
        )
        : Row(
          children:
              options
                  .map(
                    (option) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: spacing),
                        child: CustomRadioButton<T>(
                          value: option.value,
                          groupValue: value,
                          onChanged: enabled ? onChanged : null,
                          title: option.title,
                          subtitle: option.subtitle,
                          enabled: enabled,
                          activeColor: option.activeColor,
                          inactiveColor: option.inactiveColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        );
  }
}

class CustomRadioOption<T> {
  final T value;
  final String title;
  final String? subtitle;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomRadioOption({
    required this.value,
    required this.title,
    this.subtitle,
    this.activeColor,
    this.inactiveColor,
  });
}
