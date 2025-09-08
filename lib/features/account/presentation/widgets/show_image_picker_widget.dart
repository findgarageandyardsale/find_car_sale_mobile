import 'package:flutter/material.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_bottomsheet.dart';

///picker widget body section widget
class ShowImagePickerWidget extends StatelessWidget {
  const ShowImagePickerWidget({
    super.key,
    required this.photolibraryfn,
    required this.camerafn,
    this.filesfn,
    this.removeList,
    this.removeFn,
  });
  final VoidCallback photolibraryfn;
  final VoidCallback camerafn;
  final VoidCallback? filesfn;
  final VoidCallback? removeFn;
  final bool? removeList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Wrap(
          children: <Widget>[
            InkWell(
              onTap: () => photolibraryfn(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.photo_library, color: AppColors.primary),
                    Spacing.sizedBoxW_12(),
                    Text(
                      'Photo Library',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => camerafn(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.photo_camera, color: AppColors.primary),
                    Spacing.sizedBoxW_12(),
                    Text(
                      'Camera',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            if (removeList == true)
              InkWell(
                onTap: () {
                  if (removeFn != null) removeFn!();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: AppColors.error),
                      Spacing.sizedBoxW_12(),
                      Text(
                        'Remove existing photo',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

///method to display picker widget
void showImagePickerAlertWidget({
  required BuildContext context,
  required VoidCallback photolibraryfn,
  required VoidCallback camerafn,
  final VoidCallback? filesFn,
  final VoidCallback? removeFn,
  final bool? removeList,
}) {
  primaryBottomSheet(
    context,
    padding: const EdgeInsets.all(0),
    child: ShowImagePickerWidget(
      camerafn: camerafn,
      photolibraryfn: photolibraryfn,
      removeFn: removeFn,
      filesfn: filesFn,
      removeList: removeList,
    ),
  );
}
