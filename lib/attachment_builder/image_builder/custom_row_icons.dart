import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/add_edit_sale/presentation/provider/add_data_provider.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';

import '../../features/add_edit_sale/presentation/widgets/custom_icon_title.dart';
import '../../shared/domain/models/attachment_file/attachment_model.dart';
import '../provider/custom_attachment_provider.dart';

class CustomRowIcons extends ConsumerWidget {
  final bool? hasLibrary;
  final bool? hasCamera;
  final bool? hasGallery;
  final Widget? notesWidget;
  final void Function(List<AttachmentModel> attachmentList) onAddAttachment;

  const CustomRowIcons({
    super.key,
    required this.uniqueKey,
    this.hasLibrary = true,
    this.hasCamera = true,
    this.hasGallery = true,
    this.notesWidget,
    required this.onAddAttachment,
  });
  final String uniqueKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (notesWidget != null) notesWidget!,
          if (notesWidget != null) const VerticalDivider(thickness: 1),
          if (hasCamera ?? true)
            CustomIconBtnWithTitleWidget(
              title: 'Camera',
              iconData: Icons.camera_alt_outlined,
              onTap: () async {
                if ((ref.read(addDataNotifierProvider)?.attachments ?? [])
                        .length >
                    9) {
                  CustomToast.showToast(
                    'Your Image Limit has exceed. You can upload only 10 images',
                  );
                } else {
                  ref
                      .read(customAttachmentProvider((uniqueKey)).notifier)
                      .pickFiles(
                        isCamera: true,
                        type: FileType.image,
                        onAddAttachment: onAddAttachment,
                      );
                }
              },
            ),
          if (hasGallery ?? true)
            CustomIconBtnWithTitleWidget(
              title: 'Library',
              iconData: Icons.image_outlined,
              onTap: () async {
                if ((ref.read(addDataNotifierProvider)?.attachments ?? [])
                        .length >
                    9) {
                  CustomToast.showToast(
                    'Your Image Limit has exceed. You can upload only 10 images',
                  );
                } else {
                  ref
                      .read(customAttachmentProvider(uniqueKey).notifier)
                      .pickFiles(
                        isCamera: false,
                        type: FileType.image,
                        onAddAttachment: onAddAttachment,
                      );
                }
              },
            ),
          if (hasLibrary ?? true)
            CustomIconBtnWithTitleWidget(
              title: 'Files',
              iconData: Icons.attach_file_sharp,
              onTap: () async {
                ref
                    .read(customAttachmentProvider(uniqueKey).notifier)
                    .pickFiles(
                      isCamera: false,
                      type: FileType.any,
                      onAddAttachment: onAddAttachment,
                    );
              },
            ),
        ],
      ),
    );
  }
}
