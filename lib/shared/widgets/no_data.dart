import 'package:flutter/material.dart';
import 'package:findcarsale/shared/constants/spacing.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    this.fromAdd = false,
    this.matchingValueText,
    this.errorMessage,
  });
  final bool fromAdd;

  final String? matchingValueText;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    String subtitle =
        fromAdd
            ? 'Try adding a new item.'
            : 'Sorry, we couldn\'t find any listings matching your search${matchingValueText ?? ''}. Try adjusting your filters or expanding your search area.';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/no_data.png', width: 200, height: 200),
        Spacing.sizedBoxH_16(),
        if (errorMessage == null)
          Text(
            fromAdd ? 'List is empty' : 'No Results Found',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            (errorMessage == null) ? subtitle : errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
