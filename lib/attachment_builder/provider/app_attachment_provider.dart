import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/domain/models/attachment_file/attachment_model.dart';

import '../../shared/utils/image_utils.dart';

final appAttachmentNotifier = StateNotifierProvider.autoDispose
    .family<CommonAttachmentNotifier, List<AttachmentModel>, String>(
      (ref, id) => CommonAttachmentNotifier(id),
    );

class CommonAttachmentNotifier extends StateNotifier<List<AttachmentModel>> {
  String id;

  CommonAttachmentNotifier(this.id) : super([]);

  /// Add the attachments from server
  /// [attachments] list of attachments from server
  void addAttachmentofServer(List<AttachmentModel> attachments) {
    state = [...state, ...attachments];
  }

  /// Remove the specified attachment from the list of server attachments
  /// [attachmentId] the ID of the attachment to be removed
  void removeCurrentAttachments(String attachmentId) {
    final currentAttachments = state;
    final attachmentExists =
    // ignore: unrelated_type_equality_checks
    currentAttachments.any((attachment) => attachment.id == attachmentId);

    if (attachmentExists) {
      final finalAttachment =
          currentAttachments
              // ignore: unrelated_type_equality_checks
              .where((attachment) => attachment.id != attachmentId)
              .toList();
      state = finalAttachment;
    }
  }

  List<AttachmentModel> getImages() {
    List<AttachmentModel> attachments =
        state
            .where((element) => ImageUtils.isImages(element.mime ?? ''))
            .toList();
    return attachments;
  }

  List<AttachmentModel> getLibrary() {
    return state
        .where((element) => !(ImageUtils.isImages(element.mime ?? '')))
        .toList();
  }
}
