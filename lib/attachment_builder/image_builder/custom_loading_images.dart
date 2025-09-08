// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/utils/image_utils.dart';
import 'package:path/path.dart';
import '../../shared/constants/spacing.dart';
import '../provider/custom_attachment_provider.dart';

class CustomLoadingImages extends ConsumerWidget {
  const CustomLoadingImages({super.key, required this.uniqueKey});
  final String uniqueKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attachmentState = ref.watch(customAttachmentProvider((uniqueKey)));

    Widget loadWidget({File? file}) => Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child:
                  file == null
                      ? const SizedBox.shrink()
                      : Image.file(
                        file,
                        width: 85,
                        fit: BoxFit.cover,
                        height: 85,
                      ),
            ),
          ),
        ),
        const Positioned(
          top: 1,
          bottom: 1,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeWidth: 4.0,
            ),
          ),
        ),
        // const SizedBox(
        //   width: 85,
        //   height: 85,
        //   child: Center(
        //     child: CircularProgressIndicator(
        //       valueColor: AlwaysStoppedAnimation<Color>(
        //         AppColors.primary,
        //       ),
        //       strokeWidth: 4.0,
        //     ),
        //   ),
        // ),
      ],
    );

    return (attachmentState.isLoading == true)
        ? Wrap(
          children: [
            for (var file in (attachmentState.localAttachments ?? []))
              ImageUtils.isImage(path: file.path)
                  ? loadWidget(file: file)
                  : const SizedBox.shrink(),
          ],
        )
        : const SizedBox.shrink();
  }
}

class CustomLoadingFiles extends ConsumerWidget {
  const CustomLoadingFiles({super.key, required this.uniqueKey});
  final String uniqueKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attachmentState = ref.watch(customAttachmentProvider((uniqueKey)));
    return Container(
      child:
          (attachmentState.isLoading ?? false)
              ? Wrap(
                children: [
                  for (var file in (attachmentState.localAttachments ?? []))
                    ImageUtils.isImage(path: file.path)
                        ? const SizedBox.shrink()
                        : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer.withOpacity(0.2),
                            ),
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      ImageUtils.checkIcon(basename(file.path)),
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                      size: 16,
                                    ),
                                    Spacing.sizedBoxW_24(),
                                    Expanded(
                                      child: Text(
                                        basename(file.path),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Spacing.sizedBoxW_10(),
                                  ],
                                ),
                                Spacing.sizedBoxH_10(),
                                const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        ),
                ],
              )
              : const SizedBox.shrink(),
    );
  }
}
