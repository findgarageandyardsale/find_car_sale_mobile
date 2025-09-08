import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/domain/models/attachment_file/attachment_model.dart';
import '../provider/custom_attachment_provider.dart';
import 'custom_loading_images.dart';
import 'custom_row_icons.dart';
import 'previous_file.dart';

class CustomImageBuilder extends ConsumerStatefulWidget {
  final void Function(bool isLoading)? onLoadingFilesChanged;
  final Widget? notesWidget;

  final List<AttachmentModel>? attachments;
  final String uniqueKey;
  final bool? hasLibrary;
  final bool? hasCamera;
  final bool? hasGallery;
  final bool? hasEdit;
  final bool hasIncludeInPdf;
  final void Function(int attachmentId)? onRemoveAttachment;
  final void Function(int attachmentId, bool isInclude)? onSwtichInclude;
  final void Function(List<AttachmentModel> attachmentList) onAddAttachment;

  const CustomImageBuilder({
    super.key,
    this.attachments,
    this.hasLibrary = true,
    this.hasCamera = true,
    this.hasGallery = true,
    this.hasEdit = true,
    this.hasIncludeInPdf = false,
    this.onRemoveAttachment,
    required this.uniqueKey,
    required this.onAddAttachment,
    this.onSwtichInclude,
    this.notesWidget,
    this.onLoadingFilesChanged,
  });

  @override
  ConsumerState<CustomImageBuilder> createState() => _CustomImageBuilderState();
}

class _CustomImageBuilderState extends ConsumerState<CustomImageBuilder> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      /// Provider to watch the document list
      // final documentState = ref
      //     .watch(addDataNotifierProvider.select((value) => value?.attachments));
      if (widget.attachments != null) {
        ref
            .read(customAttachmentProvider(widget.uniqueKey).notifier)
            .addAttachmentofServer(widget.attachments ?? []);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(customAttachmentProvider(widget.uniqueKey));

    final hasLoadingFiles = (ref
                .read(customAttachmentProvider(widget.uniqueKey))
                .localAttachments ??
            [])
        .isNotEmpty;

    // Notify the parent widget if the loading state changes
    widget.onLoadingFilesChanged?.call(hasLoadingFiles);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PreviousImageFiles(
          uniqueKey: widget.uniqueKey,
          isInclude: widget.hasIncludeInPdf,
          onSwtichInclude: widget.onSwtichInclude,
          onRemoveAttachment: widget.onRemoveAttachment,
        ),
        CustomLoadingImages(
          uniqueKey: widget.uniqueKey,
        ),
        PreviousFiles(
          uniqueKey: widget.uniqueKey,
          isInclude: widget.hasIncludeInPdf,
          onRemoveAttachment: widget.onRemoveAttachment,
          onSwtichInclude: widget.onSwtichInclude,
        ),
        CustomLoadingFiles(
          uniqueKey: widget.uniqueKey,
        ),
        CustomRowIcons(
          uniqueKey: widget.uniqueKey,
          hasLibrary: widget.hasLibrary,
          hasCamera: widget.hasCamera,
          hasGallery: widget.hasGallery,
          notesWidget: widget.notesWidget,
          onAddAttachment: widget.onAddAttachment,
        ),
      ],
    );
  }
}
