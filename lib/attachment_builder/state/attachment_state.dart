import 'dart:io';
import '../../shared/domain/models/attachment_file/attachment_model.dart';

class AttachmentState {
  bool? isLoading;
  List<File>? localAttachments;
  List<AttachmentModel>? serverAttachments;

  AttachmentState({
    this.isLoading = false,
    this.localAttachments,
    this.serverAttachments,
  });

  AttachmentState copyWith({
    bool? isLoading,
    List<File>? localAttachments,
    List<AttachmentModel>? serverAttachments,
  }) {
    return AttachmentState(
      isLoading: isLoading ?? this.isLoading,
      localAttachments: localAttachments ?? this.localAttachments,
      serverAttachments: serverAttachments ?? this.serverAttachments,
    );
  }
}
