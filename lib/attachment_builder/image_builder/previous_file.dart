import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/utils/image_utils.dart';

import '../../shared/constants/spacing.dart';
import '../../shared/widgets/file_image_builder.dart';
import '../provider/custom_attachment_provider.dart';
import 'include_pf_widget.dart';

class PreviousImageFiles extends ConsumerWidget {
  const PreviousImageFiles({
    super.key,
    required this.uniqueKey,
    this.onRemoveAttachment,
    this.onSwtichInclude,
    required this.isInclude,
  });
  final String uniqueKey;
  final bool isInclude;
  final void Function(int attachmentId)? onRemoveAttachment;
  final void Function(int attachmentId, bool isInclude)? onSwtichInclude;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attachmentState = ref.watch(customAttachmentProvider(uniqueKey));
    return Wrap(
      children:
          (attachmentState.serverAttachments ?? []).map((e) {
            return (e.mime == 'jpg' || e.mime == 'jpeg' || e.mime == 'png')
                ? SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FileImageBuilder(
                              // borderRadius: BorderRadius.circular(8),
                              // height: 80,
                              // width: 80,
                              url: e.thumbnail ?? e.file ?? '',
                              clickUrl: e.file ?? '',
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.red, // Black background
                              radius: 10,
                              child: IconButton(
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (onRemoveAttachment != null) {
                                    onRemoveAttachment!(e.id!);
                                    ref
                                        .read(
                                          customAttachmentProvider(
                                            (uniqueKey),
                                          ).notifier,
                                        )
                                        .removeCurrentAttachments(e.id!);
                                  }
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isInclude)
                        IncludePdf(
                          isInclude: e.isInclude ?? false,
                          onChanged: (bool? value) {
                            if (onSwtichInclude != null) {
                              onSwtichInclude!(e.id!, value ?? false);
                              ref
                                  .read(
                                    customAttachmentProvider(
                                      (uniqueKey),
                                    ).notifier,
                                  )
                                  .updateStateAttachment(
                                    attachmentId: e.id!,
                                    isInclude: value ?? false,
                                  );
                            }
                          },
                        ),
                    ],
                  ),
                )
                : const SizedBox.shrink();
          }).toList(),
    );
  }
}

class PreviousFiles extends ConsumerWidget {
  const PreviousFiles({
    super.key,
    required this.uniqueKey,
    this.onRemoveAttachment,
    this.onSwtichInclude,
    required this.isInclude,
  });
  final String uniqueKey;
  final bool isInclude;

  final void Function(int attachmentId)? onRemoveAttachment;
  final void Function(int attachmentId, bool isInclude)? onSwtichInclude;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attachmentState = ref.watch(customAttachmentProvider(uniqueKey));
    return Wrap(
      children:
          (attachmentState.serverAttachments ?? []).map((e) {
            return (e.mime == 'jpg' || e.mime == 'jpeg' || e.mime == 'png')
                ? const SizedBox.shrink()
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // context.router.push(WebViewWidgetRoute(
                            //     data: e.thumbnail ?? e.file ?? '',
                            //     title: e.name ?? ''));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                    .withOpacity(0.2),
                              ),
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Icon(
                                    ImageUtils.checkIcon(e.name ?? ''),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 16,
                                  ),
                                  Spacing.sizedBoxW_24(),
                                  Expanded(
                                    child: Text(
                                      '${e.name ?? e.file}',
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
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              if (onRemoveAttachment != null) {
                                onRemoveAttachment!(e.id!);
                                ref
                                    .read(
                                      customAttachmentProvider(
                                        (uniqueKey),
                                      ).notifier,
                                    )
                                    .removeCurrentAttachments(e.id!);
                              }
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isInclude)
                      IncludePdf(
                        isInclude: e.isInclude ?? false,
                        onChanged: (bool? value) {
                          if (onSwtichInclude != null) {
                            onSwtichInclude!(e.id!, value ?? false);
                            ref
                                .read(
                                  customAttachmentProvider(
                                    (uniqueKey),
                                  ).notifier,
                                )
                                .updateStateAttachment(
                                  attachmentId: e.id,
                                  isInclude: value ?? false,
                                );
                          }
                        },
                      ),
                  ],
                );
          }).toList(),
    );
  }
}
