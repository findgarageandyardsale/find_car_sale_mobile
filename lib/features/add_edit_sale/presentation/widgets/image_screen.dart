import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../attachment_builder/image_builder/custom_image_builder.dart';
import '../provider/add_data_provider.dart';

class ImageScreen extends ConsumerWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Provider to watch the document list
    // ref.watch(addDataNotifierProvider.select((value) => value?.attachments));
    void onLoadingFilesChanged(bool isLoading) {
      Future.microtask(() {
        ref.read(loadingFilesProvider('image').notifier).state = isLoading;
      });
    }

    return CustomImageBuilder(
      uniqueKey: 'image',
      hasIncludeInPdf: false,
      hasLibrary: false,
      onAddAttachment: (attachmentList) {
        ref
            .read(addDataNotifierProvider.notifier)
            .addAttachment(attachmentList);
      },
      onLoadingFilesChanged: onLoadingFilesChanged,
      onRemoveAttachment: (attachmentId) {
        ref
            .read(addDataNotifierProvider.notifier)
            .removeAttachment(id: attachmentId);
      },
    );
  }
}
